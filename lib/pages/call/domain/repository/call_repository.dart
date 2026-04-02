abstract class CallRepository {
  Future<Map<String, dynamic>> startCall({
    required String mediaType,
    required String callType,
    required List<String> participantIds,
  });

  Future<Map<String, dynamic>> endCall({required String callRecordId});
}
