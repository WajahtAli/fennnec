import UIKit
import Flutter
import FirebaseCore
import GoogleMaps
import PushKit
import CallKit
import AVFAudio

@main
@objc class AppDelegate: FlutterAppDelegate, CXProviderDelegate, PKPushRegistryDelegate {

    // MARK: - Variables
    var provider: CXProvider?
    var currentCallUUID: UUID?
    var currentCallData: [String: Any] = [:]
    var methodChannel: FlutterMethodChannel?
    var voipRegistry: PKPushRegistry?
    
    // Buffer for accept action if Flutter is not ready
    var pendingAcceptData: [String: Any]?

    // MARK: - App Launch
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {

        FirebaseApp.configure()
        GMSServices.provideAPIKey("AIzaSyB5c3HBdHGkH3zckdX6dK_6gps2AlMVVkU")

        GeneratedPluginRegistrant.register(with: self)

        setupMethodChannel()
        configureCallKit()
        configurePushKit()

        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    private func setupMethodChannel() {
        if let controller = window?.rootViewController as? FlutterViewController {
            methodChannel = FlutterMethodChannel(
                name: "com.fennec/callkit",
                binaryMessenger: controller.binaryMessenger
            )
            
            methodChannel?.setMethodCallHandler({ [weak self] (call, result) in
                if call.method == "checkPendingAction" {
                    if let pending = self?.pendingAcceptData {
                        result(pending)
                        self?.pendingAcceptData = nil
                    } else {
                        result(nil)
                    }
                } else if call.method == "endCall" || call.method == "finishCall" {
                    self?.endCallAction()
                    result(nil)
                } else {
                    result(FlutterMethodNotImplemented)
                }
            })
        }
    }

    private func endCallAction() {
        guard let uuid = currentCallUUID else { return }
        let endAction = CXEndCallAction(call: uuid)
        let transaction = CXTransaction(action: endAction)
        provider?.reportCall(with: uuid, endedAt: nil, reason: .remoteEnded)
        
        // Use CXCallController to request ending if needed, but reporting ended is often enough for incoming.
        // For standard transaction:
        let controller = CXCallController()
        controller.request(transaction) { error in
            if let error = error {
                print("❌ End call transaction failed: \(error.localizedDescription)")
            }
        }
        currentCallUUID = nil
    }

    // MARK: - CallKit Configuration
    func configureCallKit() {
        let config = CXProviderConfiguration(localizedName: "Fennec App")
        config.supportsVideo = true
        config.includesCallsInRecents = true
        config.supportedHandleTypes = [.generic]
        
        provider = CXProvider(configuration: config)
        provider?.setDelegate(self, queue: nil)
    }

    // MARK: - CXProviderDelegate
    func providerDidReset(_ provider: CXProvider) {
        stopAudioSession()
    }

    func provider(_ provider: CXProvider, perform action: CXAnswerCallAction) {
        configureAudioSession()
        
        var extra: [String: Any] = [:]
        extra["channelName"] = currentCallData["channelName"]
        extra["callRecordId"] = currentCallData["callRecordId"] ?? currentCallData["callId"] ?? currentCallData["_id"]
        extra["mediaType"] = currentCallData["mediaType"]
        extra["imageUrl"] = currentCallData["imageUrl"]

        let acceptPayload: [String: Any] = [
            "id": action.callUUID.uuidString,
            "extra": extra,
            "data": currentCallData
        ]

        if let channel = methodChannel {
            channel.invokeMethod("accept", arguments: acceptPayload)
        } else {
            pendingAcceptData = acceptPayload
        }

        action.fulfill()
    }

    func provider(_ provider: CXProvider, perform action: CXEndCallAction) {
        stopAudioSession()
        methodChannel?.invokeMethod("decline", arguments: ["id": action.callUUID.uuidString])
        action.fulfill()
    }

    func provider(_ provider: CXProvider, didActivate audioSession: AVAudioSession) {
        print("🎙️ Audio session activated by CallKit")
    }

    func provider(_ provider: CXProvider, didDeactivate audioSession: AVAudioSession) {
        print("🎙️ Audio session deactivated by CallKit")
    }

    // MARK: - Audio Session Helpers
    private func configureAudioSession() {
        let session = AVAudioSession.sharedInstance()
        do {
            try session.setCategory(.playAndRecord, mode: .voiceChat, options: [.allowBluetooth, .defaultToSpeaker])
            try session.setActive(true)
            print("🎙️ Audio session configured")
        } catch {
            print("⚠️ Audio session config failed: \(error)")
        }
    }

    private func stopAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setActive(false, options: .notifyOthersOnDeactivation)
        } catch {
            print("⚠️ Failed to deactivate audio session: \(error)")
        }
    }

    // MARK: - PushKit Configuration
    func configurePushKit() {
        voipRegistry = PKPushRegistry(queue: DispatchQueue.main)
        voipRegistry?.delegate = self
        voipRegistry?.desiredPushTypes = [.voIP]
    }

    func pushRegistry(_ registry: PKPushRegistry, didUpdate pushCredentials: PKPushCredentials, for type: PKPushType) {
        let token = pushCredentials.token.map { String(format: "%02x", $0) }.joined()
        print("📱 VoIP Token: \(token)")
    }

    func pushRegistry(_ registry: PKPushRegistry, didReceiveIncomingPushWith payload: PKPushPayload, for type: PKPushType, completion: @escaping () -> Void) {
        let dict = payload.dictionaryPayload
        let data = (dict["data"] as? [String: Any]) ?? (dict["aps"] as? [String: Any]) ?? dict
        reportIncomingCall(with: data, completion: completion)
    }

    // MARK: - FCM Fallback (Optional)
    override func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        let data = (userInfo["data"] as? [String: Any]) ?? (userInfo as? [String: Any]) ?? [:]
        let type = data["type"] as? String
        
        if type == "call_incoming" {
            reportIncomingCall(with: data) {
                completionHandler(.newData)
            }
        } else {
            completionHandler(.noData)
        }
    }

    // MARK: - Report Call
    private func reportIncomingCall(with data: [String: Any], completion: @escaping () -> Void) {
        currentCallData = data
        let callerName = (data["senderName"] as? String) ?? "Incoming Call"
        let isVideo = (data["mediaType"] as? String) == "video"
        let uuid = UUID()
        currentCallUUID = uuid

        let update = CXCallUpdate()
        update.remoteHandle = CXHandle(type: .generic, value: callerName)
        update.hasVideo = isVideo
        update.supportsDTMF = true
        update.supportsHolding = true
        update.supportsGrouping = false
        update.supportsUngrouping = false

        provider?.reportNewIncomingCall(with: uuid, update: update) { [weak self] error in
            if let error = error {
                print("❌ Failed to report incoming call: \(error.localizedDescription)")
            } else {
                print("📞 Call reported: \(callerName)")
            }
            completion()
        }
    }
}
