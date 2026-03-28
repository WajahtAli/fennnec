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

 List<ChatModel> get chats; List<CallModel> get calls; List<MemberModel> get members;// added
 PaginationModel get pagination;
/// Create a copy of ChatAndCallsData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatAndCallsDataCopyWith<ChatAndCallsData> get copyWith => _$ChatAndCallsDataCopyWithImpl<ChatAndCallsData>(this as ChatAndCallsData, _$identity);

  /// Serializes this ChatAndCallsData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatAndCallsData&&const DeepCollectionEquality().equals(other.chats, chats)&&const DeepCollectionEquality().equals(other.calls, calls)&&const DeepCollectionEquality().equals(other.members, members)&&(identical(other.pagination, pagination) || other.pagination == pagination));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(chats),const DeepCollectionEquality().hash(calls),const DeepCollectionEquality().hash(members),pagination);

@override
String toString() {
  return 'ChatAndCallsData(chats: $chats, calls: $calls, members: $members, pagination: $pagination)';
}


}

/// @nodoc
abstract mixin class $ChatAndCallsDataCopyWith<$Res>  {
  factory $ChatAndCallsDataCopyWith(ChatAndCallsData value, $Res Function(ChatAndCallsData) _then) = _$ChatAndCallsDataCopyWithImpl;
@useResult
$Res call({
 List<ChatModel> chats, List<CallModel> calls, List<MemberModel> members, PaginationModel pagination
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
@pragma('vm:prefer-inline') @override $Res call({Object? chats = null,Object? calls = null,Object? members = null,Object? pagination = null,}) {
  return _then(_self.copyWith(
chats: null == chats ? _self.chats : chats // ignore: cast_nullable_to_non_nullable
as List<ChatModel>,calls: null == calls ? _self.calls : calls // ignore: cast_nullable_to_non_nullable
as List<CallModel>,members: null == members ? _self.members : members // ignore: cast_nullable_to_non_nullable
as List<MemberModel>,pagination: null == pagination ? _self.pagination : pagination // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<ChatModel> chats,  List<CallModel> calls,  List<MemberModel> members,  PaginationModel pagination)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatAndCallsData() when $default != null:
return $default(_that.chats,_that.calls,_that.members,_that.pagination);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<ChatModel> chats,  List<CallModel> calls,  List<MemberModel> members,  PaginationModel pagination)  $default,) {final _that = this;
switch (_that) {
case _ChatAndCallsData():
return $default(_that.chats,_that.calls,_that.members,_that.pagination);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<ChatModel> chats,  List<CallModel> calls,  List<MemberModel> members,  PaginationModel pagination)?  $default,) {final _that = this;
switch (_that) {
case _ChatAndCallsData() when $default != null:
return $default(_that.chats,_that.calls,_that.members,_that.pagination);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChatAndCallsData implements ChatAndCallsData {
  const _ChatAndCallsData({required final  List<ChatModel> chats, required final  List<CallModel> calls, final  List<MemberModel> members = const [], required this.pagination}): _chats = chats,_calls = calls,_members = members;
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

 final  List<MemberModel> _members;
@override@JsonKey() List<MemberModel> get members {
  if (_members is EqualUnmodifiableListView) return _members;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_members);
}

// added
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatAndCallsData&&const DeepCollectionEquality().equals(other._chats, _chats)&&const DeepCollectionEquality().equals(other._calls, _calls)&&const DeepCollectionEquality().equals(other._members, _members)&&(identical(other.pagination, pagination) || other.pagination == pagination));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_chats),const DeepCollectionEquality().hash(_calls),const DeepCollectionEquality().hash(_members),pagination);

@override
String toString() {
  return 'ChatAndCallsData(chats: $chats, calls: $calls, members: $members, pagination: $pagination)';
}


}

/// @nodoc
abstract mixin class _$ChatAndCallsDataCopyWith<$Res> implements $ChatAndCallsDataCopyWith<$Res> {
  factory _$ChatAndCallsDataCopyWith(_ChatAndCallsData value, $Res Function(_ChatAndCallsData) _then) = __$ChatAndCallsDataCopyWithImpl;
@override @useResult
$Res call({
 List<ChatModel> chats, List<CallModel> calls, List<MemberModel> members, PaginationModel pagination
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
@override @pragma('vm:prefer-inline') $Res call({Object? chats = null,Object? calls = null,Object? members = null,Object? pagination = null,}) {
  return _then(_ChatAndCallsData(
chats: null == chats ? _self._chats : chats // ignore: cast_nullable_to_non_nullable
as List<ChatModel>,calls: null == calls ? _self._calls : calls // ignore: cast_nullable_to_non_nullable
as List<CallModel>,members: null == members ? _self._members : members // ignore: cast_nullable_to_non_nullable
as List<MemberModel>,pagination: null == pagination ? _self.pagination : pagination // ignore: cast_nullable_to_non_nullable
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

 String get type; String get id; String get name; String get image; String get lastMessage;@JsonKey(fromJson: _dateTimeFromJsonNullable, toJson: _dateTimeToJsonNullable) DateTime? get lastMessageAt; String? get fromUserId; int get unreadCount; List<ChatPokeModel> get pokes; ChatMetaModel get meta; List<MemberModel>? get members;
/// Create a copy of ChatModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatModelCopyWith<ChatModel> get copyWith => _$ChatModelCopyWithImpl<ChatModel>(this as ChatModel, _$identity);

  /// Serializes this ChatModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatModel&&(identical(other.type, type) || other.type == type)&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.image, image) || other.image == image)&&(identical(other.lastMessage, lastMessage) || other.lastMessage == lastMessage)&&(identical(other.lastMessageAt, lastMessageAt) || other.lastMessageAt == lastMessageAt)&&(identical(other.fromUserId, fromUserId) || other.fromUserId == fromUserId)&&(identical(other.unreadCount, unreadCount) || other.unreadCount == unreadCount)&&const DeepCollectionEquality().equals(other.pokes, pokes)&&(identical(other.meta, meta) || other.meta == meta)&&const DeepCollectionEquality().equals(other.members, members));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,id,name,image,lastMessage,lastMessageAt,fromUserId,unreadCount,const DeepCollectionEquality().hash(pokes),meta,const DeepCollectionEquality().hash(members));

@override
String toString() {
  return 'ChatModel(type: $type, id: $id, name: $name, image: $image, lastMessage: $lastMessage, lastMessageAt: $lastMessageAt, fromUserId: $fromUserId, unreadCount: $unreadCount, pokes: $pokes, meta: $meta, members: $members)';
}


}

/// @nodoc
abstract mixin class $ChatModelCopyWith<$Res>  {
  factory $ChatModelCopyWith(ChatModel value, $Res Function(ChatModel) _then) = _$ChatModelCopyWithImpl;
@useResult
$Res call({
 String type, String id, String name, String image, String lastMessage,@JsonKey(fromJson: _dateTimeFromJsonNullable, toJson: _dateTimeToJsonNullable) DateTime? lastMessageAt, String? fromUserId, int unreadCount, List<ChatPokeModel> pokes, ChatMetaModel meta, List<MemberModel>? members
});


$ChatMetaModelCopyWith<$Res> get meta;

}
/// @nodoc
class _$ChatModelCopyWithImpl<$Res>
    implements $ChatModelCopyWith<$Res> {
  _$ChatModelCopyWithImpl(this._self, this._then);

  final ChatModel _self;
  final $Res Function(ChatModel) _then;

/// Create a copy of ChatModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? id = null,Object? name = null,Object? image = null,Object? lastMessage = null,Object? lastMessageAt = freezed,Object? fromUserId = freezed,Object? unreadCount = null,Object? pokes = null,Object? meta = null,Object? members = freezed,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,image: null == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String,lastMessage: null == lastMessage ? _self.lastMessage : lastMessage // ignore: cast_nullable_to_non_nullable
as String,lastMessageAt: freezed == lastMessageAt ? _self.lastMessageAt : lastMessageAt // ignore: cast_nullable_to_non_nullable
as DateTime?,fromUserId: freezed == fromUserId ? _self.fromUserId : fromUserId // ignore: cast_nullable_to_non_nullable
as String?,unreadCount: null == unreadCount ? _self.unreadCount : unreadCount // ignore: cast_nullable_to_non_nullable
as int,pokes: null == pokes ? _self.pokes : pokes // ignore: cast_nullable_to_non_nullable
as List<ChatPokeModel>,meta: null == meta ? _self.meta : meta // ignore: cast_nullable_to_non_nullable
as ChatMetaModel,members: freezed == members ? _self.members : members // ignore: cast_nullable_to_non_nullable
as List<MemberModel>?,
  ));
}
/// Create a copy of ChatModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ChatMetaModelCopyWith<$Res> get meta {
  
  return $ChatMetaModelCopyWith<$Res>(_self.meta, (value) {
    return _then(_self.copyWith(meta: value));
  });
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String type,  String id,  String name,  String image,  String lastMessage, @JsonKey(fromJson: _dateTimeFromJsonNullable, toJson: _dateTimeToJsonNullable)  DateTime? lastMessageAt,  String? fromUserId,  int unreadCount,  List<ChatPokeModel> pokes,  ChatMetaModel meta,  List<MemberModel>? members)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatModel() when $default != null:
return $default(_that.type,_that.id,_that.name,_that.image,_that.lastMessage,_that.lastMessageAt,_that.fromUserId,_that.unreadCount,_that.pokes,_that.meta,_that.members);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String type,  String id,  String name,  String image,  String lastMessage, @JsonKey(fromJson: _dateTimeFromJsonNullable, toJson: _dateTimeToJsonNullable)  DateTime? lastMessageAt,  String? fromUserId,  int unreadCount,  List<ChatPokeModel> pokes,  ChatMetaModel meta,  List<MemberModel>? members)  $default,) {final _that = this;
switch (_that) {
case _ChatModel():
return $default(_that.type,_that.id,_that.name,_that.image,_that.lastMessage,_that.lastMessageAt,_that.fromUserId,_that.unreadCount,_that.pokes,_that.meta,_that.members);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String type,  String id,  String name,  String image,  String lastMessage, @JsonKey(fromJson: _dateTimeFromJsonNullable, toJson: _dateTimeToJsonNullable)  DateTime? lastMessageAt,  String? fromUserId,  int unreadCount,  List<ChatPokeModel> pokes,  ChatMetaModel meta,  List<MemberModel>? members)?  $default,) {final _that = this;
switch (_that) {
case _ChatModel() when $default != null:
return $default(_that.type,_that.id,_that.name,_that.image,_that.lastMessage,_that.lastMessageAt,_that.fromUserId,_that.unreadCount,_that.pokes,_that.meta,_that.members);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChatModel implements ChatModel {
  const _ChatModel({required this.type, required this.id, required this.name, this.image = '', this.lastMessage = '', @JsonKey(fromJson: _dateTimeFromJsonNullable, toJson: _dateTimeToJsonNullable) this.lastMessageAt, this.fromUserId, required this.unreadCount, final  List<ChatPokeModel> pokes = const [], this.meta = const ChatMetaModel(), final  List<MemberModel>? members}): _pokes = pokes,_members = members;
  factory _ChatModel.fromJson(Map<String, dynamic> json) => _$ChatModelFromJson(json);

@override final  String type;
@override final  String id;
@override final  String name;
@override@JsonKey() final  String image;
@override@JsonKey() final  String lastMessage;
@override@JsonKey(fromJson: _dateTimeFromJsonNullable, toJson: _dateTimeToJsonNullable) final  DateTime? lastMessageAt;
@override final  String? fromUserId;
@override final  int unreadCount;
 final  List<ChatPokeModel> _pokes;
@override@JsonKey() List<ChatPokeModel> get pokes {
  if (_pokes is EqualUnmodifiableListView) return _pokes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_pokes);
}

@override@JsonKey() final  ChatMetaModel meta;
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatModel&&(identical(other.type, type) || other.type == type)&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.image, image) || other.image == image)&&(identical(other.lastMessage, lastMessage) || other.lastMessage == lastMessage)&&(identical(other.lastMessageAt, lastMessageAt) || other.lastMessageAt == lastMessageAt)&&(identical(other.fromUserId, fromUserId) || other.fromUserId == fromUserId)&&(identical(other.unreadCount, unreadCount) || other.unreadCount == unreadCount)&&const DeepCollectionEquality().equals(other._pokes, _pokes)&&(identical(other.meta, meta) || other.meta == meta)&&const DeepCollectionEquality().equals(other._members, _members));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,id,name,image,lastMessage,lastMessageAt,fromUserId,unreadCount,const DeepCollectionEquality().hash(_pokes),meta,const DeepCollectionEquality().hash(_members));

@override
String toString() {
  return 'ChatModel(type: $type, id: $id, name: $name, image: $image, lastMessage: $lastMessage, lastMessageAt: $lastMessageAt, fromUserId: $fromUserId, unreadCount: $unreadCount, pokes: $pokes, meta: $meta, members: $members)';
}


}

/// @nodoc
abstract mixin class _$ChatModelCopyWith<$Res> implements $ChatModelCopyWith<$Res> {
  factory _$ChatModelCopyWith(_ChatModel value, $Res Function(_ChatModel) _then) = __$ChatModelCopyWithImpl;
@override @useResult
$Res call({
 String type, String id, String name, String image, String lastMessage,@JsonKey(fromJson: _dateTimeFromJsonNullable, toJson: _dateTimeToJsonNullable) DateTime? lastMessageAt, String? fromUserId, int unreadCount, List<ChatPokeModel> pokes, ChatMetaModel meta, List<MemberModel>? members
});


@override $ChatMetaModelCopyWith<$Res> get meta;

}
/// @nodoc
class __$ChatModelCopyWithImpl<$Res>
    implements _$ChatModelCopyWith<$Res> {
  __$ChatModelCopyWithImpl(this._self, this._then);

  final _ChatModel _self;
  final $Res Function(_ChatModel) _then;

/// Create a copy of ChatModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? id = null,Object? name = null,Object? image = null,Object? lastMessage = null,Object? lastMessageAt = freezed,Object? fromUserId = freezed,Object? unreadCount = null,Object? pokes = null,Object? meta = null,Object? members = freezed,}) {
  return _then(_ChatModel(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,image: null == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String,lastMessage: null == lastMessage ? _self.lastMessage : lastMessage // ignore: cast_nullable_to_non_nullable
as String,lastMessageAt: freezed == lastMessageAt ? _self.lastMessageAt : lastMessageAt // ignore: cast_nullable_to_non_nullable
as DateTime?,fromUserId: freezed == fromUserId ? _self.fromUserId : fromUserId // ignore: cast_nullable_to_non_nullable
as String?,unreadCount: null == unreadCount ? _self.unreadCount : unreadCount // ignore: cast_nullable_to_non_nullable
as int,pokes: null == pokes ? _self._pokes : pokes // ignore: cast_nullable_to_non_nullable
as List<ChatPokeModel>,meta: null == meta ? _self.meta : meta // ignore: cast_nullable_to_non_nullable
as ChatMetaModel,members: freezed == members ? _self._members : members // ignore: cast_nullable_to_non_nullable
as List<MemberModel>?,
  ));
}

/// Create a copy of ChatModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ChatMetaModelCopyWith<$Res> get meta {
  
  return $ChatMetaModelCopyWith<$Res>(_self.meta, (value) {
    return _then(_self.copyWith(meta: value));
  });
}
}


/// @nodoc
mixin _$ChatPokeModel {

 String get id; ChatPokeUserModel? get fromUser; String? get toUserId; String get message;@JsonKey(fromJson: _dateTimeFromJsonNullable, toJson: _dateTimeToJsonNullable) DateTime? get createdAt; String? get status; String? get targetType; String? get targetId; String? get direction; PokePhotoDetail? get targetPhoto; ChatPokePromptModel? get targetPrompt;
/// Create a copy of ChatPokeModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatPokeModelCopyWith<ChatPokeModel> get copyWith => _$ChatPokeModelCopyWithImpl<ChatPokeModel>(this as ChatPokeModel, _$identity);

  /// Serializes this ChatPokeModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatPokeModel&&(identical(other.id, id) || other.id == id)&&(identical(other.fromUser, fromUser) || other.fromUser == fromUser)&&(identical(other.toUserId, toUserId) || other.toUserId == toUserId)&&(identical(other.message, message) || other.message == message)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.status, status) || other.status == status)&&(identical(other.targetType, targetType) || other.targetType == targetType)&&(identical(other.targetId, targetId) || other.targetId == targetId)&&(identical(other.direction, direction) || other.direction == direction)&&(identical(other.targetPhoto, targetPhoto) || other.targetPhoto == targetPhoto)&&(identical(other.targetPrompt, targetPrompt) || other.targetPrompt == targetPrompt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,fromUser,toUserId,message,createdAt,status,targetType,targetId,direction,targetPhoto,targetPrompt);

@override
String toString() {
  return 'ChatPokeModel(id: $id, fromUser: $fromUser, toUserId: $toUserId, message: $message, createdAt: $createdAt, status: $status, targetType: $targetType, targetId: $targetId, direction: $direction, targetPhoto: $targetPhoto, targetPrompt: $targetPrompt)';
}


}

/// @nodoc
abstract mixin class $ChatPokeModelCopyWith<$Res>  {
  factory $ChatPokeModelCopyWith(ChatPokeModel value, $Res Function(ChatPokeModel) _then) = _$ChatPokeModelCopyWithImpl;
@useResult
$Res call({
 String id, ChatPokeUserModel? fromUser, String? toUserId, String message,@JsonKey(fromJson: _dateTimeFromJsonNullable, toJson: _dateTimeToJsonNullable) DateTime? createdAt, String? status, String? targetType, String? targetId, String? direction, PokePhotoDetail? targetPhoto, ChatPokePromptModel? targetPrompt
});


$ChatPokeUserModelCopyWith<$Res>? get fromUser;$PokePhotoDetailCopyWith<$Res>? get targetPhoto;$ChatPokePromptModelCopyWith<$Res>? get targetPrompt;

}
/// @nodoc
class _$ChatPokeModelCopyWithImpl<$Res>
    implements $ChatPokeModelCopyWith<$Res> {
  _$ChatPokeModelCopyWithImpl(this._self, this._then);

  final ChatPokeModel _self;
  final $Res Function(ChatPokeModel) _then;

/// Create a copy of ChatPokeModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? fromUser = freezed,Object? toUserId = freezed,Object? message = null,Object? createdAt = freezed,Object? status = freezed,Object? targetType = freezed,Object? targetId = freezed,Object? direction = freezed,Object? targetPhoto = freezed,Object? targetPrompt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,fromUser: freezed == fromUser ? _self.fromUser : fromUser // ignore: cast_nullable_to_non_nullable
as ChatPokeUserModel?,toUserId: freezed == toUserId ? _self.toUserId : toUserId // ignore: cast_nullable_to_non_nullable
as String?,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,targetType: freezed == targetType ? _self.targetType : targetType // ignore: cast_nullable_to_non_nullable
as String?,targetId: freezed == targetId ? _self.targetId : targetId // ignore: cast_nullable_to_non_nullable
as String?,direction: freezed == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as String?,targetPhoto: freezed == targetPhoto ? _self.targetPhoto : targetPhoto // ignore: cast_nullable_to_non_nullable
as PokePhotoDetail?,targetPrompt: freezed == targetPrompt ? _self.targetPrompt : targetPrompt // ignore: cast_nullable_to_non_nullable
as ChatPokePromptModel?,
  ));
}
/// Create a copy of ChatPokeModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ChatPokeUserModelCopyWith<$Res>? get fromUser {
    if (_self.fromUser == null) {
    return null;
  }

  return $ChatPokeUserModelCopyWith<$Res>(_self.fromUser!, (value) {
    return _then(_self.copyWith(fromUser: value));
  });
}/// Create a copy of ChatPokeModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PokePhotoDetailCopyWith<$Res>? get targetPhoto {
    if (_self.targetPhoto == null) {
    return null;
  }

  return $PokePhotoDetailCopyWith<$Res>(_self.targetPhoto!, (value) {
    return _then(_self.copyWith(targetPhoto: value));
  });
}/// Create a copy of ChatPokeModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ChatPokePromptModelCopyWith<$Res>? get targetPrompt {
    if (_self.targetPrompt == null) {
    return null;
  }

  return $ChatPokePromptModelCopyWith<$Res>(_self.targetPrompt!, (value) {
    return _then(_self.copyWith(targetPrompt: value));
  });
}
}


/// Adds pattern-matching-related methods to [ChatPokeModel].
extension ChatPokeModelPatterns on ChatPokeModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatPokeModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatPokeModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatPokeModel value)  $default,){
final _that = this;
switch (_that) {
case _ChatPokeModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatPokeModel value)?  $default,){
final _that = this;
switch (_that) {
case _ChatPokeModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  ChatPokeUserModel? fromUser,  String? toUserId,  String message, @JsonKey(fromJson: _dateTimeFromJsonNullable, toJson: _dateTimeToJsonNullable)  DateTime? createdAt,  String? status,  String? targetType,  String? targetId,  String? direction,  PokePhotoDetail? targetPhoto,  ChatPokePromptModel? targetPrompt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatPokeModel() when $default != null:
return $default(_that.id,_that.fromUser,_that.toUserId,_that.message,_that.createdAt,_that.status,_that.targetType,_that.targetId,_that.direction,_that.targetPhoto,_that.targetPrompt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  ChatPokeUserModel? fromUser,  String? toUserId,  String message, @JsonKey(fromJson: _dateTimeFromJsonNullable, toJson: _dateTimeToJsonNullable)  DateTime? createdAt,  String? status,  String? targetType,  String? targetId,  String? direction,  PokePhotoDetail? targetPhoto,  ChatPokePromptModel? targetPrompt)  $default,) {final _that = this;
switch (_that) {
case _ChatPokeModel():
return $default(_that.id,_that.fromUser,_that.toUserId,_that.message,_that.createdAt,_that.status,_that.targetType,_that.targetId,_that.direction,_that.targetPhoto,_that.targetPrompt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  ChatPokeUserModel? fromUser,  String? toUserId,  String message, @JsonKey(fromJson: _dateTimeFromJsonNullable, toJson: _dateTimeToJsonNullable)  DateTime? createdAt,  String? status,  String? targetType,  String? targetId,  String? direction,  PokePhotoDetail? targetPhoto,  ChatPokePromptModel? targetPrompt)?  $default,) {final _that = this;
switch (_that) {
case _ChatPokeModel() when $default != null:
return $default(_that.id,_that.fromUser,_that.toUserId,_that.message,_that.createdAt,_that.status,_that.targetType,_that.targetId,_that.direction,_that.targetPhoto,_that.targetPrompt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChatPokeModel implements ChatPokeModel {
  const _ChatPokeModel({required this.id, this.fromUser, this.toUserId, this.message = '', @JsonKey(fromJson: _dateTimeFromJsonNullable, toJson: _dateTimeToJsonNullable) this.createdAt, this.status, this.targetType, this.targetId, this.direction, this.targetPhoto, this.targetPrompt});
  factory _ChatPokeModel.fromJson(Map<String, dynamic> json) => _$ChatPokeModelFromJson(json);

@override final  String id;
@override final  ChatPokeUserModel? fromUser;
@override final  String? toUserId;
@override@JsonKey() final  String message;
@override@JsonKey(fromJson: _dateTimeFromJsonNullable, toJson: _dateTimeToJsonNullable) final  DateTime? createdAt;
@override final  String? status;
@override final  String? targetType;
@override final  String? targetId;
@override final  String? direction;
@override final  PokePhotoDetail? targetPhoto;
@override final  ChatPokePromptModel? targetPrompt;

/// Create a copy of ChatPokeModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatPokeModelCopyWith<_ChatPokeModel> get copyWith => __$ChatPokeModelCopyWithImpl<_ChatPokeModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChatPokeModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatPokeModel&&(identical(other.id, id) || other.id == id)&&(identical(other.fromUser, fromUser) || other.fromUser == fromUser)&&(identical(other.toUserId, toUserId) || other.toUserId == toUserId)&&(identical(other.message, message) || other.message == message)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.status, status) || other.status == status)&&(identical(other.targetType, targetType) || other.targetType == targetType)&&(identical(other.targetId, targetId) || other.targetId == targetId)&&(identical(other.direction, direction) || other.direction == direction)&&(identical(other.targetPhoto, targetPhoto) || other.targetPhoto == targetPhoto)&&(identical(other.targetPrompt, targetPrompt) || other.targetPrompt == targetPrompt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,fromUser,toUserId,message,createdAt,status,targetType,targetId,direction,targetPhoto,targetPrompt);

@override
String toString() {
  return 'ChatPokeModel(id: $id, fromUser: $fromUser, toUserId: $toUserId, message: $message, createdAt: $createdAt, status: $status, targetType: $targetType, targetId: $targetId, direction: $direction, targetPhoto: $targetPhoto, targetPrompt: $targetPrompt)';
}


}

/// @nodoc
abstract mixin class _$ChatPokeModelCopyWith<$Res> implements $ChatPokeModelCopyWith<$Res> {
  factory _$ChatPokeModelCopyWith(_ChatPokeModel value, $Res Function(_ChatPokeModel) _then) = __$ChatPokeModelCopyWithImpl;
@override @useResult
$Res call({
 String id, ChatPokeUserModel? fromUser, String? toUserId, String message,@JsonKey(fromJson: _dateTimeFromJsonNullable, toJson: _dateTimeToJsonNullable) DateTime? createdAt, String? status, String? targetType, String? targetId, String? direction, PokePhotoDetail? targetPhoto, ChatPokePromptModel? targetPrompt
});


@override $ChatPokeUserModelCopyWith<$Res>? get fromUser;@override $PokePhotoDetailCopyWith<$Res>? get targetPhoto;@override $ChatPokePromptModelCopyWith<$Res>? get targetPrompt;

}
/// @nodoc
class __$ChatPokeModelCopyWithImpl<$Res>
    implements _$ChatPokeModelCopyWith<$Res> {
  __$ChatPokeModelCopyWithImpl(this._self, this._then);

  final _ChatPokeModel _self;
  final $Res Function(_ChatPokeModel) _then;

/// Create a copy of ChatPokeModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? fromUser = freezed,Object? toUserId = freezed,Object? message = null,Object? createdAt = freezed,Object? status = freezed,Object? targetType = freezed,Object? targetId = freezed,Object? direction = freezed,Object? targetPhoto = freezed,Object? targetPrompt = freezed,}) {
  return _then(_ChatPokeModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,fromUser: freezed == fromUser ? _self.fromUser : fromUser // ignore: cast_nullable_to_non_nullable
as ChatPokeUserModel?,toUserId: freezed == toUserId ? _self.toUserId : toUserId // ignore: cast_nullable_to_non_nullable
as String?,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,targetType: freezed == targetType ? _self.targetType : targetType // ignore: cast_nullable_to_non_nullable
as String?,targetId: freezed == targetId ? _self.targetId : targetId // ignore: cast_nullable_to_non_nullable
as String?,direction: freezed == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as String?,targetPhoto: freezed == targetPhoto ? _self.targetPhoto : targetPhoto // ignore: cast_nullable_to_non_nullable
as PokePhotoDetail?,targetPrompt: freezed == targetPrompt ? _self.targetPrompt : targetPrompt // ignore: cast_nullable_to_non_nullable
as ChatPokePromptModel?,
  ));
}

/// Create a copy of ChatPokeModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ChatPokeUserModelCopyWith<$Res>? get fromUser {
    if (_self.fromUser == null) {
    return null;
  }

  return $ChatPokeUserModelCopyWith<$Res>(_self.fromUser!, (value) {
    return _then(_self.copyWith(fromUser: value));
  });
}/// Create a copy of ChatPokeModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PokePhotoDetailCopyWith<$Res>? get targetPhoto {
    if (_self.targetPhoto == null) {
    return null;
  }

  return $PokePhotoDetailCopyWith<$Res>(_self.targetPhoto!, (value) {
    return _then(_self.copyWith(targetPhoto: value));
  });
}/// Create a copy of ChatPokeModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ChatPokePromptModelCopyWith<$Res>? get targetPrompt {
    if (_self.targetPrompt == null) {
    return null;
  }

  return $ChatPokePromptModelCopyWith<$Res>(_self.targetPrompt!, (value) {
    return _then(_self.copyWith(targetPrompt: value));
  });
}
}


/// @nodoc
mixin _$ChatPokeUserModel {

 String get id; String? get firstName; String? get lastName; String? get image;
/// Create a copy of ChatPokeUserModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatPokeUserModelCopyWith<ChatPokeUserModel> get copyWith => _$ChatPokeUserModelCopyWithImpl<ChatPokeUserModel>(this as ChatPokeUserModel, _$identity);

  /// Serializes this ChatPokeUserModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatPokeUserModel&&(identical(other.id, id) || other.id == id)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.image, image) || other.image == image));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,firstName,lastName,image);

@override
String toString() {
  return 'ChatPokeUserModel(id: $id, firstName: $firstName, lastName: $lastName, image: $image)';
}


}

/// @nodoc
abstract mixin class $ChatPokeUserModelCopyWith<$Res>  {
  factory $ChatPokeUserModelCopyWith(ChatPokeUserModel value, $Res Function(ChatPokeUserModel) _then) = _$ChatPokeUserModelCopyWithImpl;
@useResult
$Res call({
 String id, String? firstName, String? lastName, String? image
});




}
/// @nodoc
class _$ChatPokeUserModelCopyWithImpl<$Res>
    implements $ChatPokeUserModelCopyWith<$Res> {
  _$ChatPokeUserModelCopyWithImpl(this._self, this._then);

  final ChatPokeUserModel _self;
  final $Res Function(ChatPokeUserModel) _then;

/// Create a copy of ChatPokeUserModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? firstName = freezed,Object? lastName = freezed,Object? image = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,firstName: freezed == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String?,lastName: freezed == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String?,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ChatPokeUserModel].
extension ChatPokeUserModelPatterns on ChatPokeUserModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatPokeUserModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatPokeUserModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatPokeUserModel value)  $default,){
final _that = this;
switch (_that) {
case _ChatPokeUserModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatPokeUserModel value)?  $default,){
final _that = this;
switch (_that) {
case _ChatPokeUserModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String? firstName,  String? lastName,  String? image)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatPokeUserModel() when $default != null:
return $default(_that.id,_that.firstName,_that.lastName,_that.image);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String? firstName,  String? lastName,  String? image)  $default,) {final _that = this;
switch (_that) {
case _ChatPokeUserModel():
return $default(_that.id,_that.firstName,_that.lastName,_that.image);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String? firstName,  String? lastName,  String? image)?  $default,) {final _that = this;
switch (_that) {
case _ChatPokeUserModel() when $default != null:
return $default(_that.id,_that.firstName,_that.lastName,_that.image);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChatPokeUserModel implements ChatPokeUserModel {
  const _ChatPokeUserModel({required this.id, this.firstName, this.lastName, this.image});
  factory _ChatPokeUserModel.fromJson(Map<String, dynamic> json) => _$ChatPokeUserModelFromJson(json);

@override final  String id;
@override final  String? firstName;
@override final  String? lastName;
@override final  String? image;

/// Create a copy of ChatPokeUserModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatPokeUserModelCopyWith<_ChatPokeUserModel> get copyWith => __$ChatPokeUserModelCopyWithImpl<_ChatPokeUserModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChatPokeUserModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatPokeUserModel&&(identical(other.id, id) || other.id == id)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.image, image) || other.image == image));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,firstName,lastName,image);

@override
String toString() {
  return 'ChatPokeUserModel(id: $id, firstName: $firstName, lastName: $lastName, image: $image)';
}


}

/// @nodoc
abstract mixin class _$ChatPokeUserModelCopyWith<$Res> implements $ChatPokeUserModelCopyWith<$Res> {
  factory _$ChatPokeUserModelCopyWith(_ChatPokeUserModel value, $Res Function(_ChatPokeUserModel) _then) = __$ChatPokeUserModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String? firstName, String? lastName, String? image
});




}
/// @nodoc
class __$ChatPokeUserModelCopyWithImpl<$Res>
    implements _$ChatPokeUserModelCopyWith<$Res> {
  __$ChatPokeUserModelCopyWithImpl(this._self, this._then);

  final _ChatPokeUserModel _self;
  final $Res Function(_ChatPokeUserModel) _then;

/// Create a copy of ChatPokeUserModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? firstName = freezed,Object? lastName = freezed,Object? image = freezed,}) {
  return _then(_ChatPokeUserModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,firstName: freezed == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String?,lastName: freezed == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String?,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$ChatPokePromptModel {

 String get id; String? get promptTitle; String? get type; String? get promptAnswer;
/// Create a copy of ChatPokePromptModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatPokePromptModelCopyWith<ChatPokePromptModel> get copyWith => _$ChatPokePromptModelCopyWithImpl<ChatPokePromptModel>(this as ChatPokePromptModel, _$identity);

  /// Serializes this ChatPokePromptModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatPokePromptModel&&(identical(other.id, id) || other.id == id)&&(identical(other.promptTitle, promptTitle) || other.promptTitle == promptTitle)&&(identical(other.type, type) || other.type == type)&&(identical(other.promptAnswer, promptAnswer) || other.promptAnswer == promptAnswer));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,promptTitle,type,promptAnswer);

@override
String toString() {
  return 'ChatPokePromptModel(id: $id, promptTitle: $promptTitle, type: $type, promptAnswer: $promptAnswer)';
}


}

/// @nodoc
abstract mixin class $ChatPokePromptModelCopyWith<$Res>  {
  factory $ChatPokePromptModelCopyWith(ChatPokePromptModel value, $Res Function(ChatPokePromptModel) _then) = _$ChatPokePromptModelCopyWithImpl;
@useResult
$Res call({
 String id, String? promptTitle, String? type, String? promptAnswer
});




}
/// @nodoc
class _$ChatPokePromptModelCopyWithImpl<$Res>
    implements $ChatPokePromptModelCopyWith<$Res> {
  _$ChatPokePromptModelCopyWithImpl(this._self, this._then);

  final ChatPokePromptModel _self;
  final $Res Function(ChatPokePromptModel) _then;

/// Create a copy of ChatPokePromptModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? promptTitle = freezed,Object? type = freezed,Object? promptAnswer = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,promptTitle: freezed == promptTitle ? _self.promptTitle : promptTitle // ignore: cast_nullable_to_non_nullable
as String?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,promptAnswer: freezed == promptAnswer ? _self.promptAnswer : promptAnswer // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ChatPokePromptModel].
extension ChatPokePromptModelPatterns on ChatPokePromptModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatPokePromptModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatPokePromptModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatPokePromptModel value)  $default,){
final _that = this;
switch (_that) {
case _ChatPokePromptModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatPokePromptModel value)?  $default,){
final _that = this;
switch (_that) {
case _ChatPokePromptModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String? promptTitle,  String? type,  String? promptAnswer)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatPokePromptModel() when $default != null:
return $default(_that.id,_that.promptTitle,_that.type,_that.promptAnswer);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String? promptTitle,  String? type,  String? promptAnswer)  $default,) {final _that = this;
switch (_that) {
case _ChatPokePromptModel():
return $default(_that.id,_that.promptTitle,_that.type,_that.promptAnswer);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String? promptTitle,  String? type,  String? promptAnswer)?  $default,) {final _that = this;
switch (_that) {
case _ChatPokePromptModel() when $default != null:
return $default(_that.id,_that.promptTitle,_that.type,_that.promptAnswer);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChatPokePromptModel implements ChatPokePromptModel {
  const _ChatPokePromptModel({required this.id, this.promptTitle, this.type, this.promptAnswer});
  factory _ChatPokePromptModel.fromJson(Map<String, dynamic> json) => _$ChatPokePromptModelFromJson(json);

@override final  String id;
@override final  String? promptTitle;
@override final  String? type;
@override final  String? promptAnswer;

/// Create a copy of ChatPokePromptModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatPokePromptModelCopyWith<_ChatPokePromptModel> get copyWith => __$ChatPokePromptModelCopyWithImpl<_ChatPokePromptModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChatPokePromptModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatPokePromptModel&&(identical(other.id, id) || other.id == id)&&(identical(other.promptTitle, promptTitle) || other.promptTitle == promptTitle)&&(identical(other.type, type) || other.type == type)&&(identical(other.promptAnswer, promptAnswer) || other.promptAnswer == promptAnswer));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,promptTitle,type,promptAnswer);

@override
String toString() {
  return 'ChatPokePromptModel(id: $id, promptTitle: $promptTitle, type: $type, promptAnswer: $promptAnswer)';
}


}

/// @nodoc
abstract mixin class _$ChatPokePromptModelCopyWith<$Res> implements $ChatPokePromptModelCopyWith<$Res> {
  factory _$ChatPokePromptModelCopyWith(_ChatPokePromptModel value, $Res Function(_ChatPokePromptModel) _then) = __$ChatPokePromptModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String? promptTitle, String? type, String? promptAnswer
});




}
/// @nodoc
class __$ChatPokePromptModelCopyWithImpl<$Res>
    implements _$ChatPokePromptModelCopyWith<$Res> {
  __$ChatPokePromptModelCopyWithImpl(this._self, this._then);

  final _ChatPokePromptModel _self;
  final $Res Function(_ChatPokePromptModel) _then;

/// Create a copy of ChatPokePromptModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? promptTitle = freezed,Object? type = freezed,Object? promptAnswer = freezed,}) {
  return _then(_ChatPokePromptModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,promptTitle: freezed == promptTitle ? _self.promptTitle : promptTitle // ignore: cast_nullable_to_non_nullable
as String?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,promptAnswer: freezed == promptAnswer ? _self.promptAnswer : promptAnswer // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$ChatMetaModel {

 String? get peerUserId; int get totalPokes; int get receivedCount; int get sentCount; int get pendingCount; ChatLatestPokeModel? get latestPoke; bool get hasStartedChat; ChatDirectChatMetaModel? get directChat; String? get groupId; String? get receiverGroupId; List<String> get receiverGroupIds; bool? get isMatchedGroup; int get matchCount; ChatGroupsDetailsModel? get groupsDetails;
/// Create a copy of ChatMetaModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatMetaModelCopyWith<ChatMetaModel> get copyWith => _$ChatMetaModelCopyWithImpl<ChatMetaModel>(this as ChatMetaModel, _$identity);

  /// Serializes this ChatMetaModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatMetaModel&&(identical(other.peerUserId, peerUserId) || other.peerUserId == peerUserId)&&(identical(other.totalPokes, totalPokes) || other.totalPokes == totalPokes)&&(identical(other.receivedCount, receivedCount) || other.receivedCount == receivedCount)&&(identical(other.sentCount, sentCount) || other.sentCount == sentCount)&&(identical(other.pendingCount, pendingCount) || other.pendingCount == pendingCount)&&(identical(other.latestPoke, latestPoke) || other.latestPoke == latestPoke)&&(identical(other.hasStartedChat, hasStartedChat) || other.hasStartedChat == hasStartedChat)&&(identical(other.directChat, directChat) || other.directChat == directChat)&&(identical(other.groupId, groupId) || other.groupId == groupId)&&(identical(other.receiverGroupId, receiverGroupId) || other.receiverGroupId == receiverGroupId)&&const DeepCollectionEquality().equals(other.receiverGroupIds, receiverGroupIds)&&(identical(other.isMatchedGroup, isMatchedGroup) || other.isMatchedGroup == isMatchedGroup)&&(identical(other.matchCount, matchCount) || other.matchCount == matchCount)&&(identical(other.groupsDetails, groupsDetails) || other.groupsDetails == groupsDetails));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,peerUserId,totalPokes,receivedCount,sentCount,pendingCount,latestPoke,hasStartedChat,directChat,groupId,receiverGroupId,const DeepCollectionEquality().hash(receiverGroupIds),isMatchedGroup,matchCount,groupsDetails);

@override
String toString() {
  return 'ChatMetaModel(peerUserId: $peerUserId, totalPokes: $totalPokes, receivedCount: $receivedCount, sentCount: $sentCount, pendingCount: $pendingCount, latestPoke: $latestPoke, hasStartedChat: $hasStartedChat, directChat: $directChat, groupId: $groupId, receiverGroupId: $receiverGroupId, receiverGroupIds: $receiverGroupIds, isMatchedGroup: $isMatchedGroup, matchCount: $matchCount, groupsDetails: $groupsDetails)';
}


}

/// @nodoc
abstract mixin class $ChatMetaModelCopyWith<$Res>  {
  factory $ChatMetaModelCopyWith(ChatMetaModel value, $Res Function(ChatMetaModel) _then) = _$ChatMetaModelCopyWithImpl;
@useResult
$Res call({
 String? peerUserId, int totalPokes, int receivedCount, int sentCount, int pendingCount, ChatLatestPokeModel? latestPoke, bool hasStartedChat, ChatDirectChatMetaModel? directChat, String? groupId, String? receiverGroupId, List<String> receiverGroupIds, bool? isMatchedGroup, int matchCount, ChatGroupsDetailsModel? groupsDetails
});


$ChatLatestPokeModelCopyWith<$Res>? get latestPoke;$ChatDirectChatMetaModelCopyWith<$Res>? get directChat;$ChatGroupsDetailsModelCopyWith<$Res>? get groupsDetails;

}
/// @nodoc
class _$ChatMetaModelCopyWithImpl<$Res>
    implements $ChatMetaModelCopyWith<$Res> {
  _$ChatMetaModelCopyWithImpl(this._self, this._then);

  final ChatMetaModel _self;
  final $Res Function(ChatMetaModel) _then;

/// Create a copy of ChatMetaModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? peerUserId = freezed,Object? totalPokes = null,Object? receivedCount = null,Object? sentCount = null,Object? pendingCount = null,Object? latestPoke = freezed,Object? hasStartedChat = null,Object? directChat = freezed,Object? groupId = freezed,Object? receiverGroupId = freezed,Object? receiverGroupIds = null,Object? isMatchedGroup = freezed,Object? matchCount = null,Object? groupsDetails = freezed,}) {
  return _then(_self.copyWith(
peerUserId: freezed == peerUserId ? _self.peerUserId : peerUserId // ignore: cast_nullable_to_non_nullable
as String?,totalPokes: null == totalPokes ? _self.totalPokes : totalPokes // ignore: cast_nullable_to_non_nullable
as int,receivedCount: null == receivedCount ? _self.receivedCount : receivedCount // ignore: cast_nullable_to_non_nullable
as int,sentCount: null == sentCount ? _self.sentCount : sentCount // ignore: cast_nullable_to_non_nullable
as int,pendingCount: null == pendingCount ? _self.pendingCount : pendingCount // ignore: cast_nullable_to_non_nullable
as int,latestPoke: freezed == latestPoke ? _self.latestPoke : latestPoke // ignore: cast_nullable_to_non_nullable
as ChatLatestPokeModel?,hasStartedChat: null == hasStartedChat ? _self.hasStartedChat : hasStartedChat // ignore: cast_nullable_to_non_nullable
as bool,directChat: freezed == directChat ? _self.directChat : directChat // ignore: cast_nullable_to_non_nullable
as ChatDirectChatMetaModel?,groupId: freezed == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as String?,receiverGroupId: freezed == receiverGroupId ? _self.receiverGroupId : receiverGroupId // ignore: cast_nullable_to_non_nullable
as String?,receiverGroupIds: null == receiverGroupIds ? _self.receiverGroupIds : receiverGroupIds // ignore: cast_nullable_to_non_nullable
as List<String>,isMatchedGroup: freezed == isMatchedGroup ? _self.isMatchedGroup : isMatchedGroup // ignore: cast_nullable_to_non_nullable
as bool?,matchCount: null == matchCount ? _self.matchCount : matchCount // ignore: cast_nullable_to_non_nullable
as int,groupsDetails: freezed == groupsDetails ? _self.groupsDetails : groupsDetails // ignore: cast_nullable_to_non_nullable
as ChatGroupsDetailsModel?,
  ));
}
/// Create a copy of ChatMetaModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ChatLatestPokeModelCopyWith<$Res>? get latestPoke {
    if (_self.latestPoke == null) {
    return null;
  }

  return $ChatLatestPokeModelCopyWith<$Res>(_self.latestPoke!, (value) {
    return _then(_self.copyWith(latestPoke: value));
  });
}/// Create a copy of ChatMetaModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ChatDirectChatMetaModelCopyWith<$Res>? get directChat {
    if (_self.directChat == null) {
    return null;
  }

  return $ChatDirectChatMetaModelCopyWith<$Res>(_self.directChat!, (value) {
    return _then(_self.copyWith(directChat: value));
  });
}/// Create a copy of ChatMetaModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ChatGroupsDetailsModelCopyWith<$Res>? get groupsDetails {
    if (_self.groupsDetails == null) {
    return null;
  }

  return $ChatGroupsDetailsModelCopyWith<$Res>(_self.groupsDetails!, (value) {
    return _then(_self.copyWith(groupsDetails: value));
  });
}
}


/// Adds pattern-matching-related methods to [ChatMetaModel].
extension ChatMetaModelPatterns on ChatMetaModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatMetaModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatMetaModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatMetaModel value)  $default,){
final _that = this;
switch (_that) {
case _ChatMetaModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatMetaModel value)?  $default,){
final _that = this;
switch (_that) {
case _ChatMetaModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? peerUserId,  int totalPokes,  int receivedCount,  int sentCount,  int pendingCount,  ChatLatestPokeModel? latestPoke,  bool hasStartedChat,  ChatDirectChatMetaModel? directChat,  String? groupId,  String? receiverGroupId,  List<String> receiverGroupIds,  bool? isMatchedGroup,  int matchCount,  ChatGroupsDetailsModel? groupsDetails)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatMetaModel() when $default != null:
return $default(_that.peerUserId,_that.totalPokes,_that.receivedCount,_that.sentCount,_that.pendingCount,_that.latestPoke,_that.hasStartedChat,_that.directChat,_that.groupId,_that.receiverGroupId,_that.receiverGroupIds,_that.isMatchedGroup,_that.matchCount,_that.groupsDetails);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? peerUserId,  int totalPokes,  int receivedCount,  int sentCount,  int pendingCount,  ChatLatestPokeModel? latestPoke,  bool hasStartedChat,  ChatDirectChatMetaModel? directChat,  String? groupId,  String? receiverGroupId,  List<String> receiverGroupIds,  bool? isMatchedGroup,  int matchCount,  ChatGroupsDetailsModel? groupsDetails)  $default,) {final _that = this;
switch (_that) {
case _ChatMetaModel():
return $default(_that.peerUserId,_that.totalPokes,_that.receivedCount,_that.sentCount,_that.pendingCount,_that.latestPoke,_that.hasStartedChat,_that.directChat,_that.groupId,_that.receiverGroupId,_that.receiverGroupIds,_that.isMatchedGroup,_that.matchCount,_that.groupsDetails);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? peerUserId,  int totalPokes,  int receivedCount,  int sentCount,  int pendingCount,  ChatLatestPokeModel? latestPoke,  bool hasStartedChat,  ChatDirectChatMetaModel? directChat,  String? groupId,  String? receiverGroupId,  List<String> receiverGroupIds,  bool? isMatchedGroup,  int matchCount,  ChatGroupsDetailsModel? groupsDetails)?  $default,) {final _that = this;
switch (_that) {
case _ChatMetaModel() when $default != null:
return $default(_that.peerUserId,_that.totalPokes,_that.receivedCount,_that.sentCount,_that.pendingCount,_that.latestPoke,_that.hasStartedChat,_that.directChat,_that.groupId,_that.receiverGroupId,_that.receiverGroupIds,_that.isMatchedGroup,_that.matchCount,_that.groupsDetails);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChatMetaModel implements ChatMetaModel {
  const _ChatMetaModel({this.peerUserId, this.totalPokes = 0, this.receivedCount = 0, this.sentCount = 0, this.pendingCount = 0, this.latestPoke, this.hasStartedChat = false, this.directChat, this.groupId, this.receiverGroupId, final  List<String> receiverGroupIds = const [], this.isMatchedGroup, this.matchCount = 0, this.groupsDetails}): _receiverGroupIds = receiverGroupIds;
  factory _ChatMetaModel.fromJson(Map<String, dynamic> json) => _$ChatMetaModelFromJson(json);

@override final  String? peerUserId;
@override@JsonKey() final  int totalPokes;
@override@JsonKey() final  int receivedCount;
@override@JsonKey() final  int sentCount;
@override@JsonKey() final  int pendingCount;
@override final  ChatLatestPokeModel? latestPoke;
@override@JsonKey() final  bool hasStartedChat;
@override final  ChatDirectChatMetaModel? directChat;
@override final  String? groupId;
@override final  String? receiverGroupId;
 final  List<String> _receiverGroupIds;
@override@JsonKey() List<String> get receiverGroupIds {
  if (_receiverGroupIds is EqualUnmodifiableListView) return _receiverGroupIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_receiverGroupIds);
}

@override final  bool? isMatchedGroup;
@override@JsonKey() final  int matchCount;
@override final  ChatGroupsDetailsModel? groupsDetails;

/// Create a copy of ChatMetaModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatMetaModelCopyWith<_ChatMetaModel> get copyWith => __$ChatMetaModelCopyWithImpl<_ChatMetaModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChatMetaModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatMetaModel&&(identical(other.peerUserId, peerUserId) || other.peerUserId == peerUserId)&&(identical(other.totalPokes, totalPokes) || other.totalPokes == totalPokes)&&(identical(other.receivedCount, receivedCount) || other.receivedCount == receivedCount)&&(identical(other.sentCount, sentCount) || other.sentCount == sentCount)&&(identical(other.pendingCount, pendingCount) || other.pendingCount == pendingCount)&&(identical(other.latestPoke, latestPoke) || other.latestPoke == latestPoke)&&(identical(other.hasStartedChat, hasStartedChat) || other.hasStartedChat == hasStartedChat)&&(identical(other.directChat, directChat) || other.directChat == directChat)&&(identical(other.groupId, groupId) || other.groupId == groupId)&&(identical(other.receiverGroupId, receiverGroupId) || other.receiverGroupId == receiverGroupId)&&const DeepCollectionEquality().equals(other._receiverGroupIds, _receiverGroupIds)&&(identical(other.isMatchedGroup, isMatchedGroup) || other.isMatchedGroup == isMatchedGroup)&&(identical(other.matchCount, matchCount) || other.matchCount == matchCount)&&(identical(other.groupsDetails, groupsDetails) || other.groupsDetails == groupsDetails));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,peerUserId,totalPokes,receivedCount,sentCount,pendingCount,latestPoke,hasStartedChat,directChat,groupId,receiverGroupId,const DeepCollectionEquality().hash(_receiverGroupIds),isMatchedGroup,matchCount,groupsDetails);

@override
String toString() {
  return 'ChatMetaModel(peerUserId: $peerUserId, totalPokes: $totalPokes, receivedCount: $receivedCount, sentCount: $sentCount, pendingCount: $pendingCount, latestPoke: $latestPoke, hasStartedChat: $hasStartedChat, directChat: $directChat, groupId: $groupId, receiverGroupId: $receiverGroupId, receiverGroupIds: $receiverGroupIds, isMatchedGroup: $isMatchedGroup, matchCount: $matchCount, groupsDetails: $groupsDetails)';
}


}

/// @nodoc
abstract mixin class _$ChatMetaModelCopyWith<$Res> implements $ChatMetaModelCopyWith<$Res> {
  factory _$ChatMetaModelCopyWith(_ChatMetaModel value, $Res Function(_ChatMetaModel) _then) = __$ChatMetaModelCopyWithImpl;
@override @useResult
$Res call({
 String? peerUserId, int totalPokes, int receivedCount, int sentCount, int pendingCount, ChatLatestPokeModel? latestPoke, bool hasStartedChat, ChatDirectChatMetaModel? directChat, String? groupId, String? receiverGroupId, List<String> receiverGroupIds, bool? isMatchedGroup, int matchCount, ChatGroupsDetailsModel? groupsDetails
});


@override $ChatLatestPokeModelCopyWith<$Res>? get latestPoke;@override $ChatDirectChatMetaModelCopyWith<$Res>? get directChat;@override $ChatGroupsDetailsModelCopyWith<$Res>? get groupsDetails;

}
/// @nodoc
class __$ChatMetaModelCopyWithImpl<$Res>
    implements _$ChatMetaModelCopyWith<$Res> {
  __$ChatMetaModelCopyWithImpl(this._self, this._then);

  final _ChatMetaModel _self;
  final $Res Function(_ChatMetaModel) _then;

/// Create a copy of ChatMetaModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? peerUserId = freezed,Object? totalPokes = null,Object? receivedCount = null,Object? sentCount = null,Object? pendingCount = null,Object? latestPoke = freezed,Object? hasStartedChat = null,Object? directChat = freezed,Object? groupId = freezed,Object? receiverGroupId = freezed,Object? receiverGroupIds = null,Object? isMatchedGroup = freezed,Object? matchCount = null,Object? groupsDetails = freezed,}) {
  return _then(_ChatMetaModel(
peerUserId: freezed == peerUserId ? _self.peerUserId : peerUserId // ignore: cast_nullable_to_non_nullable
as String?,totalPokes: null == totalPokes ? _self.totalPokes : totalPokes // ignore: cast_nullable_to_non_nullable
as int,receivedCount: null == receivedCount ? _self.receivedCount : receivedCount // ignore: cast_nullable_to_non_nullable
as int,sentCount: null == sentCount ? _self.sentCount : sentCount // ignore: cast_nullable_to_non_nullable
as int,pendingCount: null == pendingCount ? _self.pendingCount : pendingCount // ignore: cast_nullable_to_non_nullable
as int,latestPoke: freezed == latestPoke ? _self.latestPoke : latestPoke // ignore: cast_nullable_to_non_nullable
as ChatLatestPokeModel?,hasStartedChat: null == hasStartedChat ? _self.hasStartedChat : hasStartedChat // ignore: cast_nullable_to_non_nullable
as bool,directChat: freezed == directChat ? _self.directChat : directChat // ignore: cast_nullable_to_non_nullable
as ChatDirectChatMetaModel?,groupId: freezed == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as String?,receiverGroupId: freezed == receiverGroupId ? _self.receiverGroupId : receiverGroupId // ignore: cast_nullable_to_non_nullable
as String?,receiverGroupIds: null == receiverGroupIds ? _self._receiverGroupIds : receiverGroupIds // ignore: cast_nullable_to_non_nullable
as List<String>,isMatchedGroup: freezed == isMatchedGroup ? _self.isMatchedGroup : isMatchedGroup // ignore: cast_nullable_to_non_nullable
as bool?,matchCount: null == matchCount ? _self.matchCount : matchCount // ignore: cast_nullable_to_non_nullable
as int,groupsDetails: freezed == groupsDetails ? _self.groupsDetails : groupsDetails // ignore: cast_nullable_to_non_nullable
as ChatGroupsDetailsModel?,
  ));
}

/// Create a copy of ChatMetaModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ChatLatestPokeModelCopyWith<$Res>? get latestPoke {
    if (_self.latestPoke == null) {
    return null;
  }

  return $ChatLatestPokeModelCopyWith<$Res>(_self.latestPoke!, (value) {
    return _then(_self.copyWith(latestPoke: value));
  });
}/// Create a copy of ChatMetaModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ChatDirectChatMetaModelCopyWith<$Res>? get directChat {
    if (_self.directChat == null) {
    return null;
  }

  return $ChatDirectChatMetaModelCopyWith<$Res>(_self.directChat!, (value) {
    return _then(_self.copyWith(directChat: value));
  });
}/// Create a copy of ChatMetaModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ChatGroupsDetailsModelCopyWith<$Res>? get groupsDetails {
    if (_self.groupsDetails == null) {
    return null;
  }

  return $ChatGroupsDetailsModelCopyWith<$Res>(_self.groupsDetails!, (value) {
    return _then(_self.copyWith(groupsDetails: value));
  });
}
}


/// @nodoc
mixin _$ChatGroupsDetailsModel {

 List<ChatGroupMemberUserModel> get userGroupMembers; List<MatchedGroupMembersModel> get matchedGroupMembers; ChatAboutGroupModel? get aboutThisGroup; List<String> get sharedMedia; List<String> get commonInterests; bool? get isMatched;
/// Create a copy of ChatGroupsDetailsModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatGroupsDetailsModelCopyWith<ChatGroupsDetailsModel> get copyWith => _$ChatGroupsDetailsModelCopyWithImpl<ChatGroupsDetailsModel>(this as ChatGroupsDetailsModel, _$identity);

  /// Serializes this ChatGroupsDetailsModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatGroupsDetailsModel&&const DeepCollectionEquality().equals(other.userGroupMembers, userGroupMembers)&&const DeepCollectionEquality().equals(other.matchedGroupMembers, matchedGroupMembers)&&(identical(other.aboutThisGroup, aboutThisGroup) || other.aboutThisGroup == aboutThisGroup)&&const DeepCollectionEquality().equals(other.sharedMedia, sharedMedia)&&const DeepCollectionEquality().equals(other.commonInterests, commonInterests)&&(identical(other.isMatched, isMatched) || other.isMatched == isMatched));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(userGroupMembers),const DeepCollectionEquality().hash(matchedGroupMembers),aboutThisGroup,const DeepCollectionEquality().hash(sharedMedia),const DeepCollectionEquality().hash(commonInterests),isMatched);

@override
String toString() {
  return 'ChatGroupsDetailsModel(userGroupMembers: $userGroupMembers, matchedGroupMembers: $matchedGroupMembers, aboutThisGroup: $aboutThisGroup, sharedMedia: $sharedMedia, commonInterests: $commonInterests, isMatched: $isMatched)';
}


}

/// @nodoc
abstract mixin class $ChatGroupsDetailsModelCopyWith<$Res>  {
  factory $ChatGroupsDetailsModelCopyWith(ChatGroupsDetailsModel value, $Res Function(ChatGroupsDetailsModel) _then) = _$ChatGroupsDetailsModelCopyWithImpl;
@useResult
$Res call({
 List<ChatGroupMemberUserModel> userGroupMembers, List<MatchedGroupMembersModel> matchedGroupMembers, ChatAboutGroupModel? aboutThisGroup, List<String> sharedMedia, List<String> commonInterests, bool? isMatched
});


$ChatAboutGroupModelCopyWith<$Res>? get aboutThisGroup;

}
/// @nodoc
class _$ChatGroupsDetailsModelCopyWithImpl<$Res>
    implements $ChatGroupsDetailsModelCopyWith<$Res> {
  _$ChatGroupsDetailsModelCopyWithImpl(this._self, this._then);

  final ChatGroupsDetailsModel _self;
  final $Res Function(ChatGroupsDetailsModel) _then;

/// Create a copy of ChatGroupsDetailsModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userGroupMembers = null,Object? matchedGroupMembers = null,Object? aboutThisGroup = freezed,Object? sharedMedia = null,Object? commonInterests = null,Object? isMatched = freezed,}) {
  return _then(_self.copyWith(
userGroupMembers: null == userGroupMembers ? _self.userGroupMembers : userGroupMembers // ignore: cast_nullable_to_non_nullable
as List<ChatGroupMemberUserModel>,matchedGroupMembers: null == matchedGroupMembers ? _self.matchedGroupMembers : matchedGroupMembers // ignore: cast_nullable_to_non_nullable
as List<MatchedGroupMembersModel>,aboutThisGroup: freezed == aboutThisGroup ? _self.aboutThisGroup : aboutThisGroup // ignore: cast_nullable_to_non_nullable
as ChatAboutGroupModel?,sharedMedia: null == sharedMedia ? _self.sharedMedia : sharedMedia // ignore: cast_nullable_to_non_nullable
as List<String>,commonInterests: null == commonInterests ? _self.commonInterests : commonInterests // ignore: cast_nullable_to_non_nullable
as List<String>,isMatched: freezed == isMatched ? _self.isMatched : isMatched // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}
/// Create a copy of ChatGroupsDetailsModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ChatAboutGroupModelCopyWith<$Res>? get aboutThisGroup {
    if (_self.aboutThisGroup == null) {
    return null;
  }

  return $ChatAboutGroupModelCopyWith<$Res>(_self.aboutThisGroup!, (value) {
    return _then(_self.copyWith(aboutThisGroup: value));
  });
}
}


/// Adds pattern-matching-related methods to [ChatGroupsDetailsModel].
extension ChatGroupsDetailsModelPatterns on ChatGroupsDetailsModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatGroupsDetailsModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatGroupsDetailsModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatGroupsDetailsModel value)  $default,){
final _that = this;
switch (_that) {
case _ChatGroupsDetailsModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatGroupsDetailsModel value)?  $default,){
final _that = this;
switch (_that) {
case _ChatGroupsDetailsModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<ChatGroupMemberUserModel> userGroupMembers,  List<MatchedGroupMembersModel> matchedGroupMembers,  ChatAboutGroupModel? aboutThisGroup,  List<String> sharedMedia,  List<String> commonInterests,  bool? isMatched)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatGroupsDetailsModel() when $default != null:
return $default(_that.userGroupMembers,_that.matchedGroupMembers,_that.aboutThisGroup,_that.sharedMedia,_that.commonInterests,_that.isMatched);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<ChatGroupMemberUserModel> userGroupMembers,  List<MatchedGroupMembersModel> matchedGroupMembers,  ChatAboutGroupModel? aboutThisGroup,  List<String> sharedMedia,  List<String> commonInterests,  bool? isMatched)  $default,) {final _that = this;
switch (_that) {
case _ChatGroupsDetailsModel():
return $default(_that.userGroupMembers,_that.matchedGroupMembers,_that.aboutThisGroup,_that.sharedMedia,_that.commonInterests,_that.isMatched);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<ChatGroupMemberUserModel> userGroupMembers,  List<MatchedGroupMembersModel> matchedGroupMembers,  ChatAboutGroupModel? aboutThisGroup,  List<String> sharedMedia,  List<String> commonInterests,  bool? isMatched)?  $default,) {final _that = this;
switch (_that) {
case _ChatGroupsDetailsModel() when $default != null:
return $default(_that.userGroupMembers,_that.matchedGroupMembers,_that.aboutThisGroup,_that.sharedMedia,_that.commonInterests,_that.isMatched);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChatGroupsDetailsModel implements ChatGroupsDetailsModel {
  const _ChatGroupsDetailsModel({final  List<ChatGroupMemberUserModel> userGroupMembers = const [], final  List<MatchedGroupMembersModel> matchedGroupMembers = const [], this.aboutThisGroup, final  List<String> sharedMedia = const [], final  List<String> commonInterests = const [], this.isMatched}): _userGroupMembers = userGroupMembers,_matchedGroupMembers = matchedGroupMembers,_sharedMedia = sharedMedia,_commonInterests = commonInterests;
  factory _ChatGroupsDetailsModel.fromJson(Map<String, dynamic> json) => _$ChatGroupsDetailsModelFromJson(json);

 final  List<ChatGroupMemberUserModel> _userGroupMembers;
@override@JsonKey() List<ChatGroupMemberUserModel> get userGroupMembers {
  if (_userGroupMembers is EqualUnmodifiableListView) return _userGroupMembers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_userGroupMembers);
}

 final  List<MatchedGroupMembersModel> _matchedGroupMembers;
@override@JsonKey() List<MatchedGroupMembersModel> get matchedGroupMembers {
  if (_matchedGroupMembers is EqualUnmodifiableListView) return _matchedGroupMembers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_matchedGroupMembers);
}

@override final  ChatAboutGroupModel? aboutThisGroup;
 final  List<String> _sharedMedia;
@override@JsonKey() List<String> get sharedMedia {
  if (_sharedMedia is EqualUnmodifiableListView) return _sharedMedia;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sharedMedia);
}

 final  List<String> _commonInterests;
@override@JsonKey() List<String> get commonInterests {
  if (_commonInterests is EqualUnmodifiableListView) return _commonInterests;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_commonInterests);
}

@override final  bool? isMatched;

/// Create a copy of ChatGroupsDetailsModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatGroupsDetailsModelCopyWith<_ChatGroupsDetailsModel> get copyWith => __$ChatGroupsDetailsModelCopyWithImpl<_ChatGroupsDetailsModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChatGroupsDetailsModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatGroupsDetailsModel&&const DeepCollectionEquality().equals(other._userGroupMembers, _userGroupMembers)&&const DeepCollectionEquality().equals(other._matchedGroupMembers, _matchedGroupMembers)&&(identical(other.aboutThisGroup, aboutThisGroup) || other.aboutThisGroup == aboutThisGroup)&&const DeepCollectionEquality().equals(other._sharedMedia, _sharedMedia)&&const DeepCollectionEquality().equals(other._commonInterests, _commonInterests)&&(identical(other.isMatched, isMatched) || other.isMatched == isMatched));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_userGroupMembers),const DeepCollectionEquality().hash(_matchedGroupMembers),aboutThisGroup,const DeepCollectionEquality().hash(_sharedMedia),const DeepCollectionEquality().hash(_commonInterests),isMatched);

@override
String toString() {
  return 'ChatGroupsDetailsModel(userGroupMembers: $userGroupMembers, matchedGroupMembers: $matchedGroupMembers, aboutThisGroup: $aboutThisGroup, sharedMedia: $sharedMedia, commonInterests: $commonInterests, isMatched: $isMatched)';
}


}

/// @nodoc
abstract mixin class _$ChatGroupsDetailsModelCopyWith<$Res> implements $ChatGroupsDetailsModelCopyWith<$Res> {
  factory _$ChatGroupsDetailsModelCopyWith(_ChatGroupsDetailsModel value, $Res Function(_ChatGroupsDetailsModel) _then) = __$ChatGroupsDetailsModelCopyWithImpl;
@override @useResult
$Res call({
 List<ChatGroupMemberUserModel> userGroupMembers, List<MatchedGroupMembersModel> matchedGroupMembers, ChatAboutGroupModel? aboutThisGroup, List<String> sharedMedia, List<String> commonInterests, bool? isMatched
});


@override $ChatAboutGroupModelCopyWith<$Res>? get aboutThisGroup;

}
/// @nodoc
class __$ChatGroupsDetailsModelCopyWithImpl<$Res>
    implements _$ChatGroupsDetailsModelCopyWith<$Res> {
  __$ChatGroupsDetailsModelCopyWithImpl(this._self, this._then);

  final _ChatGroupsDetailsModel _self;
  final $Res Function(_ChatGroupsDetailsModel) _then;

/// Create a copy of ChatGroupsDetailsModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userGroupMembers = null,Object? matchedGroupMembers = null,Object? aboutThisGroup = freezed,Object? sharedMedia = null,Object? commonInterests = null,Object? isMatched = freezed,}) {
  return _then(_ChatGroupsDetailsModel(
userGroupMembers: null == userGroupMembers ? _self._userGroupMembers : userGroupMembers // ignore: cast_nullable_to_non_nullable
as List<ChatGroupMemberUserModel>,matchedGroupMembers: null == matchedGroupMembers ? _self._matchedGroupMembers : matchedGroupMembers // ignore: cast_nullable_to_non_nullable
as List<MatchedGroupMembersModel>,aboutThisGroup: freezed == aboutThisGroup ? _self.aboutThisGroup : aboutThisGroup // ignore: cast_nullable_to_non_nullable
as ChatAboutGroupModel?,sharedMedia: null == sharedMedia ? _self._sharedMedia : sharedMedia // ignore: cast_nullable_to_non_nullable
as List<String>,commonInterests: null == commonInterests ? _self._commonInterests : commonInterests // ignore: cast_nullable_to_non_nullable
as List<String>,isMatched: freezed == isMatched ? _self.isMatched : isMatched // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

/// Create a copy of ChatGroupsDetailsModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ChatAboutGroupModelCopyWith<$Res>? get aboutThisGroup {
    if (_self.aboutThisGroup == null) {
    return null;
  }

  return $ChatAboutGroupModelCopyWith<$Res>(_self.aboutThisGroup!, (value) {
    return _then(_self.copyWith(aboutThisGroup: value));
  });
}
}


/// @nodoc
mixin _$MatchedGroupMembersModel {

 String? get groupId; List<ChatGroupMemberUserModel> get members;
/// Create a copy of MatchedGroupMembersModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MatchedGroupMembersModelCopyWith<MatchedGroupMembersModel> get copyWith => _$MatchedGroupMembersModelCopyWithImpl<MatchedGroupMembersModel>(this as MatchedGroupMembersModel, _$identity);

  /// Serializes this MatchedGroupMembersModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MatchedGroupMembersModel&&(identical(other.groupId, groupId) || other.groupId == groupId)&&const DeepCollectionEquality().equals(other.members, members));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,groupId,const DeepCollectionEquality().hash(members));

@override
String toString() {
  return 'MatchedGroupMembersModel(groupId: $groupId, members: $members)';
}


}

/// @nodoc
abstract mixin class $MatchedGroupMembersModelCopyWith<$Res>  {
  factory $MatchedGroupMembersModelCopyWith(MatchedGroupMembersModel value, $Res Function(MatchedGroupMembersModel) _then) = _$MatchedGroupMembersModelCopyWithImpl;
@useResult
$Res call({
 String? groupId, List<ChatGroupMemberUserModel> members
});




}
/// @nodoc
class _$MatchedGroupMembersModelCopyWithImpl<$Res>
    implements $MatchedGroupMembersModelCopyWith<$Res> {
  _$MatchedGroupMembersModelCopyWithImpl(this._self, this._then);

  final MatchedGroupMembersModel _self;
  final $Res Function(MatchedGroupMembersModel) _then;

/// Create a copy of MatchedGroupMembersModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? groupId = freezed,Object? members = null,}) {
  return _then(_self.copyWith(
groupId: freezed == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as String?,members: null == members ? _self.members : members // ignore: cast_nullable_to_non_nullable
as List<ChatGroupMemberUserModel>,
  ));
}

}


/// Adds pattern-matching-related methods to [MatchedGroupMembersModel].
extension MatchedGroupMembersModelPatterns on MatchedGroupMembersModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MatchedGroupMembersModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MatchedGroupMembersModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MatchedGroupMembersModel value)  $default,){
final _that = this;
switch (_that) {
case _MatchedGroupMembersModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MatchedGroupMembersModel value)?  $default,){
final _that = this;
switch (_that) {
case _MatchedGroupMembersModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? groupId,  List<ChatGroupMemberUserModel> members)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MatchedGroupMembersModel() when $default != null:
return $default(_that.groupId,_that.members);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? groupId,  List<ChatGroupMemberUserModel> members)  $default,) {final _that = this;
switch (_that) {
case _MatchedGroupMembersModel():
return $default(_that.groupId,_that.members);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? groupId,  List<ChatGroupMemberUserModel> members)?  $default,) {final _that = this;
switch (_that) {
case _MatchedGroupMembersModel() when $default != null:
return $default(_that.groupId,_that.members);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MatchedGroupMembersModel implements MatchedGroupMembersModel {
  const _MatchedGroupMembersModel({this.groupId, final  List<ChatGroupMemberUserModel> members = const []}): _members = members;
  factory _MatchedGroupMembersModel.fromJson(Map<String, dynamic> json) => _$MatchedGroupMembersModelFromJson(json);

@override final  String? groupId;
 final  List<ChatGroupMemberUserModel> _members;
@override@JsonKey() List<ChatGroupMemberUserModel> get members {
  if (_members is EqualUnmodifiableListView) return _members;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_members);
}


/// Create a copy of MatchedGroupMembersModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MatchedGroupMembersModelCopyWith<_MatchedGroupMembersModel> get copyWith => __$MatchedGroupMembersModelCopyWithImpl<_MatchedGroupMembersModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MatchedGroupMembersModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MatchedGroupMembersModel&&(identical(other.groupId, groupId) || other.groupId == groupId)&&const DeepCollectionEquality().equals(other._members, _members));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,groupId,const DeepCollectionEquality().hash(_members));

@override
String toString() {
  return 'MatchedGroupMembersModel(groupId: $groupId, members: $members)';
}


}

/// @nodoc
abstract mixin class _$MatchedGroupMembersModelCopyWith<$Res> implements $MatchedGroupMembersModelCopyWith<$Res> {
  factory _$MatchedGroupMembersModelCopyWith(_MatchedGroupMembersModel value, $Res Function(_MatchedGroupMembersModel) _then) = __$MatchedGroupMembersModelCopyWithImpl;
@override @useResult
$Res call({
 String? groupId, List<ChatGroupMemberUserModel> members
});




}
/// @nodoc
class __$MatchedGroupMembersModelCopyWithImpl<$Res>
    implements _$MatchedGroupMembersModelCopyWith<$Res> {
  __$MatchedGroupMembersModelCopyWithImpl(this._self, this._then);

  final _MatchedGroupMembersModel _self;
  final $Res Function(_MatchedGroupMembersModel) _then;

/// Create a copy of MatchedGroupMembersModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? groupId = freezed,Object? members = null,}) {
  return _then(_MatchedGroupMembersModel(
groupId: freezed == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as String?,members: null == members ? _self._members : members // ignore: cast_nullable_to_non_nullable
as List<ChatGroupMemberUserModel>,
  ));
}


}


/// @nodoc
mixin _$ChatGroupMemberUserModel {

 String get id; String? get firstName; String? get lastName; String? get image;
/// Create a copy of ChatGroupMemberUserModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatGroupMemberUserModelCopyWith<ChatGroupMemberUserModel> get copyWith => _$ChatGroupMemberUserModelCopyWithImpl<ChatGroupMemberUserModel>(this as ChatGroupMemberUserModel, _$identity);

  /// Serializes this ChatGroupMemberUserModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatGroupMemberUserModel&&(identical(other.id, id) || other.id == id)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.image, image) || other.image == image));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,firstName,lastName,image);

@override
String toString() {
  return 'ChatGroupMemberUserModel(id: $id, firstName: $firstName, lastName: $lastName, image: $image)';
}


}

/// @nodoc
abstract mixin class $ChatGroupMemberUserModelCopyWith<$Res>  {
  factory $ChatGroupMemberUserModelCopyWith(ChatGroupMemberUserModel value, $Res Function(ChatGroupMemberUserModel) _then) = _$ChatGroupMemberUserModelCopyWithImpl;
@useResult
$Res call({
 String id, String? firstName, String? lastName, String? image
});




}
/// @nodoc
class _$ChatGroupMemberUserModelCopyWithImpl<$Res>
    implements $ChatGroupMemberUserModelCopyWith<$Res> {
  _$ChatGroupMemberUserModelCopyWithImpl(this._self, this._then);

  final ChatGroupMemberUserModel _self;
  final $Res Function(ChatGroupMemberUserModel) _then;

/// Create a copy of ChatGroupMemberUserModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? firstName = freezed,Object? lastName = freezed,Object? image = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,firstName: freezed == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String?,lastName: freezed == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String?,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ChatGroupMemberUserModel].
extension ChatGroupMemberUserModelPatterns on ChatGroupMemberUserModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatGroupMemberUserModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatGroupMemberUserModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatGroupMemberUserModel value)  $default,){
final _that = this;
switch (_that) {
case _ChatGroupMemberUserModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatGroupMemberUserModel value)?  $default,){
final _that = this;
switch (_that) {
case _ChatGroupMemberUserModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String? firstName,  String? lastName,  String? image)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatGroupMemberUserModel() when $default != null:
return $default(_that.id,_that.firstName,_that.lastName,_that.image);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String? firstName,  String? lastName,  String? image)  $default,) {final _that = this;
switch (_that) {
case _ChatGroupMemberUserModel():
return $default(_that.id,_that.firstName,_that.lastName,_that.image);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String? firstName,  String? lastName,  String? image)?  $default,) {final _that = this;
switch (_that) {
case _ChatGroupMemberUserModel() when $default != null:
return $default(_that.id,_that.firstName,_that.lastName,_that.image);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChatGroupMemberUserModel implements ChatGroupMemberUserModel {
  const _ChatGroupMemberUserModel({required this.id, this.firstName, this.lastName, this.image});
  factory _ChatGroupMemberUserModel.fromJson(Map<String, dynamic> json) => _$ChatGroupMemberUserModelFromJson(json);

@override final  String id;
@override final  String? firstName;
@override final  String? lastName;
@override final  String? image;

/// Create a copy of ChatGroupMemberUserModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatGroupMemberUserModelCopyWith<_ChatGroupMemberUserModel> get copyWith => __$ChatGroupMemberUserModelCopyWithImpl<_ChatGroupMemberUserModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChatGroupMemberUserModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatGroupMemberUserModel&&(identical(other.id, id) || other.id == id)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.image, image) || other.image == image));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,firstName,lastName,image);

@override
String toString() {
  return 'ChatGroupMemberUserModel(id: $id, firstName: $firstName, lastName: $lastName, image: $image)';
}


}

/// @nodoc
abstract mixin class _$ChatGroupMemberUserModelCopyWith<$Res> implements $ChatGroupMemberUserModelCopyWith<$Res> {
  factory _$ChatGroupMemberUserModelCopyWith(_ChatGroupMemberUserModel value, $Res Function(_ChatGroupMemberUserModel) _then) = __$ChatGroupMemberUserModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String? firstName, String? lastName, String? image
});




}
/// @nodoc
class __$ChatGroupMemberUserModelCopyWithImpl<$Res>
    implements _$ChatGroupMemberUserModelCopyWith<$Res> {
  __$ChatGroupMemberUserModelCopyWithImpl(this._self, this._then);

  final _ChatGroupMemberUserModel _self;
  final $Res Function(_ChatGroupMemberUserModel) _then;

/// Create a copy of ChatGroupMemberUserModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? firstName = freezed,Object? lastName = freezed,Object? image = freezed,}) {
  return _then(_ChatGroupMemberUserModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,firstName: freezed == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String?,lastName: freezed == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String?,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$ChatAboutGroupModel {

 String? get bio; String? get fitsForGroup;
/// Create a copy of ChatAboutGroupModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatAboutGroupModelCopyWith<ChatAboutGroupModel> get copyWith => _$ChatAboutGroupModelCopyWithImpl<ChatAboutGroupModel>(this as ChatAboutGroupModel, _$identity);

  /// Serializes this ChatAboutGroupModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatAboutGroupModel&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.fitsForGroup, fitsForGroup) || other.fitsForGroup == fitsForGroup));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,bio,fitsForGroup);

@override
String toString() {
  return 'ChatAboutGroupModel(bio: $bio, fitsForGroup: $fitsForGroup)';
}


}

/// @nodoc
abstract mixin class $ChatAboutGroupModelCopyWith<$Res>  {
  factory $ChatAboutGroupModelCopyWith(ChatAboutGroupModel value, $Res Function(ChatAboutGroupModel) _then) = _$ChatAboutGroupModelCopyWithImpl;
@useResult
$Res call({
 String? bio, String? fitsForGroup
});




}
/// @nodoc
class _$ChatAboutGroupModelCopyWithImpl<$Res>
    implements $ChatAboutGroupModelCopyWith<$Res> {
  _$ChatAboutGroupModelCopyWithImpl(this._self, this._then);

  final ChatAboutGroupModel _self;
  final $Res Function(ChatAboutGroupModel) _then;

/// Create a copy of ChatAboutGroupModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? bio = freezed,Object? fitsForGroup = freezed,}) {
  return _then(_self.copyWith(
bio: freezed == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String?,fitsForGroup: freezed == fitsForGroup ? _self.fitsForGroup : fitsForGroup // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ChatAboutGroupModel].
extension ChatAboutGroupModelPatterns on ChatAboutGroupModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatAboutGroupModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatAboutGroupModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatAboutGroupModel value)  $default,){
final _that = this;
switch (_that) {
case _ChatAboutGroupModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatAboutGroupModel value)?  $default,){
final _that = this;
switch (_that) {
case _ChatAboutGroupModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? bio,  String? fitsForGroup)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatAboutGroupModel() when $default != null:
return $default(_that.bio,_that.fitsForGroup);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? bio,  String? fitsForGroup)  $default,) {final _that = this;
switch (_that) {
case _ChatAboutGroupModel():
return $default(_that.bio,_that.fitsForGroup);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? bio,  String? fitsForGroup)?  $default,) {final _that = this;
switch (_that) {
case _ChatAboutGroupModel() when $default != null:
return $default(_that.bio,_that.fitsForGroup);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChatAboutGroupModel implements ChatAboutGroupModel {
  const _ChatAboutGroupModel({this.bio, this.fitsForGroup});
  factory _ChatAboutGroupModel.fromJson(Map<String, dynamic> json) => _$ChatAboutGroupModelFromJson(json);

@override final  String? bio;
@override final  String? fitsForGroup;

/// Create a copy of ChatAboutGroupModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatAboutGroupModelCopyWith<_ChatAboutGroupModel> get copyWith => __$ChatAboutGroupModelCopyWithImpl<_ChatAboutGroupModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChatAboutGroupModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatAboutGroupModel&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.fitsForGroup, fitsForGroup) || other.fitsForGroup == fitsForGroup));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,bio,fitsForGroup);

@override
String toString() {
  return 'ChatAboutGroupModel(bio: $bio, fitsForGroup: $fitsForGroup)';
}


}

/// @nodoc
abstract mixin class _$ChatAboutGroupModelCopyWith<$Res> implements $ChatAboutGroupModelCopyWith<$Res> {
  factory _$ChatAboutGroupModelCopyWith(_ChatAboutGroupModel value, $Res Function(_ChatAboutGroupModel) _then) = __$ChatAboutGroupModelCopyWithImpl;
@override @useResult
$Res call({
 String? bio, String? fitsForGroup
});




}
/// @nodoc
class __$ChatAboutGroupModelCopyWithImpl<$Res>
    implements _$ChatAboutGroupModelCopyWith<$Res> {
  __$ChatAboutGroupModelCopyWithImpl(this._self, this._then);

  final _ChatAboutGroupModel _self;
  final $Res Function(_ChatAboutGroupModel) _then;

/// Create a copy of ChatAboutGroupModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? bio = freezed,Object? fitsForGroup = freezed,}) {
  return _then(_ChatAboutGroupModel(
bio: freezed == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String?,fitsForGroup: freezed == fitsForGroup ? _self.fitsForGroup : fitsForGroup // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$ChatLatestPokeModel {

 String? get id; String? get pokeId; String? get fromUserId; String? get toUserId; String? get peerUserId; String? get direction; String? get status; String? get targetType; String? get targetId;
/// Create a copy of ChatLatestPokeModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatLatestPokeModelCopyWith<ChatLatestPokeModel> get copyWith => _$ChatLatestPokeModelCopyWithImpl<ChatLatestPokeModel>(this as ChatLatestPokeModel, _$identity);

  /// Serializes this ChatLatestPokeModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatLatestPokeModel&&(identical(other.id, id) || other.id == id)&&(identical(other.pokeId, pokeId) || other.pokeId == pokeId)&&(identical(other.fromUserId, fromUserId) || other.fromUserId == fromUserId)&&(identical(other.toUserId, toUserId) || other.toUserId == toUserId)&&(identical(other.peerUserId, peerUserId) || other.peerUserId == peerUserId)&&(identical(other.direction, direction) || other.direction == direction)&&(identical(other.status, status) || other.status == status)&&(identical(other.targetType, targetType) || other.targetType == targetType)&&(identical(other.targetId, targetId) || other.targetId == targetId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,pokeId,fromUserId,toUserId,peerUserId,direction,status,targetType,targetId);

@override
String toString() {
  return 'ChatLatestPokeModel(id: $id, pokeId: $pokeId, fromUserId: $fromUserId, toUserId: $toUserId, peerUserId: $peerUserId, direction: $direction, status: $status, targetType: $targetType, targetId: $targetId)';
}


}

/// @nodoc
abstract mixin class $ChatLatestPokeModelCopyWith<$Res>  {
  factory $ChatLatestPokeModelCopyWith(ChatLatestPokeModel value, $Res Function(ChatLatestPokeModel) _then) = _$ChatLatestPokeModelCopyWithImpl;
@useResult
$Res call({
 String? id, String? pokeId, String? fromUserId, String? toUserId, String? peerUserId, String? direction, String? status, String? targetType, String? targetId
});




}
/// @nodoc
class _$ChatLatestPokeModelCopyWithImpl<$Res>
    implements $ChatLatestPokeModelCopyWith<$Res> {
  _$ChatLatestPokeModelCopyWithImpl(this._self, this._then);

  final ChatLatestPokeModel _self;
  final $Res Function(ChatLatestPokeModel) _then;

/// Create a copy of ChatLatestPokeModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? pokeId = freezed,Object? fromUserId = freezed,Object? toUserId = freezed,Object? peerUserId = freezed,Object? direction = freezed,Object? status = freezed,Object? targetType = freezed,Object? targetId = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,pokeId: freezed == pokeId ? _self.pokeId : pokeId // ignore: cast_nullable_to_non_nullable
as String?,fromUserId: freezed == fromUserId ? _self.fromUserId : fromUserId // ignore: cast_nullable_to_non_nullable
as String?,toUserId: freezed == toUserId ? _self.toUserId : toUserId // ignore: cast_nullable_to_non_nullable
as String?,peerUserId: freezed == peerUserId ? _self.peerUserId : peerUserId // ignore: cast_nullable_to_non_nullable
as String?,direction: freezed == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,targetType: freezed == targetType ? _self.targetType : targetType // ignore: cast_nullable_to_non_nullable
as String?,targetId: freezed == targetId ? _self.targetId : targetId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ChatLatestPokeModel].
extension ChatLatestPokeModelPatterns on ChatLatestPokeModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatLatestPokeModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatLatestPokeModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatLatestPokeModel value)  $default,){
final _that = this;
switch (_that) {
case _ChatLatestPokeModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatLatestPokeModel value)?  $default,){
final _that = this;
switch (_that) {
case _ChatLatestPokeModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  String? pokeId,  String? fromUserId,  String? toUserId,  String? peerUserId,  String? direction,  String? status,  String? targetType,  String? targetId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatLatestPokeModel() when $default != null:
return $default(_that.id,_that.pokeId,_that.fromUserId,_that.toUserId,_that.peerUserId,_that.direction,_that.status,_that.targetType,_that.targetId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  String? pokeId,  String? fromUserId,  String? toUserId,  String? peerUserId,  String? direction,  String? status,  String? targetType,  String? targetId)  $default,) {final _that = this;
switch (_that) {
case _ChatLatestPokeModel():
return $default(_that.id,_that.pokeId,_that.fromUserId,_that.toUserId,_that.peerUserId,_that.direction,_that.status,_that.targetType,_that.targetId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  String? pokeId,  String? fromUserId,  String? toUserId,  String? peerUserId,  String? direction,  String? status,  String? targetType,  String? targetId)?  $default,) {final _that = this;
switch (_that) {
case _ChatLatestPokeModel() when $default != null:
return $default(_that.id,_that.pokeId,_that.fromUserId,_that.toUserId,_that.peerUserId,_that.direction,_that.status,_that.targetType,_that.targetId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChatLatestPokeModel implements ChatLatestPokeModel {
  const _ChatLatestPokeModel({this.id, this.pokeId, this.fromUserId, this.toUserId, this.peerUserId, this.direction, this.status, this.targetType, this.targetId});
  factory _ChatLatestPokeModel.fromJson(Map<String, dynamic> json) => _$ChatLatestPokeModelFromJson(json);

@override final  String? id;
@override final  String? pokeId;
@override final  String? fromUserId;
@override final  String? toUserId;
@override final  String? peerUserId;
@override final  String? direction;
@override final  String? status;
@override final  String? targetType;
@override final  String? targetId;

/// Create a copy of ChatLatestPokeModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatLatestPokeModelCopyWith<_ChatLatestPokeModel> get copyWith => __$ChatLatestPokeModelCopyWithImpl<_ChatLatestPokeModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChatLatestPokeModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatLatestPokeModel&&(identical(other.id, id) || other.id == id)&&(identical(other.pokeId, pokeId) || other.pokeId == pokeId)&&(identical(other.fromUserId, fromUserId) || other.fromUserId == fromUserId)&&(identical(other.toUserId, toUserId) || other.toUserId == toUserId)&&(identical(other.peerUserId, peerUserId) || other.peerUserId == peerUserId)&&(identical(other.direction, direction) || other.direction == direction)&&(identical(other.status, status) || other.status == status)&&(identical(other.targetType, targetType) || other.targetType == targetType)&&(identical(other.targetId, targetId) || other.targetId == targetId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,pokeId,fromUserId,toUserId,peerUserId,direction,status,targetType,targetId);

@override
String toString() {
  return 'ChatLatestPokeModel(id: $id, pokeId: $pokeId, fromUserId: $fromUserId, toUserId: $toUserId, peerUserId: $peerUserId, direction: $direction, status: $status, targetType: $targetType, targetId: $targetId)';
}


}

/// @nodoc
abstract mixin class _$ChatLatestPokeModelCopyWith<$Res> implements $ChatLatestPokeModelCopyWith<$Res> {
  factory _$ChatLatestPokeModelCopyWith(_ChatLatestPokeModel value, $Res Function(_ChatLatestPokeModel) _then) = __$ChatLatestPokeModelCopyWithImpl;
@override @useResult
$Res call({
 String? id, String? pokeId, String? fromUserId, String? toUserId, String? peerUserId, String? direction, String? status, String? targetType, String? targetId
});




}
/// @nodoc
class __$ChatLatestPokeModelCopyWithImpl<$Res>
    implements _$ChatLatestPokeModelCopyWith<$Res> {
  __$ChatLatestPokeModelCopyWithImpl(this._self, this._then);

  final _ChatLatestPokeModel _self;
  final $Res Function(_ChatLatestPokeModel) _then;

/// Create a copy of ChatLatestPokeModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? pokeId = freezed,Object? fromUserId = freezed,Object? toUserId = freezed,Object? peerUserId = freezed,Object? direction = freezed,Object? status = freezed,Object? targetType = freezed,Object? targetId = freezed,}) {
  return _then(_ChatLatestPokeModel(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,pokeId: freezed == pokeId ? _self.pokeId : pokeId // ignore: cast_nullable_to_non_nullable
as String?,fromUserId: freezed == fromUserId ? _self.fromUserId : fromUserId // ignore: cast_nullable_to_non_nullable
as String?,toUserId: freezed == toUserId ? _self.toUserId : toUserId // ignore: cast_nullable_to_non_nullable
as String?,peerUserId: freezed == peerUserId ? _self.peerUserId : peerUserId // ignore: cast_nullable_to_non_nullable
as String?,direction: freezed == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,targetType: freezed == targetType ? _self.targetType : targetType // ignore: cast_nullable_to_non_nullable
as String?,targetId: freezed == targetId ? _self.targetId : targetId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$ChatDirectChatMetaModel {

 String? get otherUserId; int get unreadCount;@JsonKey(fromJson: _dateTimeFromJsonNullable, toJson: _dateTimeToJsonNullable) DateTime? get lastMessageAt;
/// Create a copy of ChatDirectChatMetaModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatDirectChatMetaModelCopyWith<ChatDirectChatMetaModel> get copyWith => _$ChatDirectChatMetaModelCopyWithImpl<ChatDirectChatMetaModel>(this as ChatDirectChatMetaModel, _$identity);

  /// Serializes this ChatDirectChatMetaModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatDirectChatMetaModel&&(identical(other.otherUserId, otherUserId) || other.otherUserId == otherUserId)&&(identical(other.unreadCount, unreadCount) || other.unreadCount == unreadCount)&&(identical(other.lastMessageAt, lastMessageAt) || other.lastMessageAt == lastMessageAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,otherUserId,unreadCount,lastMessageAt);

@override
String toString() {
  return 'ChatDirectChatMetaModel(otherUserId: $otherUserId, unreadCount: $unreadCount, lastMessageAt: $lastMessageAt)';
}


}

/// @nodoc
abstract mixin class $ChatDirectChatMetaModelCopyWith<$Res>  {
  factory $ChatDirectChatMetaModelCopyWith(ChatDirectChatMetaModel value, $Res Function(ChatDirectChatMetaModel) _then) = _$ChatDirectChatMetaModelCopyWithImpl;
@useResult
$Res call({
 String? otherUserId, int unreadCount,@JsonKey(fromJson: _dateTimeFromJsonNullable, toJson: _dateTimeToJsonNullable) DateTime? lastMessageAt
});




}
/// @nodoc
class _$ChatDirectChatMetaModelCopyWithImpl<$Res>
    implements $ChatDirectChatMetaModelCopyWith<$Res> {
  _$ChatDirectChatMetaModelCopyWithImpl(this._self, this._then);

  final ChatDirectChatMetaModel _self;
  final $Res Function(ChatDirectChatMetaModel) _then;

/// Create a copy of ChatDirectChatMetaModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? otherUserId = freezed,Object? unreadCount = null,Object? lastMessageAt = freezed,}) {
  return _then(_self.copyWith(
otherUserId: freezed == otherUserId ? _self.otherUserId : otherUserId // ignore: cast_nullable_to_non_nullable
as String?,unreadCount: null == unreadCount ? _self.unreadCount : unreadCount // ignore: cast_nullable_to_non_nullable
as int,lastMessageAt: freezed == lastMessageAt ? _self.lastMessageAt : lastMessageAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [ChatDirectChatMetaModel].
extension ChatDirectChatMetaModelPatterns on ChatDirectChatMetaModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatDirectChatMetaModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatDirectChatMetaModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatDirectChatMetaModel value)  $default,){
final _that = this;
switch (_that) {
case _ChatDirectChatMetaModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatDirectChatMetaModel value)?  $default,){
final _that = this;
switch (_that) {
case _ChatDirectChatMetaModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? otherUserId,  int unreadCount, @JsonKey(fromJson: _dateTimeFromJsonNullable, toJson: _dateTimeToJsonNullable)  DateTime? lastMessageAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatDirectChatMetaModel() when $default != null:
return $default(_that.otherUserId,_that.unreadCount,_that.lastMessageAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? otherUserId,  int unreadCount, @JsonKey(fromJson: _dateTimeFromJsonNullable, toJson: _dateTimeToJsonNullable)  DateTime? lastMessageAt)  $default,) {final _that = this;
switch (_that) {
case _ChatDirectChatMetaModel():
return $default(_that.otherUserId,_that.unreadCount,_that.lastMessageAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? otherUserId,  int unreadCount, @JsonKey(fromJson: _dateTimeFromJsonNullable, toJson: _dateTimeToJsonNullable)  DateTime? lastMessageAt)?  $default,) {final _that = this;
switch (_that) {
case _ChatDirectChatMetaModel() when $default != null:
return $default(_that.otherUserId,_that.unreadCount,_that.lastMessageAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChatDirectChatMetaModel implements ChatDirectChatMetaModel {
  const _ChatDirectChatMetaModel({this.otherUserId, this.unreadCount = 0, @JsonKey(fromJson: _dateTimeFromJsonNullable, toJson: _dateTimeToJsonNullable) this.lastMessageAt});
  factory _ChatDirectChatMetaModel.fromJson(Map<String, dynamic> json) => _$ChatDirectChatMetaModelFromJson(json);

@override final  String? otherUserId;
@override@JsonKey() final  int unreadCount;
@override@JsonKey(fromJson: _dateTimeFromJsonNullable, toJson: _dateTimeToJsonNullable) final  DateTime? lastMessageAt;

/// Create a copy of ChatDirectChatMetaModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatDirectChatMetaModelCopyWith<_ChatDirectChatMetaModel> get copyWith => __$ChatDirectChatMetaModelCopyWithImpl<_ChatDirectChatMetaModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChatDirectChatMetaModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatDirectChatMetaModel&&(identical(other.otherUserId, otherUserId) || other.otherUserId == otherUserId)&&(identical(other.unreadCount, unreadCount) || other.unreadCount == unreadCount)&&(identical(other.lastMessageAt, lastMessageAt) || other.lastMessageAt == lastMessageAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,otherUserId,unreadCount,lastMessageAt);

@override
String toString() {
  return 'ChatDirectChatMetaModel(otherUserId: $otherUserId, unreadCount: $unreadCount, lastMessageAt: $lastMessageAt)';
}


}

/// @nodoc
abstract mixin class _$ChatDirectChatMetaModelCopyWith<$Res> implements $ChatDirectChatMetaModelCopyWith<$Res> {
  factory _$ChatDirectChatMetaModelCopyWith(_ChatDirectChatMetaModel value, $Res Function(_ChatDirectChatMetaModel) _then) = __$ChatDirectChatMetaModelCopyWithImpl;
@override @useResult
$Res call({
 String? otherUserId, int unreadCount,@JsonKey(fromJson: _dateTimeFromJsonNullable, toJson: _dateTimeToJsonNullable) DateTime? lastMessageAt
});




}
/// @nodoc
class __$ChatDirectChatMetaModelCopyWithImpl<$Res>
    implements _$ChatDirectChatMetaModelCopyWith<$Res> {
  __$ChatDirectChatMetaModelCopyWithImpl(this._self, this._then);

  final _ChatDirectChatMetaModel _self;
  final $Res Function(_ChatDirectChatMetaModel) _then;

/// Create a copy of ChatDirectChatMetaModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? otherUserId = freezed,Object? unreadCount = null,Object? lastMessageAt = freezed,}) {
  return _then(_ChatDirectChatMetaModel(
otherUserId: freezed == otherUserId ? _self.otherUserId : otherUserId // ignore: cast_nullable_to_non_nullable
as String?,unreadCount: null == unreadCount ? _self.unreadCount : unreadCount // ignore: cast_nullable_to_non_nullable
as int,lastMessageAt: freezed == lastMessageAt ? _self.lastMessageAt : lastMessageAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
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
mixin _$CallUserInfo {

 String get id; String get firstName; String? get lastName; List<String> get bestShorts;
/// Create a copy of CallUserInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CallUserInfoCopyWith<CallUserInfo> get copyWith => _$CallUserInfoCopyWithImpl<CallUserInfo>(this as CallUserInfo, _$identity);

  /// Serializes this CallUserInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CallUserInfo&&(identical(other.id, id) || other.id == id)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&const DeepCollectionEquality().equals(other.bestShorts, bestShorts));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,firstName,lastName,const DeepCollectionEquality().hash(bestShorts));

@override
String toString() {
  return 'CallUserInfo(id: $id, firstName: $firstName, lastName: $lastName, bestShorts: $bestShorts)';
}


}

/// @nodoc
abstract mixin class $CallUserInfoCopyWith<$Res>  {
  factory $CallUserInfoCopyWith(CallUserInfo value, $Res Function(CallUserInfo) _then) = _$CallUserInfoCopyWithImpl;
@useResult
$Res call({
 String id, String firstName, String? lastName, List<String> bestShorts
});




}
/// @nodoc
class _$CallUserInfoCopyWithImpl<$Res>
    implements $CallUserInfoCopyWith<$Res> {
  _$CallUserInfoCopyWithImpl(this._self, this._then);

  final CallUserInfo _self;
  final $Res Function(CallUserInfo) _then;

/// Create a copy of CallUserInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? firstName = null,Object? lastName = freezed,Object? bestShorts = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: freezed == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String?,bestShorts: null == bestShorts ? _self.bestShorts : bestShorts // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [CallUserInfo].
extension CallUserInfoPatterns on CallUserInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CallUserInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CallUserInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CallUserInfo value)  $default,){
final _that = this;
switch (_that) {
case _CallUserInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CallUserInfo value)?  $default,){
final _that = this;
switch (_that) {
case _CallUserInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String firstName,  String? lastName,  List<String> bestShorts)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CallUserInfo() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String firstName,  String? lastName,  List<String> bestShorts)  $default,) {final _that = this;
switch (_that) {
case _CallUserInfo():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String firstName,  String? lastName,  List<String> bestShorts)?  $default,) {final _that = this;
switch (_that) {
case _CallUserInfo() when $default != null:
return $default(_that.id,_that.firstName,_that.lastName,_that.bestShorts);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CallUserInfo implements CallUserInfo {
  const _CallUserInfo({required this.id, required this.firstName, this.lastName, final  List<String> bestShorts = const []}): _bestShorts = bestShorts;
  factory _CallUserInfo.fromJson(Map<String, dynamic> json) => _$CallUserInfoFromJson(json);

@override final  String id;
@override final  String firstName;
@override final  String? lastName;
 final  List<String> _bestShorts;
@override@JsonKey() List<String> get bestShorts {
  if (_bestShorts is EqualUnmodifiableListView) return _bestShorts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_bestShorts);
}


/// Create a copy of CallUserInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CallUserInfoCopyWith<_CallUserInfo> get copyWith => __$CallUserInfoCopyWithImpl<_CallUserInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CallUserInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CallUserInfo&&(identical(other.id, id) || other.id == id)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&const DeepCollectionEquality().equals(other._bestShorts, _bestShorts));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,firstName,lastName,const DeepCollectionEquality().hash(_bestShorts));

@override
String toString() {
  return 'CallUserInfo(id: $id, firstName: $firstName, lastName: $lastName, bestShorts: $bestShorts)';
}


}

/// @nodoc
abstract mixin class _$CallUserInfoCopyWith<$Res> implements $CallUserInfoCopyWith<$Res> {
  factory _$CallUserInfoCopyWith(_CallUserInfo value, $Res Function(_CallUserInfo) _then) = __$CallUserInfoCopyWithImpl;
@override @useResult
$Res call({
 String id, String firstName, String? lastName, List<String> bestShorts
});




}
/// @nodoc
class __$CallUserInfoCopyWithImpl<$Res>
    implements _$CallUserInfoCopyWith<$Res> {
  __$CallUserInfoCopyWithImpl(this._self, this._then);

  final _CallUserInfo _self;
  final $Res Function(_CallUserInfo) _then;

/// Create a copy of CallUserInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? firstName = null,Object? lastName = freezed,Object? bestShorts = null,}) {
  return _then(_CallUserInfo(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: freezed == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String?,bestShorts: null == bestShorts ? _self._bestShorts : bestShorts // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}


/// @nodoc
mixin _$CallModel {

 String get id; String? get name; String? get image; List<MemberModel>? get members; String? get callTypeLabel; String? get duration; String? get timeAgo; String? get status; String? get channelName;// added
 String? get mediaType;// added
 String? get callType;// added
@JsonKey(fromJson: _dateTimeFromJsonNullable, toJson: _dateTimeToJsonNullable) DateTime? get startedAt;// added
 CallUserInfo? get callerId;// added
 List<CallUserInfo>? get participantIds;
/// Create a copy of CallModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CallModelCopyWith<CallModel> get copyWith => _$CallModelCopyWithImpl<CallModel>(this as CallModel, _$identity);

  /// Serializes this CallModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CallModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.image, image) || other.image == image)&&const DeepCollectionEquality().equals(other.members, members)&&(identical(other.callTypeLabel, callTypeLabel) || other.callTypeLabel == callTypeLabel)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.timeAgo, timeAgo) || other.timeAgo == timeAgo)&&(identical(other.status, status) || other.status == status)&&(identical(other.channelName, channelName) || other.channelName == channelName)&&(identical(other.mediaType, mediaType) || other.mediaType == mediaType)&&(identical(other.callType, callType) || other.callType == callType)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.callerId, callerId) || other.callerId == callerId)&&const DeepCollectionEquality().equals(other.participantIds, participantIds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,image,const DeepCollectionEquality().hash(members),callTypeLabel,duration,timeAgo,status,channelName,mediaType,callType,startedAt,callerId,const DeepCollectionEquality().hash(participantIds));

@override
String toString() {
  return 'CallModel(id: $id, name: $name, image: $image, members: $members, callTypeLabel: $callTypeLabel, duration: $duration, timeAgo: $timeAgo, status: $status, channelName: $channelName, mediaType: $mediaType, callType: $callType, startedAt: $startedAt, callerId: $callerId, participantIds: $participantIds)';
}


}

/// @nodoc
abstract mixin class $CallModelCopyWith<$Res>  {
  factory $CallModelCopyWith(CallModel value, $Res Function(CallModel) _then) = _$CallModelCopyWithImpl;
@useResult
$Res call({
 String id, String? name, String? image, List<MemberModel>? members, String? callTypeLabel, String? duration, String? timeAgo, String? status, String? channelName, String? mediaType, String? callType,@JsonKey(fromJson: _dateTimeFromJsonNullable, toJson: _dateTimeToJsonNullable) DateTime? startedAt, CallUserInfo? callerId, List<CallUserInfo>? participantIds
});


$CallUserInfoCopyWith<$Res>? get callerId;

}
/// @nodoc
class _$CallModelCopyWithImpl<$Res>
    implements $CallModelCopyWith<$Res> {
  _$CallModelCopyWithImpl(this._self, this._then);

  final CallModel _self;
  final $Res Function(CallModel) _then;

/// Create a copy of CallModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = freezed,Object? image = freezed,Object? members = freezed,Object? callTypeLabel = freezed,Object? duration = freezed,Object? timeAgo = freezed,Object? status = freezed,Object? channelName = freezed,Object? mediaType = freezed,Object? callType = freezed,Object? startedAt = freezed,Object? callerId = freezed,Object? participantIds = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String?,members: freezed == members ? _self.members : members // ignore: cast_nullable_to_non_nullable
as List<MemberModel>?,callTypeLabel: freezed == callTypeLabel ? _self.callTypeLabel : callTypeLabel // ignore: cast_nullable_to_non_nullable
as String?,duration: freezed == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as String?,timeAgo: freezed == timeAgo ? _self.timeAgo : timeAgo // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,channelName: freezed == channelName ? _self.channelName : channelName // ignore: cast_nullable_to_non_nullable
as String?,mediaType: freezed == mediaType ? _self.mediaType : mediaType // ignore: cast_nullable_to_non_nullable
as String?,callType: freezed == callType ? _self.callType : callType // ignore: cast_nullable_to_non_nullable
as String?,startedAt: freezed == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,callerId: freezed == callerId ? _self.callerId : callerId // ignore: cast_nullable_to_non_nullable
as CallUserInfo?,participantIds: freezed == participantIds ? _self.participantIds : participantIds // ignore: cast_nullable_to_non_nullable
as List<CallUserInfo>?,
  ));
}
/// Create a copy of CallModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CallUserInfoCopyWith<$Res>? get callerId {
    if (_self.callerId == null) {
    return null;
  }

  return $CallUserInfoCopyWith<$Res>(_self.callerId!, (value) {
    return _then(_self.copyWith(callerId: value));
  });
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String? name,  String? image,  List<MemberModel>? members,  String? callTypeLabel,  String? duration,  String? timeAgo,  String? status,  String? channelName,  String? mediaType,  String? callType, @JsonKey(fromJson: _dateTimeFromJsonNullable, toJson: _dateTimeToJsonNullable)  DateTime? startedAt,  CallUserInfo? callerId,  List<CallUserInfo>? participantIds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CallModel() when $default != null:
return $default(_that.id,_that.name,_that.image,_that.members,_that.callTypeLabel,_that.duration,_that.timeAgo,_that.status,_that.channelName,_that.mediaType,_that.callType,_that.startedAt,_that.callerId,_that.participantIds);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String? name,  String? image,  List<MemberModel>? members,  String? callTypeLabel,  String? duration,  String? timeAgo,  String? status,  String? channelName,  String? mediaType,  String? callType, @JsonKey(fromJson: _dateTimeFromJsonNullable, toJson: _dateTimeToJsonNullable)  DateTime? startedAt,  CallUserInfo? callerId,  List<CallUserInfo>? participantIds)  $default,) {final _that = this;
switch (_that) {
case _CallModel():
return $default(_that.id,_that.name,_that.image,_that.members,_that.callTypeLabel,_that.duration,_that.timeAgo,_that.status,_that.channelName,_that.mediaType,_that.callType,_that.startedAt,_that.callerId,_that.participantIds);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String? name,  String? image,  List<MemberModel>? members,  String? callTypeLabel,  String? duration,  String? timeAgo,  String? status,  String? channelName,  String? mediaType,  String? callType, @JsonKey(fromJson: _dateTimeFromJsonNullable, toJson: _dateTimeToJsonNullable)  DateTime? startedAt,  CallUserInfo? callerId,  List<CallUserInfo>? participantIds)?  $default,) {final _that = this;
switch (_that) {
case _CallModel() when $default != null:
return $default(_that.id,_that.name,_that.image,_that.members,_that.callTypeLabel,_that.duration,_that.timeAgo,_that.status,_that.channelName,_that.mediaType,_that.callType,_that.startedAt,_that.callerId,_that.participantIds);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CallModel implements CallModel {
  const _CallModel({required this.id, this.name, this.image, final  List<MemberModel>? members, this.callTypeLabel, this.duration, this.timeAgo, this.status, this.channelName, this.mediaType, this.callType, @JsonKey(fromJson: _dateTimeFromJsonNullable, toJson: _dateTimeToJsonNullable) this.startedAt, this.callerId, final  List<CallUserInfo>? participantIds}): _members = members,_participantIds = participantIds;
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
@override final  String? channelName;
// added
@override final  String? mediaType;
// added
@override final  String? callType;
// added
@override@JsonKey(fromJson: _dateTimeFromJsonNullable, toJson: _dateTimeToJsonNullable) final  DateTime? startedAt;
// added
@override final  CallUserInfo? callerId;
// added
 final  List<CallUserInfo>? _participantIds;
// added
@override List<CallUserInfo>? get participantIds {
  final value = _participantIds;
  if (value == null) return null;
  if (_participantIds is EqualUnmodifiableListView) return _participantIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CallModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.image, image) || other.image == image)&&const DeepCollectionEquality().equals(other._members, _members)&&(identical(other.callTypeLabel, callTypeLabel) || other.callTypeLabel == callTypeLabel)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.timeAgo, timeAgo) || other.timeAgo == timeAgo)&&(identical(other.status, status) || other.status == status)&&(identical(other.channelName, channelName) || other.channelName == channelName)&&(identical(other.mediaType, mediaType) || other.mediaType == mediaType)&&(identical(other.callType, callType) || other.callType == callType)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.callerId, callerId) || other.callerId == callerId)&&const DeepCollectionEquality().equals(other._participantIds, _participantIds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,image,const DeepCollectionEquality().hash(_members),callTypeLabel,duration,timeAgo,status,channelName,mediaType,callType,startedAt,callerId,const DeepCollectionEquality().hash(_participantIds));

@override
String toString() {
  return 'CallModel(id: $id, name: $name, image: $image, members: $members, callTypeLabel: $callTypeLabel, duration: $duration, timeAgo: $timeAgo, status: $status, channelName: $channelName, mediaType: $mediaType, callType: $callType, startedAt: $startedAt, callerId: $callerId, participantIds: $participantIds)';
}


}

/// @nodoc
abstract mixin class _$CallModelCopyWith<$Res> implements $CallModelCopyWith<$Res> {
  factory _$CallModelCopyWith(_CallModel value, $Res Function(_CallModel) _then) = __$CallModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String? name, String? image, List<MemberModel>? members, String? callTypeLabel, String? duration, String? timeAgo, String? status, String? channelName, String? mediaType, String? callType,@JsonKey(fromJson: _dateTimeFromJsonNullable, toJson: _dateTimeToJsonNullable) DateTime? startedAt, CallUserInfo? callerId, List<CallUserInfo>? participantIds
});


@override $CallUserInfoCopyWith<$Res>? get callerId;

}
/// @nodoc
class __$CallModelCopyWithImpl<$Res>
    implements _$CallModelCopyWith<$Res> {
  __$CallModelCopyWithImpl(this._self, this._then);

  final _CallModel _self;
  final $Res Function(_CallModel) _then;

/// Create a copy of CallModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = freezed,Object? image = freezed,Object? members = freezed,Object? callTypeLabel = freezed,Object? duration = freezed,Object? timeAgo = freezed,Object? status = freezed,Object? channelName = freezed,Object? mediaType = freezed,Object? callType = freezed,Object? startedAt = freezed,Object? callerId = freezed,Object? participantIds = freezed,}) {
  return _then(_CallModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String?,members: freezed == members ? _self._members : members // ignore: cast_nullable_to_non_nullable
as List<MemberModel>?,callTypeLabel: freezed == callTypeLabel ? _self.callTypeLabel : callTypeLabel // ignore: cast_nullable_to_non_nullable
as String?,duration: freezed == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as String?,timeAgo: freezed == timeAgo ? _self.timeAgo : timeAgo // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,channelName: freezed == channelName ? _self.channelName : channelName // ignore: cast_nullable_to_non_nullable
as String?,mediaType: freezed == mediaType ? _self.mediaType : mediaType // ignore: cast_nullable_to_non_nullable
as String?,callType: freezed == callType ? _self.callType : callType // ignore: cast_nullable_to_non_nullable
as String?,startedAt: freezed == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,callerId: freezed == callerId ? _self.callerId : callerId // ignore: cast_nullable_to_non_nullable
as CallUserInfo?,participantIds: freezed == participantIds ? _self._participantIds : participantIds // ignore: cast_nullable_to_non_nullable
as List<CallUserInfo>?,
  ));
}

/// Create a copy of CallModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CallUserInfoCopyWith<$Res>? get callerId {
    if (_self.callerId == null) {
    return null;
  }

  return $CallUserInfoCopyWith<$Res>(_self.callerId!, (value) {
    return _then(_self.copyWith(callerId: value));
  });
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

 String get id; String get fromUserId; String get toUserId; String get targetType; String? get targetId; String get message; String get status;@JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson) DateTime get createdAt;@JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson) DateTime get updatedAt;
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
 String id, String fromUserId, String toUserId, String targetType, String? targetId, String message, String status,@JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson) DateTime createdAt,@JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson) DateTime updatedAt
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
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? fromUserId = null,Object? toUserId = null,Object? targetType = null,Object? targetId = freezed,Object? message = null,Object? status = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,fromUserId: null == fromUserId ? _self.fromUserId : fromUserId // ignore: cast_nullable_to_non_nullable
as String,toUserId: null == toUserId ? _self.toUserId : toUserId // ignore: cast_nullable_to_non_nullable
as String,targetType: null == targetType ? _self.targetType : targetType // ignore: cast_nullable_to_non_nullable
as String,targetId: freezed == targetId ? _self.targetId : targetId // ignore: cast_nullable_to_non_nullable
as String?,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String fromUserId,  String toUserId,  String targetType,  String? targetId,  String message,  String status, @JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)  DateTime createdAt, @JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String fromUserId,  String toUserId,  String targetType,  String? targetId,  String message,  String status, @JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)  DateTime createdAt, @JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)  DateTime updatedAt)  $default,) {final _that = this;
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String fromUserId,  String toUserId,  String targetType,  String? targetId,  String message,  String status, @JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)  DateTime createdAt, @JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)  DateTime updatedAt)?  $default,) {final _that = this;
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
  const _PokeModel({required this.id, required this.fromUserId, required this.toUserId, required this.targetType, this.targetId, required this.message, required this.status, @JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson) required this.createdAt, @JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson) required this.updatedAt});
  factory _PokeModel.fromJson(Map<String, dynamic> json) => _$PokeModelFromJson(json);

@override final  String id;
@override final  String fromUserId;
@override final  String toUserId;
@override final  String targetType;
@override final  String? targetId;
@override final  String message;
@override final  String status;
@override@JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson) final  DateTime createdAt;
@override@JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson) final  DateTime updatedAt;

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
 String id, String fromUserId, String toUserId, String targetType, String? targetId, String message, String status,@JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson) DateTime createdAt,@JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson) DateTime updatedAt
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
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? fromUserId = null,Object? toUserId = null,Object? targetType = null,Object? targetId = freezed,Object? message = null,Object? status = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_PokeModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,fromUserId: null == fromUserId ? _self.fromUserId : fromUserId // ignore: cast_nullable_to_non_nullable
as String,toUserId: null == toUserId ? _self.toUserId : toUserId // ignore: cast_nullable_to_non_nullable
as String,targetType: null == targetType ? _self.targetType : targetType // ignore: cast_nullable_to_non_nullable
as String,targetId: freezed == targetId ? _self.targetId : targetId // ignore: cast_nullable_to_non_nullable
as String?,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$PokerFromUser {

 String get id; String get firstName; String? get lastName; List<String> get bestShorts;
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
 String id, String firstName, String? lastName, List<String> bestShorts
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
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? firstName = null,Object? lastName = freezed,Object? bestShorts = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: freezed == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String?,bestShorts: null == bestShorts ? _self.bestShorts : bestShorts // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String firstName,  String? lastName,  List<String> bestShorts)?  $default,{required TResult orElse(),}) {final _that = this;
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String firstName,  String? lastName,  List<String> bestShorts)  $default,) {final _that = this;
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String firstName,  String? lastName,  List<String> bestShorts)?  $default,) {final _that = this;
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
  const _PokerFromUser({required this.id, required this.firstName, this.lastName, required final  List<String> bestShorts}): _bestShorts = bestShorts;
  factory _PokerFromUser.fromJson(Map<String, dynamic> json) => _$PokerFromUserFromJson(json);

@override final  String id;
@override final  String firstName;
@override final  String? lastName;
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
 String id, String firstName, String? lastName, List<String> bestShorts
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
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? firstName = null,Object? lastName = freezed,Object? bestShorts = null,}) {
  return _then(_PokerFromUser(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: freezed == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String?,bestShorts: null == bestShorts ? _self._bestShorts : bestShorts // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}


/// @nodoc
mixin _$PokedTargetDetail {

 String get type; PokePhotoDetail? get photo; PokeAudioDetail? get audio; PokedProfileDetail? get profile; String? get text;
/// Create a copy of PokedTargetDetail
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PokedTargetDetailCopyWith<PokedTargetDetail> get copyWith => _$PokedTargetDetailCopyWithImpl<PokedTargetDetail>(this as PokedTargetDetail, _$identity);

  /// Serializes this PokedTargetDetail to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PokedTargetDetail&&(identical(other.type, type) || other.type == type)&&(identical(other.photo, photo) || other.photo == photo)&&(identical(other.audio, audio) || other.audio == audio)&&(identical(other.profile, profile) || other.profile == profile)&&(identical(other.text, text) || other.text == text));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,photo,audio,profile,text);

@override
String toString() {
  return 'PokedTargetDetail(type: $type, photo: $photo, audio: $audio, profile: $profile, text: $text)';
}


}

/// @nodoc
abstract mixin class $PokedTargetDetailCopyWith<$Res>  {
  factory $PokedTargetDetailCopyWith(PokedTargetDetail value, $Res Function(PokedTargetDetail) _then) = _$PokedTargetDetailCopyWithImpl;
@useResult
$Res call({
 String type, PokePhotoDetail? photo, PokeAudioDetail? audio, PokedProfileDetail? profile, String? text
});


$PokePhotoDetailCopyWith<$Res>? get photo;$PokeAudioDetailCopyWith<$Res>? get audio;$PokedProfileDetailCopyWith<$Res>? get profile;

}
/// @nodoc
class _$PokedTargetDetailCopyWithImpl<$Res>
    implements $PokedTargetDetailCopyWith<$Res> {
  _$PokedTargetDetailCopyWithImpl(this._self, this._then);

  final PokedTargetDetail _self;
  final $Res Function(PokedTargetDetail) _then;

/// Create a copy of PokedTargetDetail
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? photo = freezed,Object? audio = freezed,Object? profile = freezed,Object? text = freezed,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,photo: freezed == photo ? _self.photo : photo // ignore: cast_nullable_to_non_nullable
as PokePhotoDetail?,audio: freezed == audio ? _self.audio : audio // ignore: cast_nullable_to_non_nullable
as PokeAudioDetail?,profile: freezed == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as PokedProfileDetail?,text: freezed == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
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
}/// Create a copy of PokedTargetDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PokedProfileDetailCopyWith<$Res>? get profile {
    if (_self.profile == null) {
    return null;
  }

  return $PokedProfileDetailCopyWith<$Res>(_self.profile!, (value) {
    return _then(_self.copyWith(profile: value));
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String type,  PokePhotoDetail? photo,  PokeAudioDetail? audio,  PokedProfileDetail? profile,  String? text)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PokedTargetDetail() when $default != null:
return $default(_that.type,_that.photo,_that.audio,_that.profile,_that.text);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String type,  PokePhotoDetail? photo,  PokeAudioDetail? audio,  PokedProfileDetail? profile,  String? text)  $default,) {final _that = this;
switch (_that) {
case _PokedTargetDetail():
return $default(_that.type,_that.photo,_that.audio,_that.profile,_that.text);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String type,  PokePhotoDetail? photo,  PokeAudioDetail? audio,  PokedProfileDetail? profile,  String? text)?  $default,) {final _that = this;
switch (_that) {
case _PokedTargetDetail() when $default != null:
return $default(_that.type,_that.photo,_that.audio,_that.profile,_that.text);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PokedTargetDetail implements PokedTargetDetail {
  const _PokedTargetDetail({required this.type, this.photo, this.audio, this.profile, this.text});
  factory _PokedTargetDetail.fromJson(Map<String, dynamic> json) => _$PokedTargetDetailFromJson(json);

@override final  String type;
@override final  PokePhotoDetail? photo;
@override final  PokeAudioDetail? audio;
@override final  PokedProfileDetail? profile;
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PokedTargetDetail&&(identical(other.type, type) || other.type == type)&&(identical(other.photo, photo) || other.photo == photo)&&(identical(other.audio, audio) || other.audio == audio)&&(identical(other.profile, profile) || other.profile == profile)&&(identical(other.text, text) || other.text == text));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,photo,audio,profile,text);

@override
String toString() {
  return 'PokedTargetDetail(type: $type, photo: $photo, audio: $audio, profile: $profile, text: $text)';
}


}

/// @nodoc
abstract mixin class _$PokedTargetDetailCopyWith<$Res> implements $PokedTargetDetailCopyWith<$Res> {
  factory _$PokedTargetDetailCopyWith(_PokedTargetDetail value, $Res Function(_PokedTargetDetail) _then) = __$PokedTargetDetailCopyWithImpl;
@override @useResult
$Res call({
 String type, PokePhotoDetail? photo, PokeAudioDetail? audio, PokedProfileDetail? profile, String? text
});


@override $PokePhotoDetailCopyWith<$Res>? get photo;@override $PokeAudioDetailCopyWith<$Res>? get audio;@override $PokedProfileDetailCopyWith<$Res>? get profile;

}
/// @nodoc
class __$PokedTargetDetailCopyWithImpl<$Res>
    implements _$PokedTargetDetailCopyWith<$Res> {
  __$PokedTargetDetailCopyWithImpl(this._self, this._then);

  final _PokedTargetDetail _self;
  final $Res Function(_PokedTargetDetail) _then;

/// Create a copy of PokedTargetDetail
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? photo = freezed,Object? audio = freezed,Object? profile = freezed,Object? text = freezed,}) {
  return _then(_PokedTargetDetail(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,photo: freezed == photo ? _self.photo : photo // ignore: cast_nullable_to_non_nullable
as PokePhotoDetail?,audio: freezed == audio ? _self.audio : audio // ignore: cast_nullable_to_non_nullable
as PokeAudioDetail?,profile: freezed == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as PokedProfileDetail?,text: freezed == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
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
}/// Create a copy of PokedTargetDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PokedProfileDetailCopyWith<$Res>? get profile {
    if (_self.profile == null) {
    return null;
  }

  return $PokedProfileDetailCopyWith<$Res>(_self.profile!, (value) {
    return _then(_self.copyWith(profile: value));
  });
}
}


/// @nodoc
mixin _$PokedProfileDetail {

 String get id; String get firstName; String? get lastName; List<String> get bestShorts; String? get shortBio; List<String>? get lifestyleLikes;
/// Create a copy of PokedProfileDetail
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PokedProfileDetailCopyWith<PokedProfileDetail> get copyWith => _$PokedProfileDetailCopyWithImpl<PokedProfileDetail>(this as PokedProfileDetail, _$identity);

  /// Serializes this PokedProfileDetail to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PokedProfileDetail&&(identical(other.id, id) || other.id == id)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&const DeepCollectionEquality().equals(other.bestShorts, bestShorts)&&(identical(other.shortBio, shortBio) || other.shortBio == shortBio)&&const DeepCollectionEquality().equals(other.lifestyleLikes, lifestyleLikes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,firstName,lastName,const DeepCollectionEquality().hash(bestShorts),shortBio,const DeepCollectionEquality().hash(lifestyleLikes));

@override
String toString() {
  return 'PokedProfileDetail(id: $id, firstName: $firstName, lastName: $lastName, bestShorts: $bestShorts, shortBio: $shortBio, lifestyleLikes: $lifestyleLikes)';
}


}

/// @nodoc
abstract mixin class $PokedProfileDetailCopyWith<$Res>  {
  factory $PokedProfileDetailCopyWith(PokedProfileDetail value, $Res Function(PokedProfileDetail) _then) = _$PokedProfileDetailCopyWithImpl;
@useResult
$Res call({
 String id, String firstName, String? lastName, List<String> bestShorts, String? shortBio, List<String>? lifestyleLikes
});




}
/// @nodoc
class _$PokedProfileDetailCopyWithImpl<$Res>
    implements $PokedProfileDetailCopyWith<$Res> {
  _$PokedProfileDetailCopyWithImpl(this._self, this._then);

  final PokedProfileDetail _self;
  final $Res Function(PokedProfileDetail) _then;

/// Create a copy of PokedProfileDetail
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? firstName = null,Object? lastName = freezed,Object? bestShorts = null,Object? shortBio = freezed,Object? lifestyleLikes = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: freezed == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String?,bestShorts: null == bestShorts ? _self.bestShorts : bestShorts // ignore: cast_nullable_to_non_nullable
as List<String>,shortBio: freezed == shortBio ? _self.shortBio : shortBio // ignore: cast_nullable_to_non_nullable
as String?,lifestyleLikes: freezed == lifestyleLikes ? _self.lifestyleLikes : lifestyleLikes // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}

}


/// Adds pattern-matching-related methods to [PokedProfileDetail].
extension PokedProfileDetailPatterns on PokedProfileDetail {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PokedProfileDetail value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PokedProfileDetail() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PokedProfileDetail value)  $default,){
final _that = this;
switch (_that) {
case _PokedProfileDetail():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PokedProfileDetail value)?  $default,){
final _that = this;
switch (_that) {
case _PokedProfileDetail() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String firstName,  String? lastName,  List<String> bestShorts,  String? shortBio,  List<String>? lifestyleLikes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PokedProfileDetail() when $default != null:
return $default(_that.id,_that.firstName,_that.lastName,_that.bestShorts,_that.shortBio,_that.lifestyleLikes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String firstName,  String? lastName,  List<String> bestShorts,  String? shortBio,  List<String>? lifestyleLikes)  $default,) {final _that = this;
switch (_that) {
case _PokedProfileDetail():
return $default(_that.id,_that.firstName,_that.lastName,_that.bestShorts,_that.shortBio,_that.lifestyleLikes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String firstName,  String? lastName,  List<String> bestShorts,  String? shortBio,  List<String>? lifestyleLikes)?  $default,) {final _that = this;
switch (_that) {
case _PokedProfileDetail() when $default != null:
return $default(_that.id,_that.firstName,_that.lastName,_that.bestShorts,_that.shortBio,_that.lifestyleLikes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PokedProfileDetail implements PokedProfileDetail {
  const _PokedProfileDetail({required this.id, required this.firstName, this.lastName, required final  List<String> bestShorts, this.shortBio, final  List<String>? lifestyleLikes}): _bestShorts = bestShorts,_lifestyleLikes = lifestyleLikes;
  factory _PokedProfileDetail.fromJson(Map<String, dynamic> json) => _$PokedProfileDetailFromJson(json);

@override final  String id;
@override final  String firstName;
@override final  String? lastName;
 final  List<String> _bestShorts;
@override List<String> get bestShorts {
  if (_bestShorts is EqualUnmodifiableListView) return _bestShorts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_bestShorts);
}

@override final  String? shortBio;
 final  List<String>? _lifestyleLikes;
@override List<String>? get lifestyleLikes {
  final value = _lifestyleLikes;
  if (value == null) return null;
  if (_lifestyleLikes is EqualUnmodifiableListView) return _lifestyleLikes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of PokedProfileDetail
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PokedProfileDetailCopyWith<_PokedProfileDetail> get copyWith => __$PokedProfileDetailCopyWithImpl<_PokedProfileDetail>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PokedProfileDetailToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PokedProfileDetail&&(identical(other.id, id) || other.id == id)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&const DeepCollectionEquality().equals(other._bestShorts, _bestShorts)&&(identical(other.shortBio, shortBio) || other.shortBio == shortBio)&&const DeepCollectionEquality().equals(other._lifestyleLikes, _lifestyleLikes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,firstName,lastName,const DeepCollectionEquality().hash(_bestShorts),shortBio,const DeepCollectionEquality().hash(_lifestyleLikes));

@override
String toString() {
  return 'PokedProfileDetail(id: $id, firstName: $firstName, lastName: $lastName, bestShorts: $bestShorts, shortBio: $shortBio, lifestyleLikes: $lifestyleLikes)';
}


}

/// @nodoc
abstract mixin class _$PokedProfileDetailCopyWith<$Res> implements $PokedProfileDetailCopyWith<$Res> {
  factory _$PokedProfileDetailCopyWith(_PokedProfileDetail value, $Res Function(_PokedProfileDetail) _then) = __$PokedProfileDetailCopyWithImpl;
@override @useResult
$Res call({
 String id, String firstName, String? lastName, List<String> bestShorts, String? shortBio, List<String>? lifestyleLikes
});




}
/// @nodoc
class __$PokedProfileDetailCopyWithImpl<$Res>
    implements _$PokedProfileDetailCopyWith<$Res> {
  __$PokedProfileDetailCopyWithImpl(this._self, this._then);

  final _PokedProfileDetail _self;
  final $Res Function(_PokedProfileDetail) _then;

/// Create a copy of PokedProfileDetail
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? firstName = null,Object? lastName = freezed,Object? bestShorts = null,Object? shortBio = freezed,Object? lifestyleLikes = freezed,}) {
  return _then(_PokedProfileDetail(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: freezed == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String?,bestShorts: null == bestShorts ? _self._bestShorts : bestShorts // ignore: cast_nullable_to_non_nullable
as List<String>,shortBio: freezed == shortBio ? _self.shortBio : shortBio // ignore: cast_nullable_to_non_nullable
as String?,lifestyleLikes: freezed == lifestyleLikes ? _self._lifestyleLikes : lifestyleLikes // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
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
