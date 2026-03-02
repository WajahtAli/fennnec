// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reaction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ReactionModel _$ReactionModelFromJson(Map<String, dynamic> json) =>
    _ReactionModel(
      userId: json['userId'] as String,
      userName: json['userName'] as String,
      emoji: json['emoji'] as String,
      reactedAt: DateTime.parse(json['reactedAt'] as String),
    );

Map<String, dynamic> _$ReactionModelToJson(_ReactionModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'userName': instance.userName,
      'emoji': instance.emoji,
      'reactedAt': instance.reactedAt.toIso8601String(),
    };
