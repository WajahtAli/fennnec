import 'package:freezed_annotation/freezed_annotation.dart';

part 'reaction_model.freezed.dart';

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
    return ReactionModel(
      userId: userObj?['_id'] ?? json['userId'] ?? '',
      userName: userObj != null
          ? '${userObj['firstName']} ${userObj['lastName']}'.trim()
          : (json['userName'] ?? ''),
      emoji: json['emoji'] ?? '',
      reactedAt: DateTime.tryParse(json['createdAt'] ?? json['reactedAt'] ?? '') ??
          DateTime.now(),
    );
  }
}
