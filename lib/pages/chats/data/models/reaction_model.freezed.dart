// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reaction_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ReactionModel {

 String get userId; String get userName; String get emoji; DateTime get reactedAt;
/// Create a copy of ReactionModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReactionModelCopyWith<ReactionModel> get copyWith => _$ReactionModelCopyWithImpl<ReactionModel>(this as ReactionModel, _$identity);

  /// Serializes this ReactionModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReactionModel&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.emoji, emoji) || other.emoji == emoji)&&(identical(other.reactedAt, reactedAt) || other.reactedAt == reactedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,userName,emoji,reactedAt);

@override
String toString() {
  return 'ReactionModel(userId: $userId, userName: $userName, emoji: $emoji, reactedAt: $reactedAt)';
}


}

/// @nodoc
abstract mixin class $ReactionModelCopyWith<$Res>  {
  factory $ReactionModelCopyWith(ReactionModel value, $Res Function(ReactionModel) _then) = _$ReactionModelCopyWithImpl;
@useResult
$Res call({
 String userId, String userName, String emoji, DateTime reactedAt
});




}
/// @nodoc
class _$ReactionModelCopyWithImpl<$Res>
    implements $ReactionModelCopyWith<$Res> {
  _$ReactionModelCopyWithImpl(this._self, this._then);

  final ReactionModel _self;
  final $Res Function(ReactionModel) _then;

/// Create a copy of ReactionModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? userName = null,Object? emoji = null,Object? reactedAt = null,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,userName: null == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String,emoji: null == emoji ? _self.emoji : emoji // ignore: cast_nullable_to_non_nullable
as String,reactedAt: null == reactedAt ? _self.reactedAt : reactedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [ReactionModel].
extension ReactionModelPatterns on ReactionModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReactionModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReactionModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReactionModel value)  $default,){
final _that = this;
switch (_that) {
case _ReactionModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReactionModel value)?  $default,){
final _that = this;
switch (_that) {
case _ReactionModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String userId,  String userName,  String emoji,  DateTime reactedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReactionModel() when $default != null:
return $default(_that.userId,_that.userName,_that.emoji,_that.reactedAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String userId,  String userName,  String emoji,  DateTime reactedAt)  $default,) {final _that = this;
switch (_that) {
case _ReactionModel():
return $default(_that.userId,_that.userName,_that.emoji,_that.reactedAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String userId,  String userName,  String emoji,  DateTime reactedAt)?  $default,) {final _that = this;
switch (_that) {
case _ReactionModel() when $default != null:
return $default(_that.userId,_that.userName,_that.emoji,_that.reactedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReactionModel implements ReactionModel {
  const _ReactionModel({required this.userId, required this.userName, required this.emoji, required this.reactedAt});
  factory _ReactionModel.fromJson(Map<String, dynamic> json) => _$ReactionModelFromJson(json);

@override final  String userId;
@override final  String userName;
@override final  String emoji;
@override final  DateTime reactedAt;

/// Create a copy of ReactionModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReactionModelCopyWith<_ReactionModel> get copyWith => __$ReactionModelCopyWithImpl<_ReactionModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReactionModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReactionModel&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.emoji, emoji) || other.emoji == emoji)&&(identical(other.reactedAt, reactedAt) || other.reactedAt == reactedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,userName,emoji,reactedAt);

@override
String toString() {
  return 'ReactionModel(userId: $userId, userName: $userName, emoji: $emoji, reactedAt: $reactedAt)';
}


}

/// @nodoc
abstract mixin class _$ReactionModelCopyWith<$Res> implements $ReactionModelCopyWith<$Res> {
  factory _$ReactionModelCopyWith(_ReactionModel value, $Res Function(_ReactionModel) _then) = __$ReactionModelCopyWithImpl;
@override @useResult
$Res call({
 String userId, String userName, String emoji, DateTime reactedAt
});




}
/// @nodoc
class __$ReactionModelCopyWithImpl<$Res>
    implements _$ReactionModelCopyWith<$Res> {
  __$ReactionModelCopyWithImpl(this._self, this._then);

  final _ReactionModel _self;
  final $Res Function(_ReactionModel) _then;

/// Create a copy of ReactionModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? userName = null,Object? emoji = null,Object? reactedAt = null,}) {
  return _then(_ReactionModel(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,userName: null == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String,emoji: null == emoji ? _self.emoji : emoji // ignore: cast_nullable_to_non_nullable
as String,reactedAt: null == reactedAt ? _self.reactedAt : reactedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
