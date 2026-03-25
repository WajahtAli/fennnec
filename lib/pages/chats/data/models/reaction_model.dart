import 'package:freezed_annotation/freezed_annotation.dart';

part 'reaction_model.freezed.dart';
part 'reaction_model.g.dart';

@freezed
abstract class ReactionModel with _$ReactionModel {
  const factory ReactionModel({
    required String userId,
    required String userName,
    required String emoji,
    required DateTime reactedAt,
  }) = _ReactionModel;

  factory ReactionModel.fromJson(Map<String, dynamic> json) {
    final userObj =
        json['userId'] is Map ? json['userId'] as Map<String, dynamic> : null;
    return _$ReactionModelFromJson({
      ...json,
      'userId': userObj?['_id'] ?? json['userId'],
      'userName': userObj != null
          ? '${userObj['firstName']} ${userObj['lastName']}'.trim()
          : (json['userName'] ?? ''),
      'reactedAt': json['createdAt'] ?? json['reactedAt'],
    });
  }
}
