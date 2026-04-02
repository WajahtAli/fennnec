import UIKit
import Flutter
import FirebaseCore
import GoogleMaps
import PushKit
import CallKit
import AVFAudio

@main
@objc class AppDelegate: FlutterAppDelegate, CXProviderDelegate, PKPushRegistryDelegate {

  // MARK: - CallKit Variables
  var provider: CXProvider?
  var currentCallUUID: UUID?
  var callUpdate: CXCallUpdate?
  var currentCallData: [String: Any] = [:]
  var methodChannel: FlutterMethodChannel?
  var voipRegistry: PKPushRegistry?

  // MARK: - App Launch
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

    // Initialize Firebase and Google Maps
    FirebaseApp.configure()
    GMSServices.provideAPIKey("AIzaSyB5c3HBdHGkH3zckdX6dK_6gps2AlMVVkU")

    GeneratedPluginRegistrant.register(with: self)

    // Bridge for Flutter MethodChannel (for Accept / Decline callbacks)
    if let controller = window?.rootViewController as? FlutterViewController {
      methodChannel = FlutterMethodChannel(
        name: "com.fennec/callkit",
        binaryMessenger: controller.binaryMessenger
      )
    }

    // Setup CallKit & PushKit
    configureCallKit()
    configurePushKit()

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  // MARK: - CallKit Configuration
  func configureCallKit() {
    let config = CXProviderConfiguration(localizedName: "Fennec App")
    config.supportsVideo = true
    config.includesCallsInRecents = true
    config.supportedHandleTypes = [.generic]
    config.iconTemplateImageData = nil // optional custom icon
    // config.ringtoneSound = "ring.caf" // optional custom ringtone

    provider = CXProvider(configuration: config)
    provider?.setDelegate(self, queue: nil)
  }

  // MARK: - CXProviderDelegate Methods
  func provider(_ provider: CXProvider, perform action: CXAnswerCallAction) {
    guard let uuid = currentCallUUID else {
      action.fulfill()
      return
    }
    action.fulfill()
    var extra: [String: Any] = [:]
    extra["channelName"] = currentCallData["channelName"]
    extra["callRecordId"] = currentCallData["callRecordId"] ?? currentCallData["callId"] ?? currentCallData["_id"]
    extra["mediaType"] = currentCallData["mediaType"]
    extra["imageUrl"] = currentCallData["imageUrl"]

    methodChannel?.invokeMethod(
      "accept",
      arguments: [
        "id": uuid.uuidString,
        "extra": extra,
        "data": currentCallData,
      ]
    )
  }

  func provider(_ provider: CXProvider, perform action: CXEndCallAction) {
    action.fulfill()
    if let uuid = currentCallUUID {
      methodChannel?.invokeMethod("decline", arguments: ["id": uuid.uuidString])
    }
  }

  func providerDidReset(_ provider: CXProvider) {}

  // MARK: - PushKit Configuration
  func configurePushKit() {
    voipRegistry = PKPushRegistry(queue: DispatchQueue.main)
    voipRegistry?.delegate = self
    voipRegistry?.desiredPushTypes = [.voIP]
  }

  // MARK: - PKPushRegistryDelegate Methods
  @objc func pushRegistry(
    _ registry: PKPushRegistry,
    didUpdate pushCredentials: PKPushCredentials,
    for type: PKPushType
  ) {
    let token = pushCredentials.token.map { String(format: "%02x", $0) }.joined()
    print("📱 VoIP token: \(token)")
    // TODO: Send token to your backend for user registration
  }

  @objc func pushRegistry(
    _ registry: PKPushRegistry,
    didReceiveIncomingPushWith payload: PKPushPayload,
    for type: PKPushType,
    completion: @escaping () -> Void
  ) {
    // Convert payload safely
    let rawDict = payload.dictionaryPayload
    var dict: [String: Any] = [:]
    for (key, value) in rawDict {
      if let stringKey = key as? String {
        dict[stringKey] = value
      }
    }

    // Parse your custom data fields
    let data = (dict["data"] as? [String: Any]) ?? dict
    reportIncomingCall(with: data) { _ in
      completion()
    }
  }

  override func application(
    _ application: UIApplication,
    didReceiveRemoteNotification userInfo: [AnyHashable : Any],
    fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void
  ) {
    var dict: [String: Any] = [:]
    for (key, value) in userInfo {
      if let stringKey = key as? String {
        dict[stringKey] = value
      }
    }

    let data = (dict["data"] as? [String: Any]) ?? dict
    let type = (data["type"] as? String) ?? (dict["type"] as? String)

    guard type == "call_incoming" else {
      completionHandler(.noData)
      return
    }

    reportIncomingCall(with: data) { success in
      completionHandler(success ? .newData : .failed)
    }
  }

  private func reportIncomingCall(with data: [String: Any], completion: @escaping (Bool) -> Void) {
    currentCallData = data
    let callerName = (data["senderName"] as? String) ?? "Incoming Call"
    let isVideo = ((data["mediaType"] as? String) == "video")

    let uuid = UUID()
    currentCallUUID = uuid

    callUpdate = CXCallUpdate()
    callUpdate?.remoteHandle = CXHandle(type: .generic, value: callerName)
    callUpdate?.supportsDTMF = true
    callUpdate?.supportsHolding = true
    callUpdate?.supportsGrouping = false
    callUpdate?.supportsUngrouping = false
    callUpdate?.hasVideo = isVideo

    do {
      try AVAudioSession.sharedInstance().setCategory(.playAndRecord, options: [.defaultToSpeaker, .allowBluetooth])
      try AVAudioSession.sharedInstance().setActive(true)
    } catch {
      print("⚠️ Audio session error: \(error.localizedDescription)")
    }

    guard let update = callUpdate else {
      completion(false)
      return
    }

    provider?.reportNewIncomingCall(with: uuid, update: update) { error in
      if let error = error {
        print("❌ CallKit report error: \(error.localizedDescription)")
        completion(false)
      } else {
        print("📞 Incoming call from \(callerName)")
        completion(true)
      }
    }
  }
}