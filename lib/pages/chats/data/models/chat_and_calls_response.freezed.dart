// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_and_calls_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ChatAndCallsResponse {

 bool get success; String get message; ChatAndCallsData get data;
/// Create a copy of ChatAndCallsResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatAndCallsResponseCopyWith<ChatAndCallsResponse> get copyWith => _$ChatAndCallsResponseCopyWithImpl<ChatAndCallsResponse>(this as ChatAndCallsResponse, _$identity);

  /// Serializes this ChatAndCallsResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatAndCallsResponse&&(identical(other.success, success) || other.success == success)&&(identical(other.message, message) || other.message == message)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,message,data);

@override
String toString() {
  return 'ChatAndCallsResponse(success: $success, message: $message, data: $data)';
}


}

/// @nodoc
abstract mixin class $ChatAndCallsResponseCopyWith<$Res>  {
  factory $ChatAndCallsResponseCopyWith(ChatAndCallsResponse value, $Res Function(ChatAndCallsResponse) _then) = _$ChatAndCallsResponseCopyWithImpl;
@useResult
$Res call({
 bool success, String message, ChatAndCallsData data
});


$ChatAndCallsDataCopyWith<$Res> get data;

}
/// @nodoc
class _$ChatAndCallsResponseCopyWithImpl<$Res>
    implements $ChatAndCallsResponseCopyWith<$Res> {
  _$ChatAndCallsResponseCopyWithImpl(this._self, this._then);

  final ChatAndCallsResponse _self;
  final $Res Function(ChatAndCallsResponse) _then;

/// Create a copy of ChatAndCallsResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? success = null,Object? message = null,Object? data = null,}) {
  return _then(_self.copyWith(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as ChatAndCallsData,
  ));
}
/// Create a copy of ChatAndCallsResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ChatAndCallsDataCopyWith<$Res> get data {
  
  return $ChatAndCallsDataCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// Adds pattern-matching-related methods to [ChatAndCallsResponse].
extension ChatAndCallsResponsePatterns on ChatAndCallsResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatAndCallsResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatAndCallsResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatAndCallsResponse value)  $default,){
final _that = this;
switch (_that) {
case _ChatAndCallsResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatAndCallsResponse value)?  $default,){
final _that = this;
switch (_that) {
case _ChatAndCallsResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool success,  String message,  ChatAndCallsData data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatAndCallsResponse() when $default != null:
return $default(_that.success,_that.message,_that.data);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool success,  String message,  ChatAndCallsData data)  $default,) {final _that = this;
switch (_that) {
case _ChatAndCallsResponse():
return $default(_that.success,_that.message,_that.data);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool success,  String message,  ChatAndCallsData data)?  $default,) {final _that = this;
switch (_that) {
case _ChatAndCallsResponse() when $default != null:
return $default(_that.success,_that.message,_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChatAndCallsResponse implements ChatAndCallsResponse {
  const _ChatAndCallsResponse({required this.success, required this.message, required this.data});
  factory _ChatAndCallsResponse.fromJson(Map<String, dynamic> json) => _$ChatAndCallsResponseFromJson(json);

@override final  bool success;
@override final  String message;
@override final  ChatAndCallsData data;

/// Create a copy of ChatAndCallsResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatAndCallsResponseCopyWith<_ChatAndCallsResponse> get copyWith => __$ChatAndCallsResponseCopyWithImpl<_ChatAndCallsResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChatAndCallsResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatAndCallsResponse&&(identical(other.success, success) || other.success == success)&&(identical(other.message, message) || other.message == message)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,message,data);

@override
String toString() {
  return 'ChatAndCallsResponse(success: $success, message: $message, data: $data)';
}


}

/// @nodoc
abstract mixin class _$ChatAndCallsResponseCopyWith<$Res> implements $ChatAndCallsResponseCopyWith<$Res> {
  factory _$ChatAndCallsResponseCopyWith(_ChatAndCallsResponse value, $Res Function(_ChatAndCallsResponse) _then) = __$ChatAndCallsResponseCopyWithImpl;
@override @useResult
$Res call({
 bool success, String message, ChatAndCallsData data
});


@override $ChatAndCallsDataCopyWith<$Res> get data;

}
/// @nodoc
class __$ChatAndCallsResponseCopyWithImpl<$Res>
    implements _$ChatAndCallsResponseCopyWith<$Res> {
  __$ChatAndCallsResponseCopyWithImpl(this._self, this._then);

  final _ChatAndCallsResponse _self;
  final $Res Function(_ChatAndCallsResponse) _then;

/// Create a copy of ChatAndCallsResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? success = null,Object? message = null,Object? data = null,}) {
  return _then(_ChatAndCallsResponse(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as ChatAndCallsData,
  ));
}

/// Create a copy of ChatAndCallsResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ChatAndCallsDataCopyWith<$Res> get data {
  
  return $ChatAndCallsDataCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// @nodoc
mixin _$ChatAndCallsData {

 List<ChatModel> get chats; List<CallModel> get calls; PaginationModel get pagination;
/// Create a copy of ChatAndCallsData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatAndCallsDataCopyWith<ChatAndCallsData> get copyWith => _$ChatAndCallsDataCopyWithImpl<ChatAndCallsData>(this as ChatAndCallsData, _$identity);

  /// Serializes this ChatAndCallsData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatAndCallsData&&const DeepCollectionEquality().equals(other.chats, chats)&&const DeepCollectionEquality().equals(other.calls, calls)&&(identical(other.pagination, pagination) || other.pagination == pagination));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(chats),const DeepCollectionEquality().hash(calls),pagination);

@override
String toString() {
  return 'ChatAndCallsData(chats: $chats, calls: $calls, pagination: $pagination)';
}


}

/// @nodoc
abstract mixin class $ChatAndCallsDataCopyWith<$Res>  {
  factory $ChatAndCallsDataCopyWith(ChatAndCallsData value, $Res Function(ChatAndCallsData) _then) = _$ChatAndCallsDataCopyWithImpl;
@useResult
$Res call({
 List<ChatModel> chats, List<CallModel> calls, PaginationModel pagination
});


$PaginationModelCopyWith<$Res> get pagination;

}
/// @nodoc
class _$ChatAndCallsDataCopyWithImpl<$Res>
    implements $ChatAndCallsDataCopyWith<$Res> {
  _$ChatAndCallsDataCopyWithImpl(this._self, this._then);

  final ChatAndCallsData _self;
  final $Res Function(ChatAndCallsData) _then;

/// Create a copy of ChatAndCallsData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? chats = null,Object? calls = null,Object? pagination = null,}) {
  return _then(_self.copyWith(
chats: null == chats ? _self.chats : chats // ignore: cast_nullable_to_non_nullable
as List<ChatModel>,calls: null == calls ? _self.calls : calls // ignore: cast_nullable_to_non_nullable
as List<CallModel>,pagination: null == pagination ? _self.pagination : pagination // ignore: cast_nullable_to_non_nullable
as PaginationModel,
  ));
}
/// Create a copy of ChatAndCallsData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PaginationModelCopyWith<$Res> get pagination {
  
  return $PaginationModelCopyWith<$Res>(_self.pagination, (value) {
    return _then(_self.copyWith(pagination: value));
  });
}
}


/// Adds pattern-matching-related methods to [ChatAndCallsData].
extension ChatAndCallsDataPatterns on ChatAndCallsData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatAndCallsData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatAndCallsData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatAndCallsData value)  $default,){
final _that = this;
switch (_that) {
case _ChatAndCallsData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatAndCallsData value)?  $default,){
final _that = this;
switch (_that) {
case _ChatAndCallsData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<ChatModel> chats,  List<CallModel> calls,  PaginationModel pagination)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatAndCallsData() when $default != null:
return $default(_that.chats,_that.calls,_that.pagination);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<ChatModel> chats,  List<CallModel> calls,  PaginationModel pagination)  $default,) {final _that = this;
switch (_that) {
case _ChatAndCallsData():
return $default(_that.chats,_that.calls,_that.pagination);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<ChatModel> chats,  List<CallModel> calls,  PaginationModel pagination)?  $default,) {final _that = this;
switch (_that) {
case _ChatAndCallsData() when $default != null:
return $default(_that.chats,_that.calls,_that.pagination);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChatAndCallsData implements ChatAndCallsData {
  const _ChatAndCallsData({required final  List<ChatModel> chats, required final  List<CallModel> calls, required this.pagination}): _chats = chats,_calls = calls;
  factory _ChatAndCallsData.fromJson(Map<String, dynamic> json) => _$ChatAndCallsDataFromJson(json);

 final  List<ChatModel> _chats;
@override List<ChatModel> get chats {
  if (_chats is EqualUnmodifiableListView) return _chats;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_chats);
}

 final  List<CallModel> _calls;
@override List<CallModel> get calls {
  if (_calls is EqualUnmodifiableListView) return _calls;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_calls);
}

@override final  PaginationModel pagination;

/// Create a copy of ChatAndCallsData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatAndCallsDataCopyWith<_ChatAndCallsData> get copyWith => __$ChatAndCallsDataCopyWithImpl<_ChatAndCallsData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChatAndCallsDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatAndCallsData&&const DeepCollectionEquality().equals(other._chats, _chats)&&const DeepCollectionEquality().equals(other._calls, _calls)&&(identical(other.pagination, pagination) || other.pagination == pagination));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_chats),const DeepCollectionEquality().hash(_calls),pagination);

@override
String toString() {
  return 'ChatAndCallsData(chats: $chats, calls: $calls, pagination: $pagination)';
}


}

/// @nodoc
abstract mixin class _$ChatAndCallsDataCopyWith<$Res> implements $ChatAndCallsDataCopyWith<$Res> {
  factory _$ChatAndCallsDataCopyWith(_ChatAndCallsData value, $Res Function(_ChatAndCallsData) _then) = __$ChatAndCallsDataCopyWithImpl;
@override @useResult
$Res call({
 List<ChatModel> chats, List<CallModel> calls, PaginationModel pagination
});


@override $PaginationModelCopyWith<$Res> get pagination;

}
/// @nodoc
class __$ChatAndCallsDataCopyWithImpl<$Res>
    implements _$ChatAndCallsDataCopyWith<$Res> {
  __$ChatAndCallsDataCopyWithImpl(this._self, this._then);

  final _ChatAndCallsData _self;
  final $Res Function(_ChatAndCallsData) _then;

/// Create a copy of ChatAndCallsData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? chats = null,Object? calls = null,Object? pagination = null,}) {
  return _then(_ChatAndCallsData(
chats: null == chats ? _self._chats : chats // ignore: cast_nullable_to_non_nullable
as List<ChatModel>,calls: null == calls ? _self._calls : calls // ignore: cast_nullable_to_non_nullable
as List<CallModel>,pagination: null == pagination ? _self.pagination : pagination // ignore: cast_nullable_to_non_nullable
as PaginationModel,
  ));
}

/// Create a copy of ChatAndCallsData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PaginationModelCopyWith<$Res> get pagination {
  
  return $PaginationModelCopyWith<$Res>(_self.pagination, (value) {
    return _then(_self.copyWith(pagination: value));
  });
}
}


/// @nodoc
mixin _$ChatModel {

 String get type; String get id; String get name; String get image; String get lastMessage; DateTime? get lastMessageAt; int get unreadCount; Map<String, dynamic> get meta; List<MemberModel>? get members;
/// Create a copy of ChatModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatModelCopyWith<ChatModel> get copyWith => _$ChatModelCopyWithImpl<ChatModel>(this as ChatModel, _$identity);

  /// Serializes this ChatModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatModel&&(identical(other.type, type) || other.type == type)&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.image, image) || other.image == image)&&(identical(other.lastMessage, lastMessage) || other.lastMessage == lastMessage)&&(identical(other.lastMessageAt, lastMessageAt) || other.lastMessageAt == lastMessageAt)&&(identical(other.unreadCount, unreadCount) || other.unreadCount == unreadCount)&&const DeepCollectionEquality().equals(other.meta, meta)&&const DeepCollectionEquality().equals(other.members, members));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,id,name,image,lastMessage,lastMessageAt,unreadCount,const DeepCollectionEquality().hash(meta),const DeepCollectionEquality().hash(members));

@override
String toString() {
  return 'ChatModel(type: $type, id: $id, name: $name, image: $image, lastMessage: $lastMessage, lastMessageAt: $lastMessageAt, unreadCount: $unreadCount, meta: $meta, members: $members)';
}


}

/// @nodoc
abstract mixin class $ChatModelCopyWith<$Res>  {
  factory $ChatModelCopyWith(ChatModel value, $Res Function(ChatModel) _then) = _$ChatModelCopyWithImpl;
@useResult
$Res call({
 String type, String id, String name, String image, String lastMessage, DateTime? lastMessageAt, int unreadCount, Map<String, dynamic> meta, List<MemberModel>? members
});




}
/// @nodoc
class _$ChatModelCopyWithImpl<$Res>
    implements $ChatModelCopyWith<$Res> {
  _$ChatModelCopyWithImpl(this._self, this._then);

  final ChatModel _self;
  final $Res Function(ChatModel) _then;

/// Create a copy of ChatModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? id = null,Object? name = null,Object? image = null,Object? lastMessage = null,Object? lastMessageAt = freezed,Object? unreadCount = null,Object? meta = null,Object? members = freezed,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,image: null == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String,lastMessage: null == lastMessage ? _self.lastMessage : lastMessage // ignore: cast_nullable_to_non_nullable
as String,lastMessageAt: freezed == lastMessageAt ? _self.lastMessageAt : lastMessageAt // ignore: cast_nullable_to_non_nullable
as DateTime?,unreadCount: null == unreadCount ? _self.unreadCount : unreadCount // ignore: cast_nullable_to_non_nullable
as int,meta: null == meta ? _self.meta : meta // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,members: freezed == members ? _self.members : members // ignore: cast_nullable_to_non_nullable
as List<MemberModel>?,
  ));
}

}


/// Adds pattern-matching-related methods to [ChatModel].
extension ChatModelPatterns on ChatModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatModel value)  $default,){
final _that = this;
switch (_that) {
case _ChatModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatModel value)?  $default,){
final _that = this;
switch (_that) {
case _ChatModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String type,  String id,  String name,  String image,  String lastMessage,  DateTime? lastMessageAt,  int unreadCount,  Map<String, dynamic> meta,  List<MemberModel>? members)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatModel() when $default != null:
return $default(_that.type,_that.id,_that.name,_that.image,_that.lastMessage,_that.lastMessageAt,_that.unreadCount,_that.meta,_that.members);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String type,  String id,  String name,  String image,  String lastMessage,  DateTime? lastMessageAt,  int unreadCount,  Map<String, dynamic> meta,  List<MemberModel>? members)  $default,) {final _that = this;
switch (_that) {
case _ChatModel():
return $default(_that.type,_that.id,_that.name,_that.image,_that.lastMessage,_that.lastMessageAt,_that.unreadCount,_that.meta,_that.members);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String type,  String id,  String name,  String image,  String lastMessage,  DateTime? lastMessageAt,  int unreadCount,  Map<String, dynamic> meta,  List<MemberModel>? members)?  $default,) {final _that = this;
switch (_that) {
case _ChatModel() when $default != null:
return $default(_that.type,_that.id,_that.name,_that.image,_that.lastMessage,_that.lastMessageAt,_that.unreadCount,_that.meta,_that.members);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChatModel implements ChatModel {
  const _ChatModel({required this.type, required this.id, required this.name, this.image = '', this.lastMessage = '', this.lastMessageAt, required this.unreadCount, required final  Map<String, dynamic> meta, final  List<MemberModel>? members}): _meta = meta,_members = members;
  factory _ChatModel.fromJson(Map<String, dynamic> json) => _$ChatModelFromJson(json);

@override final  String type;
@override final  String id;
@override final  String name;
@override@JsonKey() final  String image;
@override@JsonKey() final  String lastMessage;
@override final  DateTime? lastMessageAt;
@override final  int unreadCount;
 final  Map<String, dynamic> _meta;
@override Map<String, dynamic> get meta {
  if (_meta is EqualUnmodifiableMapView) return _meta;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_meta);
}

 final  List<MemberModel>? _members;
@override List<MemberModel>? get members {
  final value = _members;
  if (value == null) return null;
  if (_members is EqualUnmodifiableListView) return _members;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of ChatModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatModelCopyWith<_ChatModel> get copyWith => __$ChatModelCopyWithImpl<_ChatModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChatModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatModel&&(identical(other.type, type) || other.type == type)&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.image, image) || other.image == image)&&(identical(other.lastMessage, lastMessage) || other.lastMessage == lastMessage)&&(identical(other.lastMessageAt, lastMessageAt) || other.lastMessageAt == lastMessageAt)&&(identical(other.unreadCount, unreadCount) || other.unreadCount == unreadCount)&&const DeepCollectionEquality().equals(other._meta, _meta)&&const DeepCollectionEquality().equals(other._members, _members));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,id,name,image,lastMessage,lastMessageAt,unreadCount,const DeepCollectionEquality().hash(_meta),const DeepCollectionEquality().hash(_members));

@override
String toString() {
  return 'ChatModel(type: $type, id: $id, name: $name, image: $image, lastMessage: $lastMessage, lastMessageAt: $lastMessageAt, unreadCount: $unreadCount, meta: $meta, members: $members)';
}


}

/// @nodoc
abstract mixin class _$ChatModelCopyWith<$Res> implements $ChatModelCopyWith<$Res> {
  factory _$ChatModelCopyWith(_ChatModel value, $Res Function(_ChatModel) _then) = __$ChatModelCopyWithImpl;
@override @useResult
$Res call({
 String type, String id, String name, String image, String lastMessage, DateTime? lastMessageAt, int unreadCount, Map<String, dynamic> meta, List<MemberModel>? members
});




}
/// @nodoc
class __$ChatModelCopyWithImpl<$Res>
    implements _$ChatModelCopyWith<$Res> {
  __$ChatModelCopyWithImpl(this._self, this._then);

  final _ChatModel _self;
  final $Res Function(_ChatModel) _then;

/// Create a copy of ChatModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? id = null,Object? name = null,Object? image = null,Object? lastMessage = null,Object? lastMessageAt = freezed,Object? unreadCount = null,Object? meta = null,Object? members = freezed,}) {
  return _then(_ChatModel(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,image: null == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String,lastMessage: null == lastMessage ? _self.lastMessage : lastMessage // ignore: cast_nullable_to_non_nullable
as String,lastMessageAt: freezed == lastMessageAt ? _self.lastMessageAt : lastMessageAt // ignore: cast_nullable_to_non_nullable
as DateTime?,unreadCount: null == unreadCount ? _self.unreadCount : unreadCount // ignore: cast_nullable_to_non_nullable
as int,meta: null == meta ? _self._meta : meta // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,members: freezed == members ? _self._members : members // ignore: cast_nullable_to_non_nullable
as List<MemberModel>?,
  ));
}


}


/// @nodoc
mixin _$MemberModel {

 String get id; String get name; String get image;
/// Create a copy of MemberModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MemberModelCopyWith<MemberModel> get copyWith => _$MemberModelCopyWithImpl<MemberModel>(this as MemberModel, _$identity);

  /// Serializes this MemberModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MemberModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.image, image) || other.image == image));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,image);

@override
String toString() {
  return 'MemberModel(id: $id, name: $name, image: $image)';
}


}

/// @nodoc
abstract mixin class $MemberModelCopyWith<$Res>  {
  factory $MemberModelCopyWith(MemberModel value, $Res Function(MemberModel) _then) = _$MemberModelCopyWithImpl;
@useResult
$Res call({
 String id, String name, String image
});




}
/// @nodoc
class _$MemberModelCopyWithImpl<$Res>
    implements $MemberModelCopyWith<$Res> {
  _$MemberModelCopyWithImpl(this._self, this._then);

  final MemberModel _self;
  final $Res Function(MemberModel) _then;

/// Create a copy of MemberModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? image = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,image: null == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [MemberModel].
extension MemberModelPatterns on MemberModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MemberModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MemberModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MemberModel value)  $default,){
final _that = this;
switch (_that) {
case _MemberModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MemberModel value)?  $default,){
final _that = this;
switch (_that) {
case _MemberModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String image)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MemberModel() when $default != null:
return $default(_that.id,_that.name,_that.image);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String image)  $default,) {final _that = this;
switch (_that) {
case _MemberModel():
return $default(_that.id,_that.name,_that.image);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String image)?  $default,) {final _that = this;
switch (_that) {
case _MemberModel() when $default != null:
return $default(_that.id,_that.name,_that.image);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MemberModel implements MemberModel {
  const _MemberModel({required this.id, required this.name, required this.image});
  factory _MemberModel.fromJson(Map<String, dynamic> json) => _$MemberModelFromJson(json);

@override final  String id;
@override final  String name;
@override final  String image;

/// Create a copy of MemberModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MemberModelCopyWith<_MemberModel> get copyWith => __$MemberModelCopyWithImpl<_MemberModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MemberModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MemberModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.image, image) || other.image == image));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,image);

@override
String toString() {
  return 'MemberModel(id: $id, name: $name, image: $image)';
}


}

/// @nodoc
abstract mixin class _$MemberModelCopyWith<$Res> implements $MemberModelCopyWith<$Res> {
  factory _$MemberModelCopyWith(_MemberModel value, $Res Function(_MemberModel) _then) = __$MemberModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String image
});




}
/// @nodoc
class __$MemberModelCopyWithImpl<$Res>
    implements _$MemberModelCopyWith<$Res> {
  __$MemberModelCopyWithImpl(this._self, this._then);

  final _MemberModel _self;
  final $Res Function(_MemberModel) _then;

/// Create a copy of MemberModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? image = null,}) {
  return _then(_MemberModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,image: null == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$CallModel {

 String get id; String? get name; String? get image; List<MemberModel>? get members; String? get callTypeLabel; String? get duration; String? get timeAgo; String? get status;
/// Create a copy of CallModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CallModelCopyWith<CallModel> get copyWith => _$CallModelCopyWithImpl<CallModel>(this as CallModel, _$identity);

  /// Serializes this CallModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CallModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.image, image) || other.image == image)&&const DeepCollectionEquality().equals(other.members, members)&&(identical(other.callTypeLabel, callTypeLabel) || other.callTypeLabel == callTypeLabel)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.timeAgo, timeAgo) || other.timeAgo == timeAgo)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,image,const DeepCollectionEquality().hash(members),callTypeLabel,duration,timeAgo,status);

@override
String toString() {
  return 'CallModel(id: $id, name: $name, image: $image, members: $members, callTypeLabel: $callTypeLabel, duration: $duration, timeAgo: $timeAgo, status: $status)';
}


}

/// @nodoc
abstract mixin class $CallModelCopyWith<$Res>  {
  factory $CallModelCopyWith(CallModel value, $Res Function(CallModel) _then) = _$CallModelCopyWithImpl;
@useResult
$Res call({
 String id, String? name, String? image, List<MemberModel>? members, String? callTypeLabel, String? duration, String? timeAgo, String? status
});




}
/// @nodoc
class _$CallModelCopyWithImpl<$Res>
    implements $CallModelCopyWith<$Res> {
  _$CallModelCopyWithImpl(this._self, this._then);

  final CallModel _self;
  final $Res Function(CallModel) _then;

/// Create a copy of CallModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = freezed,Object? image = freezed,Object? members = freezed,Object? callTypeLabel = freezed,Object? duration = freezed,Object? timeAgo = freezed,Object? status = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String?,members: freezed == members ? _self.members : members // ignore: cast_nullable_to_non_nullable
as List<MemberModel>?,callTypeLabel: freezed == callTypeLabel ? _self.callTypeLabel : callTypeLabel // ignore: cast_nullable_to_non_nullable
as String?,duration: freezed == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as String?,timeAgo: freezed == timeAgo ? _self.timeAgo : timeAgo // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CallModel].
extension CallModelPatterns on CallModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CallModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CallModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CallModel value)  $default,){
final _that = this;
switch (_that) {
case _CallModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CallModel value)?  $default,){
final _that = this;
switch (_that) {
case _CallModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String? name,  String? image,  List<MemberModel>? members,  String? callTypeLabel,  String? duration,  String? timeAgo,  String? status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CallModel() when $default != null:
return $default(_that.id,_that.name,_that.image,_that.members,_that.callTypeLabel,_that.duration,_that.timeAgo,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String? name,  String? image,  List<MemberModel>? members,  String? callTypeLabel,  String? duration,  String? timeAgo,  String? status)  $default,) {final _that = this;
switch (_that) {
case _CallModel():
return $default(_that.id,_that.name,_that.image,_that.members,_that.callTypeLabel,_that.duration,_that.timeAgo,_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String? name,  String? image,  List<MemberModel>? members,  String? callTypeLabel,  String? duration,  String? timeAgo,  String? status)?  $default,) {final _that = this;
switch (_that) {
case _CallModel() when $default != null:
return $default(_that.id,_that.name,_that.image,_that.members,_that.callTypeLabel,_that.duration,_that.timeAgo,_that.status);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CallModel implements CallModel {
  const _CallModel({required this.id, this.name, this.image, final  List<MemberModel>? members, this.callTypeLabel, this.duration, this.timeAgo, this.status}): _members = members;
  factory _CallModel.fromJson(Map<String, dynamic> json) => _$CallModelFromJson(json);

@override final  String id;
@override final  String? name;
@override final  String? image;
 final  List<MemberModel>? _members;
@override List<MemberModel>? get members {
  final value = _members;
  if (value == null) return null;
  if (_members is EqualUnmodifiableListView) return _members;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  String? callTypeLabel;
@override final  String? duration;
@override final  String? timeAgo;
@override final  String? status;

/// Create a copy of CallModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CallModelCopyWith<_CallModel> get copyWith => __$CallModelCopyWithImpl<_CallModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CallModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CallModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.image, image) || other.image == image)&&const DeepCollectionEquality().equals(other._members, _members)&&(identical(other.callTypeLabel, callTypeLabel) || other.callTypeLabel == callTypeLabel)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.timeAgo, timeAgo) || other.timeAgo == timeAgo)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,image,const DeepCollectionEquality().hash(_members),callTypeLabel,duration,timeAgo,status);

@override
String toString() {
  return 'CallModel(id: $id, name: $name, image: $image, members: $members, callTypeLabel: $callTypeLabel, duration: $duration, timeAgo: $timeAgo, status: $status)';
}


}

/// @nodoc
abstract mixin class _$CallModelCopyWith<$Res> implements $CallModelCopyWith<$Res> {
  factory _$CallModelCopyWith(_CallModel value, $Res Function(_CallModel) _then) = __$CallModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String? name, String? image, List<MemberModel>? members, String? callTypeLabel, String? duration, String? timeAgo, String? status
});




}
/// @nodoc
class __$CallModelCopyWithImpl<$Res>
    implements _$CallModelCopyWith<$Res> {
  __$CallModelCopyWithImpl(this._self, this._then);

  final _CallModel _self;
  final $Res Function(_CallModel) _then;

/// Create a copy of CallModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = freezed,Object? image = freezed,Object? members = freezed,Object? callTypeLabel = freezed,Object? duration = freezed,Object? timeAgo = freezed,Object? status = freezed,}) {
  return _then(_CallModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String?,members: freezed == members ? _self._members : members // ignore: cast_nullable_to_non_nullable
as List<MemberModel>?,callTypeLabel: freezed == callTypeLabel ? _self.callTypeLabel : callTypeLabel // ignore: cast_nullable_to_non_nullable
as String?,duration: freezed == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as String?,timeAgo: freezed == timeAgo ? _self.timeAgo : timeAgo // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$PaginationModel {

 int get page; int get limit; int get totalChats; int get totalCalls;
/// Create a copy of PaginationModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaginationModelCopyWith<PaginationModel> get copyWith => _$PaginationModelCopyWithImpl<PaginationModel>(this as PaginationModel, _$identity);

  /// Serializes this PaginationModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaginationModel&&(identical(other.page, page) || other.page == page)&&(identical(other.limit, limit) || other.limit == limit)&&(identical(other.totalChats, totalChats) || other.totalChats == totalChats)&&(identical(other.totalCalls, totalCalls) || other.totalCalls == totalCalls));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,page,limit,totalChats,totalCalls);

@override
String toString() {
  return 'PaginationModel(page: $page, limit: $limit, totalChats: $totalChats, totalCalls: $totalCalls)';
}


}

/// @nodoc
abstract mixin class $PaginationModelCopyWith<$Res>  {
  factory $PaginationModelCopyWith(PaginationModel value, $Res Function(PaginationModel) _then) = _$PaginationModelCopyWithImpl;
@useResult
$Res call({
 int page, int limit, int totalChats, int totalCalls
});




}
/// @nodoc
class _$PaginationModelCopyWithImpl<$Res>
    implements $PaginationModelCopyWith<$Res> {
  _$PaginationModelCopyWithImpl(this._self, this._then);

  final PaginationModel _self;
  final $Res Function(PaginationModel) _then;

/// Create a copy of PaginationModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? page = null,Object? limit = null,Object? totalChats = null,Object? totalCalls = null,}) {
  return _then(_self.copyWith(
page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,limit: null == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as int,totalChats: null == totalChats ? _self.totalChats : totalChats // ignore: cast_nullable_to_non_nullable
as int,totalCalls: null == totalCalls ? _self.totalCalls : totalCalls // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [PaginationModel].
extension PaginationModelPatterns on PaginationModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PaginationModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PaginationModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PaginationModel value)  $default,){
final _that = this;
switch (_that) {
case _PaginationModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PaginationModel value)?  $default,){
final _that = this;
switch (_that) {
case _PaginationModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int page,  int limit,  int totalChats,  int totalCalls)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PaginationModel() when $default != null:
return $default(_that.page,_that.limit,_that.totalChats,_that.totalCalls);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int page,  int limit,  int totalChats,  int totalCalls)  $default,) {final _that = this;
switch (_that) {
case _PaginationModel():
return $default(_that.page,_that.limit,_that.totalChats,_that.totalCalls);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int page,  int limit,  int totalChats,  int totalCalls)?  $default,) {final _that = this;
switch (_that) {
case _PaginationModel() when $default != null:
return $default(_that.page,_that.limit,_that.totalChats,_that.totalCalls);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PaginationModel implements PaginationModel {
  const _PaginationModel({required this.page, required this.limit, required this.totalChats, required this.totalCalls});
  factory _PaginationModel.fromJson(Map<String, dynamic> json) => _$PaginationModelFromJson(json);

@override final  int page;
@override final  int limit;
@override final  int totalChats;
@override final  int totalCalls;

/// Create a copy of PaginationModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaginationModelCopyWith<_PaginationModel> get copyWith => __$PaginationModelCopyWithImpl<_PaginationModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PaginationModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaginationModel&&(identical(other.page, page) || other.page == page)&&(identical(other.limit, limit) || other.limit == limit)&&(identical(other.totalChats, totalChats) || other.totalChats == totalChats)&&(identical(other.totalCalls, totalCalls) || other.totalCalls == totalCalls));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,page,limit,totalChats,totalCalls);

@override
String toString() {
  return 'PaginationModel(page: $page, limit: $limit, totalChats: $totalChats, totalCalls: $totalCalls)';
}


}

/// @nodoc
abstract mixin class _$PaginationModelCopyWith<$Res> implements $PaginationModelCopyWith<$Res> {
  factory _$PaginationModelCopyWith(_PaginationModel value, $Res Function(_PaginationModel) _then) = __$PaginationModelCopyWithImpl;
@override @useResult
$Res call({
 int page, int limit, int totalChats, int totalCalls
});




}
/// @nodoc
class __$PaginationModelCopyWithImpl<$Res>
    implements _$PaginationModelCopyWith<$Res> {
  __$PaginationModelCopyWithImpl(this._self, this._then);

  final _PaginationModel _self;
  final $Res Function(_PaginationModel) _then;

/// Create a copy of PaginationModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? page = null,Object? limit = null,Object? totalChats = null,Object? totalCalls = null,}) {
  return _then(_PaginationModel(
page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,limit: null == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as int,totalChats: null == totalChats ? _self.totalChats : totalChats // ignore: cast_nullable_to_non_nullable
as int,totalCalls: null == totalCalls ? _self.totalCalls : totalCalls // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$PokeDetailResponse {

 bool get success; String get message; PokeDetailData get data;
/// Create a copy of PokeDetailResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PokeDetailResponseCopyWith<PokeDetailResponse> get copyWith => _$PokeDetailResponseCopyWithImpl<PokeDetailResponse>(this as PokeDetailResponse, _$identity);

  /// Serializes this PokeDetailResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PokeDetailResponse&&(identical(other.success, success) || other.success == success)&&(identical(other.message, message) || other.message == message)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,message,data);

@override
String toString() {
  return 'PokeDetailResponse(success: $success, message: $message, data: $data)';
}


}

/// @nodoc
abstract mixin class $PokeDetailResponseCopyWith<$Res>  {
  factory $PokeDetailResponseCopyWith(PokeDetailResponse value, $Res Function(PokeDetailResponse) _then) = _$PokeDetailResponseCopyWithImpl;
@useResult
$Res call({
 bool success, String message, PokeDetailData data
});


$PokeDetailDataCopyWith<$Res> get data;

}
/// @nodoc
class _$PokeDetailResponseCopyWithImpl<$Res>
    implements $PokeDetailResponseCopyWith<$Res> {
  _$PokeDetailResponseCopyWithImpl(this._self, this._then);

  final PokeDetailResponse _self;
  final $Res Function(PokeDetailResponse) _then;

/// Create a copy of PokeDetailResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? success = null,Object? message = null,Object? data = null,}) {
  return _then(_self.copyWith(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as PokeDetailData,
  ));
}
/// Create a copy of PokeDetailResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PokeDetailDataCopyWith<$Res> get data {
  
  return $PokeDetailDataCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// Adds pattern-matching-related methods to [PokeDetailResponse].
extension PokeDetailResponsePatterns on PokeDetailResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PokeDetailResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PokeDetailResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PokeDetailResponse value)  $default,){
final _that = this;
switch (_that) {
case _PokeDetailResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PokeDetailResponse value)?  $default,){
final _that = this;
switch (_that) {
case _PokeDetailResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool success,  String message,  PokeDetailData data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PokeDetailResponse() when $default != null:
return $default(_that.success,_that.message,_that.data);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool success,  String message,  PokeDetailData data)  $default,) {final _that = this;
switch (_that) {
case _PokeDetailResponse():
return $default(_that.success,_that.message,_that.data);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool success,  String message,  PokeDetailData data)?  $default,) {final _that = this;
switch (_that) {
case _PokeDetailResponse() when $default != null:
return $default(_that.success,_that.message,_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PokeDetailResponse implements PokeDetailResponse {
  const _PokeDetailResponse({required this.success, required this.message, required this.data});
  factory _PokeDetailResponse.fromJson(Map<String, dynamic> json) => _$PokeDetailResponseFromJson(json);

@override final  bool success;
@override final  String message;
@override final  PokeDetailData data;

/// Create a copy of PokeDetailResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PokeDetailResponseCopyWith<_PokeDetailResponse> get copyWith => __$PokeDetailResponseCopyWithImpl<_PokeDetailResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PokeDetailResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PokeDetailResponse&&(identical(other.success, success) || other.success == success)&&(identical(other.message, message) || other.message == message)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,message,data);

@override
String toString() {
  return 'PokeDetailResponse(success: $success, message: $message, data: $data)';
}


}

/// @nodoc
abstract mixin class _$PokeDetailResponseCopyWith<$Res> implements $PokeDetailResponseCopyWith<$Res> {
  factory _$PokeDetailResponseCopyWith(_PokeDetailResponse value, $Res Function(_PokeDetailResponse) _then) = __$PokeDetailResponseCopyWithImpl;
@override @useResult
$Res call({
 bool success, String message, PokeDetailData data
});


@override $PokeDetailDataCopyWith<$Res> get data;

}
/// @nodoc
class __$PokeDetailResponseCopyWithImpl<$Res>
    implements _$PokeDetailResponseCopyWith<$Res> {
  __$PokeDetailResponseCopyWithImpl(this._self, this._then);

  final _PokeDetailResponse _self;
  final $Res Function(_PokeDetailResponse) _then;

/// Create a copy of PokeDetailResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? success = null,Object? message = null,Object? data = null,}) {
  return _then(_PokeDetailResponse(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as PokeDetailData,
  ));
}

/// Create a copy of PokeDetailResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PokeDetailDataCopyWith<$Res> get data {
  
  return $PokeDetailDataCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// @nodoc
mixin _$PokeDetailData {

 PokeModel get poke; PokerFromUser get fromUser; PokedTargetDetail get pokedTargetDetail;
/// Create a copy of PokeDetailData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PokeDetailDataCopyWith<PokeDetailData> get copyWith => _$PokeDetailDataCopyWithImpl<PokeDetailData>(this as PokeDetailData, _$identity);

  /// Serializes this PokeDetailData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PokeDetailData&&(identical(other.poke, poke) || other.poke == poke)&&(identical(other.fromUser, fromUser) || other.fromUser == fromUser)&&(identical(other.pokedTargetDetail, pokedTargetDetail) || other.pokedTargetDetail == pokedTargetDetail));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,poke,fromUser,pokedTargetDetail);

@override
String toString() {
  return 'PokeDetailData(poke: $poke, fromUser: $fromUser, pokedTargetDetail: $pokedTargetDetail)';
}


}

/// @nodoc
abstract mixin class $PokeDetailDataCopyWith<$Res>  {
  factory $PokeDetailDataCopyWith(PokeDetailData value, $Res Function(PokeDetailData) _then) = _$PokeDetailDataCopyWithImpl;
@useResult
$Res call({
 PokeModel poke, PokerFromUser fromUser, PokedTargetDetail pokedTargetDetail
});


$PokeModelCopyWith<$Res> get poke;$PokerFromUserCopyWith<$Res> get fromUser;$PokedTargetDetailCopyWith<$Res> get pokedTargetDetail;

}
/// @nodoc
class _$PokeDetailDataCopyWithImpl<$Res>
    implements $PokeDetailDataCopyWith<$Res> {
  _$PokeDetailDataCopyWithImpl(this._self, this._then);

  final PokeDetailData _self;
  final $Res Function(PokeDetailData) _then;

/// Create a copy of PokeDetailData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? poke = null,Object? fromUser = null,Object? pokedTargetDetail = null,}) {
  return _then(_self.copyWith(
poke: null == poke ? _self.poke : poke // ignore: cast_nullable_to_non_nullable
as PokeModel,fromUser: null == fromUser ? _self.fromUser : fromUser // ignore: cast_nullable_to_non_nullable
as PokerFromUser,pokedTargetDetail: null == pokedTargetDetail ? _self.pokedTargetDetail : pokedTargetDetail // ignore: cast_nullable_to_non_nullable
as PokedTargetDetail,
  ));
}
/// Create a copy of PokeDetailData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PokeModelCopyWith<$Res> get poke {
  
  return $PokeModelCopyWith<$Res>(_self.poke, (value) {
    return _then(_self.copyWith(poke: value));
  });
}/// Create a copy of PokeDetailData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PokerFromUserCopyWith<$Res> get fromUser {
  
  return $PokerFromUserCopyWith<$Res>(_self.fromUser, (value) {
    return _then(_self.copyWith(fromUser: value));
  });
}/// Create a copy of PokeDetailData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PokedTargetDetailCopyWith<$Res> get pokedTargetDetail {
  
  return $PokedTargetDetailCopyWith<$Res>(_self.pokedTargetDetail, (value) {
    return _then(_self.copyWith(pokedTargetDetail: value));
  });
}
}


/// Adds pattern-matching-related methods to [PokeDetailData].
extension PokeDetailDataPatterns on PokeDetailData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PokeDetailData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PokeDetailData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PokeDetailData value)  $default,){
final _that = this;
switch (_that) {
case _PokeDetailData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PokeDetailData value)?  $default,){
final _that = this;
switch (_that) {
case _PokeDetailData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( PokeModel poke,  PokerFromUser fromUser,  PokedTargetDetail pokedTargetDetail)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PokeDetailData() when $default != null:
return $default(_that.poke,_that.fromUser,_that.pokedTargetDetail);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( PokeModel poke,  PokerFromUser fromUser,  PokedTargetDetail pokedTargetDetail)  $default,) {final _that = this;
switch (_that) {
case _PokeDetailData():
return $default(_that.poke,_that.fromUser,_that.pokedTargetDetail);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( PokeModel poke,  PokerFromUser fromUser,  PokedTargetDetail pokedTargetDetail)?  $default,) {final _that = this;
switch (_that) {
case _PokeDetailData() when $default != null:
return $default(_that.poke,_that.fromUser,_that.pokedTargetDetail);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PokeDetailData implements PokeDetailData {
  const _PokeDetailData({required this.poke, required this.fromUser, required this.pokedTargetDetail});
  factory _PokeDetailData.fromJson(Map<String, dynamic> json) => _$PokeDetailDataFromJson(json);

@override final  PokeModel poke;
@override final  PokerFromUser fromUser;
@override final  PokedTargetDetail pokedTargetDetail;

/// Create a copy of PokeDetailData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PokeDetailDataCopyWith<_PokeDetailData> get copyWith => __$PokeDetailDataCopyWithImpl<_PokeDetailData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PokeDetailDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PokeDetailData&&(identical(other.poke, poke) || other.poke == poke)&&(identical(other.fromUser, fromUser) || other.fromUser == fromUser)&&(identical(other.pokedTargetDetail, pokedTargetDetail) || other.pokedTargetDetail == pokedTargetDetail));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,poke,fromUser,pokedTargetDetail);

@override
String toString() {
  return 'PokeDetailData(poke: $poke, fromUser: $fromUser, pokedTargetDetail: $pokedTargetDetail)';
}


}

/// @nodoc
abstract mixin class _$PokeDetailDataCopyWith<$Res> implements $PokeDetailDataCopyWith<$Res> {
  factory _$PokeDetailDataCopyWith(_PokeDetailData value, $Res Function(_PokeDetailData) _then) = __$PokeDetailDataCopyWithImpl;
@override @useResult
$Res call({
 PokeModel poke, PokerFromUser fromUser, PokedTargetDetail pokedTargetDetail
});


@override $PokeModelCopyWith<$Res> get poke;@override $PokerFromUserCopyWith<$Res> get fromUser;@override $PokedTargetDetailCopyWith<$Res> get pokedTargetDetail;

}
/// @nodoc
class __$PokeDetailDataCopyWithImpl<$Res>
    implements _$PokeDetailDataCopyWith<$Res> {
  __$PokeDetailDataCopyWithImpl(this._self, this._then);

  final _PokeDetailData _self;
  final $Res Function(_PokeDetailData) _then;

/// Create a copy of PokeDetailData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? poke = null,Object? fromUser = null,Object? pokedTargetDetail = null,}) {
  return _then(_PokeDetailData(
poke: null == poke ? _self.poke : poke // ignore: cast_nullable_to_non_nullable
as PokeModel,fromUser: null == fromUser ? _self.fromUser : fromUser // ignore: cast_nullable_to_non_nullable
as PokerFromUser,pokedTargetDetail: null == pokedTargetDetail ? _self.pokedTargetDetail : pokedTargetDetail // ignore: cast_nullable_to_non_nullable
as PokedTargetDetail,
  ));
}

/// Create a copy of PokeDetailData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PokeModelCopyWith<$Res> get poke {
  
  return $PokeModelCopyWith<$Res>(_self.poke, (value) {
    return _then(_self.copyWith(poke: value));
  });
}/// Create a copy of PokeDetailData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PokerFromUserCopyWith<$Res> get fromUser {
  
  return $PokerFromUserCopyWith<$Res>(_self.fromUser, (value) {
    return _then(_self.copyWith(fromUser: value));
  });
}/// Create a copy of PokeDetailData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PokedTargetDetailCopyWith<$Res> get pokedTargetDetail {
  
  return $PokedTargetDetailCopyWith<$Res>(_self.pokedTargetDetail, (value) {
    return _then(_self.copyWith(pokedTargetDetail: value));
  });
}
}


/// @nodoc
mixin _$PokeModel {

 String get id; String get fromUserId; String get toUserId; String get targetType; String get targetId; String get message; String get status; DateTime get createdAt; DateTime get updatedAt;
/// Create a copy of PokeModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PokeModelCopyWith<PokeModel> get copyWith => _$PokeModelCopyWithImpl<PokeModel>(this as PokeModel, _$identity);

  /// Serializes this PokeModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PokeModel&&(identical(other.id, id) || other.id == id)&&(identical(other.fromUserId, fromUserId) || other.fromUserId == fromUserId)&&(identical(other.toUserId, toUserId) || other.toUserId == toUserId)&&(identical(other.targetType, targetType) || other.targetType == targetType)&&(identical(other.targetId, targetId) || other.targetId == targetId)&&(identical(other.message, message) || other.message == message)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,fromUserId,toUserId,targetType,targetId,message,status,createdAt,updatedAt);

@override
String toString() {
  return 'PokeModel(id: $id, fromUserId: $fromUserId, toUserId: $toUserId, targetType: $targetType, targetId: $targetId, message: $message, status: $status, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $PokeModelCopyWith<$Res>  {
  factory $PokeModelCopyWith(PokeModel value, $Res Function(PokeModel) _then) = _$PokeModelCopyWithImpl;
@useResult
$Res call({
 String id, String fromUserId, String toUserId, String targetType, String targetId, String message, String status, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class _$PokeModelCopyWithImpl<$Res>
    implements $PokeModelCopyWith<$Res> {
  _$PokeModelCopyWithImpl(this._self, this._then);

  final PokeModel _self;
  final $Res Function(PokeModel) _then;

/// Create a copy of PokeModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? fromUserId = null,Object? toUserId = null,Object? targetType = null,Object? targetId = null,Object? message = null,Object? status = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,fromUserId: null == fromUserId ? _self.fromUserId : fromUserId // ignore: cast_nullable_to_non_nullable
as String,toUserId: null == toUserId ? _self.toUserId : toUserId // ignore: cast_nullable_to_non_nullable
as String,targetType: null == targetType ? _self.targetType : targetType // ignore: cast_nullable_to_non_nullable
as String,targetId: null == targetId ? _self.targetId : targetId // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [PokeModel].
extension PokeModelPatterns on PokeModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PokeModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PokeModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PokeModel value)  $default,){
final _that = this;
switch (_that) {
case _PokeModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PokeModel value)?  $default,){
final _that = this;
switch (_that) {
case _PokeModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String fromUserId,  String toUserId,  String targetType,  String targetId,  String message,  String status,  DateTime createdAt,  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PokeModel() when $default != null:
return $default(_that.id,_that.fromUserId,_that.toUserId,_that.targetType,_that.targetId,_that.message,_that.status,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String fromUserId,  String toUserId,  String targetType,  String targetId,  String message,  String status,  DateTime createdAt,  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _PokeModel():
return $default(_that.id,_that.fromUserId,_that.toUserId,_that.targetType,_that.targetId,_that.message,_that.status,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String fromUserId,  String toUserId,  String targetType,  String targetId,  String message,  String status,  DateTime createdAt,  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _PokeModel() when $default != null:
return $default(_that.id,_that.fromUserId,_that.toUserId,_that.targetType,_that.targetId,_that.message,_that.status,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PokeModel implements PokeModel {
  const _PokeModel({required this.id, required this.fromUserId, required this.toUserId, required this.targetType, required this.targetId, required this.message, required this.status, required this.createdAt, required this.updatedAt});
  factory _PokeModel.fromJson(Map<String, dynamic> json) => _$PokeModelFromJson(json);

@override final  String id;
@override final  String fromUserId;
@override final  String toUserId;
@override final  String targetType;
@override final  String targetId;
@override final  String message;
@override final  String status;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;

/// Create a copy of PokeModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PokeModelCopyWith<_PokeModel> get copyWith => __$PokeModelCopyWithImpl<_PokeModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PokeModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PokeModel&&(identical(other.id, id) || other.id == id)&&(identical(other.fromUserId, fromUserId) || other.fromUserId == fromUserId)&&(identical(other.toUserId, toUserId) || other.toUserId == toUserId)&&(identical(other.targetType, targetType) || other.targetType == targetType)&&(identical(other.targetId, targetId) || other.targetId == targetId)&&(identical(other.message, message) || other.message == message)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,fromUserId,toUserId,targetType,targetId,message,status,createdAt,updatedAt);

@override
String toString() {
  return 'PokeModel(id: $id, fromUserId: $fromUserId, toUserId: $toUserId, targetType: $targetType, targetId: $targetId, message: $message, status: $status, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$PokeModelCopyWith<$Res> implements $PokeModelCopyWith<$Res> {
  factory _$PokeModelCopyWith(_PokeModel value, $Res Function(_PokeModel) _then) = __$PokeModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String fromUserId, String toUserId, String targetType, String targetId, String message, String status, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class __$PokeModelCopyWithImpl<$Res>
    implements _$PokeModelCopyWith<$Res> {
  __$PokeModelCopyWithImpl(this._self, this._then);

  final _PokeModel _self;
  final $Res Function(_PokeModel) _then;

/// Create a copy of PokeModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? fromUserId = null,Object? toUserId = null,Object? targetType = null,Object? targetId = null,Object? message = null,Object? status = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_PokeModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,fromUserId: null == fromUserId ? _self.fromUserId : fromUserId // ignore: cast_nullable_to_non_nullable
as String,toUserId: null == toUserId ? _self.toUserId : toUserId // ignore: cast_nullable_to_non_nullable
as String,targetType: null == targetType ? _self.targetType : targetType // ignore: cast_nullable_to_non_nullable
as String,targetId: null == targetId ? _self.targetId : targetId // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$PokerFromUser {

 String get id; String get firstName; String get lastName; List<String> get bestShorts;
/// Create a copy of PokerFromUser
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PokerFromUserCopyWith<PokerFromUser> get copyWith => _$PokerFromUserCopyWithImpl<PokerFromUser>(this as PokerFromUser, _$identity);

  /// Serializes this PokerFromUser to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PokerFromUser&&(identical(other.id, id) || other.id == id)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&const DeepCollectionEquality().equals(other.bestShorts, bestShorts));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,firstName,lastName,const DeepCollectionEquality().hash(bestShorts));

@override
String toString() {
  return 'PokerFromUser(id: $id, firstName: $firstName, lastName: $lastName, bestShorts: $bestShorts)';
}


}

/// @nodoc
abstract mixin class $PokerFromUserCopyWith<$Res>  {
  factory $PokerFromUserCopyWith(PokerFromUser value, $Res Function(PokerFromUser) _then) = _$PokerFromUserCopyWithImpl;
@useResult
$Res call({
 String id, String firstName, String lastName, List<String> bestShorts
});




}
/// @nodoc
class _$PokerFromUserCopyWithImpl<$Res>
    implements $PokerFromUserCopyWith<$Res> {
  _$PokerFromUserCopyWithImpl(this._self, this._then);

  final PokerFromUser _self;
  final $Res Function(PokerFromUser) _then;

/// Create a copy of PokerFromUser
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? firstName = null,Object? lastName = null,Object? bestShorts = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,bestShorts: null == bestShorts ? _self.bestShorts : bestShorts // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [PokerFromUser].
extension PokerFromUserPatterns on PokerFromUser {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PokerFromUser value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PokerFromUser() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PokerFromUser value)  $default,){
final _that = this;
switch (_that) {
case _PokerFromUser():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PokerFromUser value)?  $default,){
final _that = this;
switch (_that) {
case _PokerFromUser() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String firstName,  String lastName,  List<String> bestShorts)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PokerFromUser() when $default != null:
return $default(_that.id,_that.firstName,_that.lastName,_that.bestShorts);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String firstName,  String lastName,  List<String> bestShorts)  $default,) {final _that = this;
switch (_that) {
case _PokerFromUser():
return $default(_that.id,_that.firstName,_that.lastName,_that.bestShorts);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String firstName,  String lastName,  List<String> bestShorts)?  $default,) {final _that = this;
switch (_that) {
case _PokerFromUser() when $default != null:
return $default(_that.id,_that.firstName,_that.lastName,_that.bestShorts);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PokerFromUser implements PokerFromUser {
  const _PokerFromUser({required this.id, required this.firstName, required this.lastName, required final  List<String> bestShorts}): _bestShorts = bestShorts;
  factory _PokerFromUser.fromJson(Map<String, dynamic> json) => _$PokerFromUserFromJson(json);

@override final  String id;
@override final  String firstName;
@override final  String lastName;
 final  List<String> _bestShorts;
@override List<String> get bestShorts {
  if (_bestShorts is EqualUnmodifiableListView) return _bestShorts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_bestShorts);
}


/// Create a copy of PokerFromUser
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PokerFromUserCopyWith<_PokerFromUser> get copyWith => __$PokerFromUserCopyWithImpl<_PokerFromUser>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PokerFromUserToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PokerFromUser&&(identical(other.id, id) || other.id == id)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&const DeepCollectionEquality().equals(other._bestShorts, _bestShorts));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,firstName,lastName,const DeepCollectionEquality().hash(_bestShorts));

@override
String toString() {
  return 'PokerFromUser(id: $id, firstName: $firstName, lastName: $lastName, bestShorts: $bestShorts)';
}


}

/// @nodoc
abstract mixin class _$PokerFromUserCopyWith<$Res> implements $PokerFromUserCopyWith<$Res> {
  factory _$PokerFromUserCopyWith(_PokerFromUser value, $Res Function(_PokerFromUser) _then) = __$PokerFromUserCopyWithImpl;
@override @useResult
$Res call({
 String id, String firstName, String lastName, List<String> bestShorts
});




}
/// @nodoc
class __$PokerFromUserCopyWithImpl<$Res>
    implements _$PokerFromUserCopyWith<$Res> {
  __$PokerFromUserCopyWithImpl(this._self, this._then);

  final _PokerFromUser _self;
  final $Res Function(_PokerFromUser) _then;

/// Create a copy of PokerFromUser
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? firstName = null,Object? lastName = null,Object? bestShorts = null,}) {
  return _then(_PokerFromUser(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,bestShorts: null == bestShorts ? _self._bestShorts : bestShorts // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}


/// @nodoc
mixin _$PokedTargetDetail {

 String get type; PokePhotoDetail? get photo; PokeAudioDetail? get audio; String? get text;
/// Create a copy of PokedTargetDetail
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PokedTargetDetailCopyWith<PokedTargetDetail> get copyWith => _$PokedTargetDetailCopyWithImpl<PokedTargetDetail>(this as PokedTargetDetail, _$identity);

  /// Serializes this PokedTargetDetail to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PokedTargetDetail&&(identical(other.type, type) || other.type == type)&&(identical(other.photo, photo) || other.photo == photo)&&(identical(other.audio, audio) || other.audio == audio)&&(identical(other.text, text) || other.text == text));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,photo,audio,text);

@override
String toString() {
  return 'PokedTargetDetail(type: $type, photo: $photo, audio: $audio, text: $text)';
}


}

/// @nodoc
abstract mixin class $PokedTargetDetailCopyWith<$Res>  {
  factory $PokedTargetDetailCopyWith(PokedTargetDetail value, $Res Function(PokedTargetDetail) _then) = _$PokedTargetDetailCopyWithImpl;
@useResult
$Res call({
 String type, PokePhotoDetail? photo, PokeAudioDetail? audio, String? text
});


$PokePhotoDetailCopyWith<$Res>? get photo;$PokeAudioDetailCopyWith<$Res>? get audio;

}
/// @nodoc
class _$PokedTargetDetailCopyWithImpl<$Res>
    implements $PokedTargetDetailCopyWith<$Res> {
  _$PokedTargetDetailCopyWithImpl(this._self, this._then);

  final PokedTargetDetail _self;
  final $Res Function(PokedTargetDetail) _then;

/// Create a copy of PokedTargetDetail
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? photo = freezed,Object? audio = freezed,Object? text = freezed,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,photo: freezed == photo ? _self.photo : photo // ignore: cast_nullable_to_non_nullable
as PokePhotoDetail?,audio: freezed == audio ? _self.audio : audio // ignore: cast_nullable_to_non_nullable
as PokeAudioDetail?,text: freezed == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of PokedTargetDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PokePhotoDetailCopyWith<$Res>? get photo {
    if (_self.photo == null) {
    return null;
  }

  return $PokePhotoDetailCopyWith<$Res>(_self.photo!, (value) {
    return _then(_self.copyWith(photo: value));
  });
}/// Create a copy of PokedTargetDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PokeAudioDetailCopyWith<$Res>? get audio {
    if (_self.audio == null) {
    return null;
  }

  return $PokeAudioDetailCopyWith<$Res>(_self.audio!, (value) {
    return _then(_self.copyWith(audio: value));
  });
}
}


/// Adds pattern-matching-related methods to [PokedTargetDetail].
extension PokedTargetDetailPatterns on PokedTargetDetail {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PokedTargetDetail value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PokedTargetDetail() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PokedTargetDetail value)  $default,){
final _that = this;
switch (_that) {
case _PokedTargetDetail():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PokedTargetDetail value)?  $default,){
final _that = this;
switch (_that) {
case _PokedTargetDetail() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String type,  PokePhotoDetail? photo,  PokeAudioDetail? audio,  String? text)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PokedTargetDetail() when $default != null:
return $default(_that.type,_that.photo,_that.audio,_that.text);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String type,  PokePhotoDetail? photo,  PokeAudioDetail? audio,  String? text)  $default,) {final _that = this;
switch (_that) {
case _PokedTargetDetail():
return $default(_that.type,_that.photo,_that.audio,_that.text);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String type,  PokePhotoDetail? photo,  PokeAudioDetail? audio,  String? text)?  $default,) {final _that = this;
switch (_that) {
case _PokedTargetDetail() when $default != null:
return $default(_that.type,_that.photo,_that.audio,_that.text);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PokedTargetDetail implements PokedTargetDetail {
  const _PokedTargetDetail({required this.type, this.photo, this.audio, this.text});
  factory _PokedTargetDetail.fromJson(Map<String, dynamic> json) => _$PokedTargetDetailFromJson(json);

@override final  String type;
@override final  PokePhotoDetail? photo;
@override final  PokeAudioDetail? audio;
@override final  String? text;

/// Create a copy of PokedTargetDetail
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PokedTargetDetailCopyWith<_PokedTargetDetail> get copyWith => __$PokedTargetDetailCopyWithImpl<_PokedTargetDetail>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PokedTargetDetailToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PokedTargetDetail&&(identical(other.type, type) || other.type == type)&&(identical(other.photo, photo) || other.photo == photo)&&(identical(other.audio, audio) || other.audio == audio)&&(identical(other.text, text) || other.text == text));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,photo,audio,text);

@override
String toString() {
  return 'PokedTargetDetail(type: $type, photo: $photo, audio: $audio, text: $text)';
}


}

/// @nodoc
abstract mixin class _$PokedTargetDetailCopyWith<$Res> implements $PokedTargetDetailCopyWith<$Res> {
  factory _$PokedTargetDetailCopyWith(_PokedTargetDetail value, $Res Function(_PokedTargetDetail) _then) = __$PokedTargetDetailCopyWithImpl;
@override @useResult
$Res call({
 String type, PokePhotoDetail? photo, PokeAudioDetail? audio, String? text
});


@override $PokePhotoDetailCopyWith<$Res>? get photo;@override $PokeAudioDetailCopyWith<$Res>? get audio;

}
/// @nodoc
class __$PokedTargetDetailCopyWithImpl<$Res>
    implements _$PokedTargetDetailCopyWith<$Res> {
  __$PokedTargetDetailCopyWithImpl(this._self, this._then);

  final _PokedTargetDetail _self;
  final $Res Function(_PokedTargetDetail) _then;

/// Create a copy of PokedTargetDetail
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? photo = freezed,Object? audio = freezed,Object? text = freezed,}) {
  return _then(_PokedTargetDetail(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,photo: freezed == photo ? _self.photo : photo // ignore: cast_nullable_to_non_nullable
as PokePhotoDetail?,audio: freezed == audio ? _self.audio : audio // ignore: cast_nullable_to_non_nullable
as PokeAudioDetail?,text: freezed == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of PokedTargetDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PokePhotoDetailCopyWith<$Res>? get photo {
    if (_self.photo == null) {
    return null;
  }

  return $PokePhotoDetailCopyWith<$Res>(_self.photo!, (value) {
    return _then(_self.copyWith(photo: value));
  });
}/// Create a copy of PokedTargetDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PokeAudioDetailCopyWith<$Res>? get audio {
    if (_self.audio == null) {
    return null;
  }

  return $PokeAudioDetailCopyWith<$Res>(_self.audio!, (value) {
    return _then(_self.copyWith(audio: value));
  });
}
}


/// @nodoc
mixin _$PokePhotoDetail {

 int get index; String get url;
/// Create a copy of PokePhotoDetail
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PokePhotoDetailCopyWith<PokePhotoDetail> get copyWith => _$PokePhotoDetailCopyWithImpl<PokePhotoDetail>(this as PokePhotoDetail, _$identity);

  /// Serializes this PokePhotoDetail to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PokePhotoDetail&&(identical(other.index, index) || other.index == index)&&(identical(other.url, url) || other.url == url));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,index,url);

@override
String toString() {
  return 'PokePhotoDetail(index: $index, url: $url)';
}


}

/// @nodoc
abstract mixin class $PokePhotoDetailCopyWith<$Res>  {
  factory $PokePhotoDetailCopyWith(PokePhotoDetail value, $Res Function(PokePhotoDetail) _then) = _$PokePhotoDetailCopyWithImpl;
@useResult
$Res call({
 int index, String url
});




}
/// @nodoc
class _$PokePhotoDetailCopyWithImpl<$Res>
    implements $PokePhotoDetailCopyWith<$Res> {
  _$PokePhotoDetailCopyWithImpl(this._self, this._then);

  final PokePhotoDetail _self;
  final $Res Function(PokePhotoDetail) _then;

/// Create a copy of PokePhotoDetail
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? index = null,Object? url = null,}) {
  return _then(_self.copyWith(
index: null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [PokePhotoDetail].
extension PokePhotoDetailPatterns on PokePhotoDetail {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PokePhotoDetail value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PokePhotoDetail() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PokePhotoDetail value)  $default,){
final _that = this;
switch (_that) {
case _PokePhotoDetail():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PokePhotoDetail value)?  $default,){
final _that = this;
switch (_that) {
case _PokePhotoDetail() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int index,  String url)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PokePhotoDetail() when $default != null:
return $default(_that.index,_that.url);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int index,  String url)  $default,) {final _that = this;
switch (_that) {
case _PokePhotoDetail():
return $default(_that.index,_that.url);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int index,  String url)?  $default,) {final _that = this;
switch (_that) {
case _PokePhotoDetail() when $default != null:
return $default(_that.index,_that.url);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PokePhotoDetail implements PokePhotoDetail {
  const _PokePhotoDetail({required this.index, required this.url});
  factory _PokePhotoDetail.fromJson(Map<String, dynamic> json) => _$PokePhotoDetailFromJson(json);

@override final  int index;
@override final  String url;

/// Create a copy of PokePhotoDetail
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PokePhotoDetailCopyWith<_PokePhotoDetail> get copyWith => __$PokePhotoDetailCopyWithImpl<_PokePhotoDetail>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PokePhotoDetailToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PokePhotoDetail&&(identical(other.index, index) || other.index == index)&&(identical(other.url, url) || other.url == url));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,index,url);

@override
String toString() {
  return 'PokePhotoDetail(index: $index, url: $url)';
}


}

/// @nodoc
abstract mixin class _$PokePhotoDetailCopyWith<$Res> implements $PokePhotoDetailCopyWith<$Res> {
  factory _$PokePhotoDetailCopyWith(_PokePhotoDetail value, $Res Function(_PokePhotoDetail) _then) = __$PokePhotoDetailCopyWithImpl;
@override @useResult
$Res call({
 int index, String url
});




}
/// @nodoc
class __$PokePhotoDetailCopyWithImpl<$Res>
    implements _$PokePhotoDetailCopyWith<$Res> {
  __$PokePhotoDetailCopyWithImpl(this._self, this._then);

  final _PokePhotoDetail _self;
  final $Res Function(_PokePhotoDetail) _then;

/// Create a copy of PokePhotoDetail
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? index = null,Object? url = null,}) {
  return _then(_PokePhotoDetail(
index: null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$PokeAudioDetail {

 String get url;
/// Create a copy of PokeAudioDetail
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PokeAudioDetailCopyWith<PokeAudioDetail> get copyWith => _$PokeAudioDetailCopyWithImpl<PokeAudioDetail>(this as PokeAudioDetail, _$identity);

  /// Serializes this PokeAudioDetail to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PokeAudioDetail&&(identical(other.url, url) || other.url == url));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,url);

@override
String toString() {
  return 'PokeAudioDetail(url: $url)';
}


}

/// @nodoc
abstract mixin class $PokeAudioDetailCopyWith<$Res>  {
  factory $PokeAudioDetailCopyWith(PokeAudioDetail value, $Res Function(PokeAudioDetail) _then) = _$PokeAudioDetailCopyWithImpl;
@useResult
$Res call({
 String url
});




}
/// @nodoc
class _$PokeAudioDetailCopyWithImpl<$Res>
    implements $PokeAudioDetailCopyWith<$Res> {
  _$PokeAudioDetailCopyWithImpl(this._self, this._then);

  final PokeAudioDetail _self;
  final $Res Function(PokeAudioDetail) _then;

/// Create a copy of PokeAudioDetail
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? url = null,}) {
  return _then(_self.copyWith(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [PokeAudioDetail].
extension PokeAudioDetailPatterns on PokeAudioDetail {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PokeAudioDetail value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PokeAudioDetail() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PokeAudioDetail value)  $default,){
final _that = this;
switch (_that) {
case _PokeAudioDetail():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PokeAudioDetail value)?  $default,){
final _that = this;
switch (_that) {
case _PokeAudioDetail() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String url)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PokeAudioDetail() when $default != null:
return $default(_that.url);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String url)  $default,) {final _that = this;
switch (_that) {
case _PokeAudioDetail():
return $default(_that.url);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String url)?  $default,) {final _that = this;
switch (_that) {
case _PokeAudioDetail() when $default != null:
return $default(_that.url);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PokeAudioDetail implements PokeAudioDetail {
  const _PokeAudioDetail({required this.url});
  factory _PokeAudioDetail.fromJson(Map<String, dynamic> json) => _$PokeAudioDetailFromJson(json);

@override final  String url;

/// Create a copy of PokeAudioDetail
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PokeAudioDetailCopyWith<_PokeAudioDetail> get copyWith => __$PokeAudioDetailCopyWithImpl<_PokeAudioDetail>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PokeAudioDetailToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PokeAudioDetail&&(identical(other.url, url) || other.url == url));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,url);

@override
String toString() {
  return 'PokeAudioDetail(url: $url)';
}


}

/// @nodoc
abstract mixin class _$PokeAudioDetailCopyWith<$Res> implements $PokeAudioDetailCopyWith<$Res> {
  factory _$PokeAudioDetailCopyWith(_PokeAudioDetail value, $Res Function(_PokeAudioDetail) _then) = __$PokeAudioDetailCopyWithImpl;
@override @useResult
$Res call({
 String url
});




}
/// @nodoc
class __$PokeAudioDetailCopyWithImpl<$Res>
    implements _$PokeAudioDetailCopyWith<$Res> {
  __$PokeAudioDetailCopyWithImpl(this._self, this._then);

  final _PokeAudioDetail _self;
  final $Res Function(_PokeAudioDetail) _then;

/// Create a copy of PokeAudioDetail
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? url = null,}) {
  return _then(_PokeAudioDetail(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$PokeStartChatResponse {

 bool get success; String get message; PokeStartChatData get data;
/// Create a copy of PokeStartChatResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PokeStartChatResponseCopyWith<PokeStartChatResponse> get copyWith => _$PokeStartChatResponseCopyWithImpl<PokeStartChatResponse>(this as PokeStartChatResponse, _$identity);

  /// Serializes this PokeStartChatResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PokeStartChatResponse&&(identical(other.success, success) || other.success == success)&&(identical(other.message, message) || other.message == message)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,message,data);

@override
String toString() {
  return 'PokeStartChatResponse(success: $success, message: $message, data: $data)';
}


}

/// @nodoc
abstract mixin class $PokeStartChatResponseCopyWith<$Res>  {
  factory $PokeStartChatResponseCopyWith(PokeStartChatResponse value, $Res Function(PokeStartChatResponse) _then) = _$PokeStartChatResponseCopyWithImpl;
@useResult
$Res call({
 bool success, String message, PokeStartChatData data
});


$PokeStartChatDataCopyWith<$Res> get data;

}
/// @nodoc
class _$PokeStartChatResponseCopyWithImpl<$Res>
    implements $PokeStartChatResponseCopyWith<$Res> {
  _$PokeStartChatResponseCopyWithImpl(this._self, this._then);

  final PokeStartChatResponse _self;
  final $Res Function(PokeStartChatResponse) _then;

/// Create a copy of PokeStartChatResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? success = null,Object? message = null,Object? data = null,}) {
  return _then(_self.copyWith(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as PokeStartChatData,
  ));
}
/// Create a copy of PokeStartChatResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PokeStartChatDataCopyWith<$Res> get data {
  
  return $PokeStartChatDataCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// Adds pattern-matching-related methods to [PokeStartChatResponse].
extension PokeStartChatResponsePatterns on PokeStartChatResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PokeStartChatResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PokeStartChatResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PokeStartChatResponse value)  $default,){
final _that = this;
switch (_that) {
case _PokeStartChatResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PokeStartChatResponse value)?  $default,){
final _that = this;
switch (_that) {
case _PokeStartChatResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool success,  String message,  PokeStartChatData data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PokeStartChatResponse() when $default != null:
return $default(_that.success,_that.message,_that.data);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool success,  String message,  PokeStartChatData data)  $default,) {final _that = this;
switch (_that) {
case _PokeStartChatResponse():
return $default(_that.success,_that.message,_that.data);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool success,  String message,  PokeStartChatData data)?  $default,) {final _that = this;
switch (_that) {
case _PokeStartChatResponse() when $default != null:
return $default(_that.success,_that.message,_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PokeStartChatResponse implements PokeStartChatResponse {
  const _PokeStartChatResponse({required this.success, required this.message, required this.data});
  factory _PokeStartChatResponse.fromJson(Map<String, dynamic> json) => _$PokeStartChatResponseFromJson(json);

@override final  bool success;
@override final  String message;
@override final  PokeStartChatData data;

/// Create a copy of PokeStartChatResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PokeStartChatResponseCopyWith<_PokeStartChatResponse> get copyWith => __$PokeStartChatResponseCopyWithImpl<_PokeStartChatResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PokeStartChatResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PokeStartChatResponse&&(identical(other.success, success) || other.success == success)&&(identical(other.message, message) || other.message == message)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,message,data);

@override
String toString() {
  return 'PokeStartChatResponse(success: $success, message: $message, data: $data)';
}


}

/// @nodoc
abstract mixin class _$PokeStartChatResponseCopyWith<$Res> implements $PokeStartChatResponseCopyWith<$Res> {
  factory _$PokeStartChatResponseCopyWith(_PokeStartChatResponse value, $Res Function(_PokeStartChatResponse) _then) = __$PokeStartChatResponseCopyWithImpl;
@override @useResult
$Res call({
 bool success, String message, PokeStartChatData data
});


@override $PokeStartChatDataCopyWith<$Res> get data;

}
/// @nodoc
class __$PokeStartChatResponseCopyWithImpl<$Res>
    implements _$PokeStartChatResponseCopyWith<$Res> {
  __$PokeStartChatResponseCopyWithImpl(this._self, this._then);

  final _PokeStartChatResponse _self;
  final $Res Function(_PokeStartChatResponse) _then;

/// Create a copy of PokeStartChatResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? success = null,Object? message = null,Object? data = null,}) {
  return _then(_PokeStartChatResponse(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as PokeStartChatData,
  ));
}

/// Create a copy of PokeStartChatResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PokeStartChatDataCopyWith<$Res> get data {
  
  return $PokeStartChatDataCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// @nodoc
mixin _$PokeStartChatData {

 PokeModel get poke; String get chatWithUserId;
/// Create a copy of PokeStartChatData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PokeStartChatDataCopyWith<PokeStartChatData> get copyWith => _$PokeStartChatDataCopyWithImpl<PokeStartChatData>(this as PokeStartChatData, _$identity);

  /// Serializes this PokeStartChatData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PokeStartChatData&&(identical(other.poke, poke) || other.poke == poke)&&(identical(other.chatWithUserId, chatWithUserId) || other.chatWithUserId == chatWithUserId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,poke,chatWithUserId);

@override
String toString() {
  return 'PokeStartChatData(poke: $poke, chatWithUserId: $chatWithUserId)';
}


}

/// @nodoc
abstract mixin class $PokeStartChatDataCopyWith<$Res>  {
  factory $PokeStartChatDataCopyWith(PokeStartChatData value, $Res Function(PokeStartChatData) _then) = _$PokeStartChatDataCopyWithImpl;
@useResult
$Res call({
 PokeModel poke, String chatWithUserId
});


$PokeModelCopyWith<$Res> get poke;

}
/// @nodoc
class _$PokeStartChatDataCopyWithImpl<$Res>
    implements $PokeStartChatDataCopyWith<$Res> {
  _$PokeStartChatDataCopyWithImpl(this._self, this._then);

  final PokeStartChatData _self;
  final $Res Function(PokeStartChatData) _then;

/// Create a copy of PokeStartChatData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? poke = null,Object? chatWithUserId = null,}) {
  return _then(_self.copyWith(
poke: null == poke ? _self.poke : poke // ignore: cast_nullable_to_non_nullable
as PokeModel,chatWithUserId: null == chatWithUserId ? _self.chatWithUserId : chatWithUserId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}
/// Create a copy of PokeStartChatData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PokeModelCopyWith<$Res> get poke {
  
  return $PokeModelCopyWith<$Res>(_self.poke, (value) {
    return _then(_self.copyWith(poke: value));
  });
}
}


/// Adds pattern-matching-related methods to [PokeStartChatData].
extension PokeStartChatDataPatterns on PokeStartChatData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PokeStartChatData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PokeStartChatData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PokeStartChatData value)  $default,){
final _that = this;
switch (_that) {
case _PokeStartChatData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PokeStartChatData value)?  $default,){
final _that = this;
switch (_that) {
case _PokeStartChatData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( PokeModel poke,  String chatWithUserId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PokeStartChatData() when $default != null:
return $default(_that.poke,_that.chatWithUserId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( PokeModel poke,  String chatWithUserId)  $default,) {final _that = this;
switch (_that) {
case _PokeStartChatData():
return $default(_that.poke,_that.chatWithUserId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( PokeModel poke,  String chatWithUserId)?  $default,) {final _that = this;
switch (_that) {
case _PokeStartChatData() when $default != null:
return $default(_that.poke,_that.chatWithUserId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PokeStartChatData implements PokeStartChatData {
  const _PokeStartChatData({required this.poke, required this.chatWithUserId});
  factory _PokeStartChatData.fromJson(Map<String, dynamic> json) => _$PokeStartChatDataFromJson(json);

@override final  PokeModel poke;
@override final  String chatWithUserId;

/// Create a copy of PokeStartChatData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PokeStartChatDataCopyWith<_PokeStartChatData> get copyWith => __$PokeStartChatDataCopyWithImpl<_PokeStartChatData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PokeStartChatDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PokeStartChatData&&(identical(other.poke, poke) || other.poke == poke)&&(identical(other.chatWithUserId, chatWithUserId) || other.chatWithUserId == chatWithUserId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,poke,chatWithUserId);

@override
String toString() {
  return 'PokeStartChatData(poke: $poke, chatWithUserId: $chatWithUserId)';
}


}

/// @nodoc
abstract mixin class _$PokeStartChatDataCopyWith<$Res> implements $PokeStartChatDataCopyWith<$Res> {
  factory _$PokeStartChatDataCopyWith(_PokeStartChatData value, $Res Function(_PokeStartChatData) _then) = __$PokeStartChatDataCopyWithImpl;
@override @useResult
$Res call({
 PokeModel poke, String chatWithUserId
});


@override $PokeModelCopyWith<$Res> get poke;

}
/// @nodoc
class __$PokeStartChatDataCopyWithImpl<$Res>
    implements _$PokeStartChatDataCopyWith<$Res> {
  __$PokeStartChatDataCopyWithImpl(this._self, this._then);

  final _PokeStartChatData _self;
  final $Res Function(_PokeStartChatData) _then;

/// Create a copy of PokeStartChatData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? poke = null,Object? chatWithUserId = null,}) {
  return _then(_PokeStartChatData(
poke: null == poke ? _self.poke : poke // ignore: cast_nullable_to_non_nullable
as PokeModel,chatWithUserId: null == chatWithUserId ? _self.chatWithUserId : chatWithUserId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of PokeStartChatData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PokeModelCopyWith<$Res> get poke {
  
  return $PokeModelCopyWith<$Res>(_self.poke, (value) {
    return _then(_self.copyWith(poke: value));
  });
}
}

// dart format on
