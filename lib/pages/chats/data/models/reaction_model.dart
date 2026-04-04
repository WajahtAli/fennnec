import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:fennac_app/utils/validators.dart';

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
    Map<String, dynamic>? mapOrNull(dynamic value) {
      if (value is! Map) return null;
      return Map<String, dynamic>.from(value);
    }

    DateTime parseDate(dynamic primary, dynamic secondary) {
      final parsedPrimary = DateTime.tryParse(validateString(primary));
      if (parsedPrimary != null) return parsedPrimary;

      final parsedSecondary = DateTime.tryParse(validateString(secondary));
      if (parsedSecondary != null) return parsedSecondary;

      return DateTime.now();
    }

    final userObj = mapOrNull(json['userId']);
    final firstName = validateString(userObj?['firstName']).trim();
    final lastName = validateString(userObj?['lastName']).trim();
    final fullName = '$firstName $lastName'.trim();

    return ReactionModel(
      userId: validateString(userObj?['_id']).isNotEmpty
          ? validateString(userObj?['_id'])
          : validateString(json['userId']),
      userName: fullName.isNotEmpty
          ? fullName
          : validateString(json['userName']),
      emoji: validateString(json['emoji']),
      reactedAt: parseDate(json['createdAt'], json['reactedAt']),
    );
  }
}
