class AcceptDeclineInvitationModel {
  bool? success;
  String? message;

  AcceptDeclineInvitationModel({this.success, this.message});

  AcceptDeclineInvitationModel copyWith({bool? success, String? message}) =>
      AcceptDeclineInvitationModel(
        success: success ?? this.success,
        message: message ?? this.message,
      );

  factory AcceptDeclineInvitationModel.fromJson(Map<String, dynamic> json) =>
      AcceptDeclineInvitationModel(
        success: json["success"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {"success": success, "message": message};
}
