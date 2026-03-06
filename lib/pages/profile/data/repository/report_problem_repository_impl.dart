import '../../domain/repository/report_problem_repository.dart';
import '../datasource/report_problem_datasource.dart';

class ReportProblemRepositoryImpl extends ReportProblemRepository {
  final ReportProblemDatasource _datasource;

  ReportProblemRepositoryImpl(this._datasource);

  @override
  Future<dynamic> reportProblem({
    required String subject,
    required String description,
    required List<String> attachments,
  }) async {
    return await _datasource.reportProblem(
      subject: subject,
      description: description,
      attachments: attachments,
    );
  }
}
