import 'package:fennac_app/app/constants/app_constants.dart';
import 'package:fennac_app/core/network/api_helper.dart';

abstract class CallDataSource {
  Future<Map<String, dynamic>> startCall({
    required String mediaType,
    required String callType,
    required List<String> participantIds,
  });
}

class CallDataSourceImpl extends CallDataSource {
  final ApiHelper _apiHelper;

  CallDataSourceImpl(this._apiHelper);

  @override
  Future<Map<String, dynamic>> startCall({
    required String mediaType,
    required String callType,
    required List<String> participantIds,
  }) async {
    try {
      final response = await _apiHelper.post(
        AppConstants.startCall,
        body: {
          'mediaType': mediaType,
          'callType': callType,
          'participantIds': participantIds,
        },
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }
}
