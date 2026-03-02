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

  factory ReactionModel.fromJson(Map<String, dynamic> json) =>
      _$ReactionModelFromJson(json);
}
