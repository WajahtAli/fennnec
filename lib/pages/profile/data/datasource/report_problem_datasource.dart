import 'package:fennac_app/app/constants/app_constants.dart';
import 'package:fennac_app/core/network/api_helper.dart';

abstract class ReportProblemDatasource {
  Future<dynamic> reportProblem({
    required String subject,
    required String description,
    required List<String> attachments,
  });
}

class ReportProblemDatasourceImpl extends ReportProblemDatasource {
  final ApiHelper apiHelper;

  ReportProblemDatasourceImpl(this.apiHelper);

  @override
  Future<dynamic> reportProblem({
    required String subject,
    required String description,
    required List<String> attachments,
  }) async {
    final body = {
      'subject': subject.trim(),
      'description': description.trim(),
      'attachments': attachments,
    };

    final response = await apiHelper.post(
      AppConstants.reportProblem,
      requiresAuth: true,
      body: body,
    );

    return response;
  }
}
