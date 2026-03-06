abstract class ReportProblemRepository {
  Future<dynamic> reportProblem({
    required String subject,
    required String description,
    required List<String> attachments,
  });
}
