import 'package:fennac_app/pages/call/data/datasource/call_datasource.dart';
import 'package:fennac_app/pages/call/domain/repository/call_repository.dart';

class CallRepositoryImpl extends CallRepository {
  final CallDataSource _dataSource;

  CallRepositoryImpl(this._dataSource);

  @override
  Future<Map<String, dynamic>> startCall({
    required String mediaType,
    required String callType,
    required List<String> participantIds,
  }) {
    return _dataSource.startCall(
      mediaType: mediaType,
      callType: callType,
      participantIds: participantIds,
    );
  }
}
