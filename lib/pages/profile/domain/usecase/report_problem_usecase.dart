import '../repository/report_problem_repository.dart';

class ReportProblemUsecase {
  final ReportProblemRepository _repository;

  ReportProblemUsecase(this._repository);

  Future<dynamic> reportProblem({
    required String subject,
    required String description,
    required List<String> attachments,
  }) async {
    return await _repository.reportProblem(
      subject: subject,
      description: description,
      attachments: attachments,
    );
  }
}
