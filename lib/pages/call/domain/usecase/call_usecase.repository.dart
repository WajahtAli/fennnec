import 'package:fennac_app/pages/call/domain/repository/call_repository.dart';

class CallUsecase {
  final CallRepository _repository;

  CallUsecase(this._repository);

  Future<Map<String, dynamic>> startCall({
    required String mediaType,
    required String callType,
    required List<String> participantIds,
  }) {
    return _repository.startCall(
      mediaType: mediaType,
      callType: callType,
      participantIds: participantIds,
    );
  }

  Future<Map<String, dynamic>> endCall({required String callRecordId}) {
    return _repository.endCall(callRecordId: callRecordId);
  }
}
