// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_room_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ChatRoom {

 String get id; String get message; String get timeAgo; bool get isGroup;// For individual chats
 String? get name; String? get avatar; bool get isOnline; bool get isPoked;// For group chats
 List<String>? get names; List<String>? get avatars;
/// Create a copy of ChatRoom
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatRoomCopyWith<ChatRoom> get copyWith => _$ChatRoomCopyWithImpl<ChatRoom>(this as ChatRoom, _$identity);

  /// Serializes this ChatRoom to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatRoom&&(identical(other.id, id) || other.id == id)&&(identical(other.message, message) || other.message == message)&&(identical(other.timeAgo, timeAgo) || other.timeAgo == timeAgo)&&(identical(other.isGroup, isGroup) || other.isGroup == isGroup)&&(identical(other.name, name) || other.name == name)&&(identical(other.avatar, avatar) || other.avatar == avatar)&&(identical(other.isOnline, isOnline) || other.isOnline == isOnline)&&(identical(other.isPoked, isPoked) || other.isPoked == isPoked)&&const DeepCollectionEquality().equals(other.names, names)&&const DeepCollectionEquality().equals(other.avatars, avatars));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,message,timeAgo,isGroup,name,avatar,isOnline,isPoked,const DeepCollectionEquality().hash(names),const DeepCollectionEquality().hash(avatars));

@override
String toString() {
  return 'ChatRoom(id: $id, message: $message, timeAgo: $timeAgo, isGroup: $isGroup, name: $name, avatar: $avatar, isOnline: $isOnline, isPoked: $isPoked, names: $names, avatars: $avatars)';
}


}

/// @nodoc
abstract mixin class $ChatRoomCopyWith<$Res>  {
  factory $ChatRoomCopyWith(ChatRoom value, $Res Function(ChatRoom) _then) = _$ChatRoomCopyWithImpl;
@useResult
$Res call({
 String id, String message, String timeAgo, bool isGroup, String? name, String? avatar, bool isOnline, bool isPoked, List<String>? names, List<String>? avatars
});




}
/// @nodoc
class _$ChatRoomCopyWithImpl<$Res>
    implements $ChatRoomCopyWith<$Res> {
  _$ChatRoomCopyWithImpl(this._self, this._then);

  final ChatRoom _self;
  final $Res Function(ChatRoom) _then;

/// Create a copy of ChatRoom
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? message = null,Object? timeAgo = null,Object? isGroup = null,Object? name = freezed,Object? avatar = freezed,Object? isOnline = null,Object? isPoked = null,Object? names = freezed,Object? avatars = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,timeAgo: null == timeAgo ? _self.timeAgo : timeAgo // ignore: cast_nullable_to_non_nullable
as String,isGroup: null == isGroup ? _self.isGroup : isGroup // ignore: cast_nullable_to_non_nullable
as bool,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,avatar: freezed == avatar ? _self.avatar : avatar // ignore: cast_nullable_to_non_nullable
as String?,isOnline: null == isOnline ? _self.isOnline : isOnline // ignore: cast_nullable_to_non_nullable
as bool,isPoked: null == isPoked ? _self.isPoked : isPoked // ignore: cast_nullable_to_non_nullable
as bool,names: freezed == names ? _self.names : names // ignore: cast_nullable_to_non_nullable
as List<String>?,avatars: freezed == avatars ? _self.avatars : avatars // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}

}


/// Adds pattern-matching-related methods to [ChatRoom].
extension ChatRoomPatterns on ChatRoom {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatRoom value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatRoom() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatRoom value)  $default,){
final _that = this;
switch (_that) {
case _ChatRoom():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatRoom value)?  $default,){
final _that = this;
switch (_that) {
case _ChatRoom() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String message,  String timeAgo,  bool isGroup,  String? name,  String? avatar,  bool isOnline,  bool isPoked,  List<String>? names,  List<String>? avatars)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatRoom() when $default != null:
return $default(_that.id,_that.message,_that.timeAgo,_that.isGroup,_that.name,_that.avatar,_that.isOnline,_that.isPoked,_that.names,_that.avatars);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String message,  String timeAgo,  bool isGroup,  String? name,  String? avatar,  bool isOnline,  bool isPoked,  List<String>? names,  List<String>? avatars)  $default,) {final _that = this;
switch (_that) {
case _ChatRoom():
return $default(_that.id,_that.message,_that.timeAgo,_that.isGroup,_that.name,_that.avatar,_that.isOnline,_that.isPoked,_that.names,_that.avatars);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String message,  String timeAgo,  bool isGroup,  String? name,  String? avatar,  bool isOnline,  bool isPoked,  List<String>? names,  List<String>? avatars)?  $default,) {final _that = this;
switch (_that) {
case _ChatRoom() when $default != null:
return $default(_that.id,_that.message,_that.timeAgo,_that.isGroup,_that.name,_that.avatar,_that.isOnline,_that.isPoked,_that.names,_that.avatars);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChatRoom implements ChatRoom {
  const _ChatRoom({required this.id, required this.message, required this.timeAgo, required this.isGroup, this.name, this.avatar, this.isOnline = false, this.isPoked = false, final  List<String>? names, final  List<String>? avatars}): _names = names,_avatars = avatars;
  factory _ChatRoom.fromJson(Map<String, dynamic> json) => _$ChatRoomFromJson(json);

@override final  String id;
@override final  String message;
@override final  String timeAgo;
@override final  bool isGroup;
// For individual chats
@override final  String? name;
@override final  String? avatar;
@override@JsonKey() final  bool isOnline;
@override@JsonKey() final  bool isPoked;
// For group chats
 final  List<String>? _names;
// For group chats
@override List<String>? get names {
  final value = _names;
  if (value == null) return null;
  if (_names is EqualUnmodifiableListView) return _names;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<String>? _avatars;
@override List<String>? get avatars {
  final value = _avatars;
  if (value == null) return null;
  if (_avatars is EqualUnmodifiableListView) return _avatars;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of ChatRoom
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatRoomCopyWith<_ChatRoom> get copyWith => __$ChatRoomCopyWithImpl<_ChatRoom>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChatRoomToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatRoom&&(identical(other.id, id) || other.id == id)&&(identical(other.message, message) || other.message == message)&&(identical(other.timeAgo, timeAgo) || other.timeAgo == timeAgo)&&(identical(other.isGroup, isGroup) || other.isGroup == isGroup)&&(identical(other.name, name) || other.name == name)&&(identical(other.avatar, avatar) || other.avatar == avatar)&&(identical(other.isOnline, isOnline) || other.isOnline == isOnline)&&(identical(other.isPoked, isPoked) || other.isPoked == isPoked)&&const DeepCollectionEquality().equals(other._names, _names)&&const DeepCollectionEquality().equals(other._avatars, _avatars));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,message,timeAgo,isGroup,name,avatar,isOnline,isPoked,const DeepCollectionEquality().hash(_names),const DeepCollectionEquality().hash(_avatars));

@override
String toString() {
  return 'ChatRoom(id: $id, message: $message, timeAgo: $timeAgo, isGroup: $isGroup, name: $name, avatar: $avatar, isOnline: $isOnline, isPoked: $isPoked, names: $names, avatars: $avatars)';
}


}

/// @nodoc
abstract mixin class _$ChatRoomCopyWith<$Res> implements $ChatRoomCopyWith<$Res> {
  factory _$ChatRoomCopyWith(_ChatRoom value, $Res Function(_ChatRoom) _then) = __$ChatRoomCopyWithImpl;
@override @useResult
$Res call({
 String id, String message, String timeAgo, bool isGroup, String? name, String? avatar, bool isOnline, bool isPoked, List<String>? names, List<String>? avatars
});




}
/// @nodoc
class __$ChatRoomCopyWithImpl<$Res>
    implements _$ChatRoomCopyWith<$Res> {
  __$ChatRoomCopyWithImpl(this._self, this._then);

  final _ChatRoom _self;
  final $Res Function(_ChatRoom) _then;

/// Create a copy of ChatRoom
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? message = null,Object? timeAgo = null,Object? isGroup = null,Object? name = freezed,Object? avatar = freezed,Object? isOnline = null,Object? isPoked = null,Object? names = freezed,Object? avatars = freezed,}) {
  return _then(_ChatRoom(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,timeAgo: null == timeAgo ? _self.timeAgo : timeAgo // ignore: cast_nullable_to_non_nullable
as String,isGroup: null == isGroup ? _self.isGroup : isGroup // ignore: cast_nullable_to_non_nullable
as bool,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,avatar: freezed == avatar ? _self.avatar : avatar // ignore: cast_nullable_to_non_nullable
as String?,isOnline: null == isOnline ? _self.isOnline : isOnline // ignore: cast_nullable_to_non_nullable
as bool,isPoked: null == isPoked ? _self.isPoked : isPoked // ignore: cast_nullable_to_non_nullable
as bool,names: freezed == names ? _self._names : names // ignore: cast_nullable_to_non_nullable
as List<String>?,avatars: freezed == avatars ? _self._avatars : avatars // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}


}

// dart format on
