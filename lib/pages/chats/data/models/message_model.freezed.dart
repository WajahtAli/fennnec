// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MessageModel {

 String get id; String get senderId; String get senderName; String? get senderAvatar; String get content; MessageType get type; String? get mediaUrl; List<String> get imageUrls; List<double> get waveformData; String? get mediaDuration; String? get mentionedUserId; String? get mentionedUserName; DateTime get sentAt; bool get isMe; bool get isGroup; List<ReactionModel> get reactions; bool get isRead; DateTime? get readAt; bool get isSending; bool get hasFailed;
/// Create a copy of MessageModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MessageModelCopyWith<MessageModel> get copyWith => _$MessageModelCopyWithImpl<MessageModel>(this as MessageModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MessageModel&&(identical(other.id, id) || other.id == id)&&(identical(other.senderId, senderId) || other.senderId == senderId)&&(identical(other.senderName, senderName) || other.senderName == senderName)&&(identical(other.senderAvatar, senderAvatar) || other.senderAvatar == senderAvatar)&&(identical(other.content, content) || other.content == content)&&(identical(other.type, type) || other.type == type)&&(identical(other.mediaUrl, mediaUrl) || other.mediaUrl == mediaUrl)&&const DeepCollectionEquality().equals(other.imageUrls, imageUrls)&&const DeepCollectionEquality().equals(other.waveformData, waveformData)&&(identical(other.mediaDuration, mediaDuration) || other.mediaDuration == mediaDuration)&&(identical(other.mentionedUserId, mentionedUserId) || other.mentionedUserId == mentionedUserId)&&(identical(other.mentionedUserName, mentionedUserName) || other.mentionedUserName == mentionedUserName)&&(identical(other.sentAt, sentAt) || other.sentAt == sentAt)&&(identical(other.isMe, isMe) || other.isMe == isMe)&&(identical(other.isGroup, isGroup) || other.isGroup == isGroup)&&const DeepCollectionEquality().equals(other.reactions, reactions)&&(identical(other.isRead, isRead) || other.isRead == isRead)&&(identical(other.readAt, readAt) || other.readAt == readAt)&&(identical(other.isSending, isSending) || other.isSending == isSending)&&(identical(other.hasFailed, hasFailed) || other.hasFailed == hasFailed));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,senderId,senderName,senderAvatar,content,type,mediaUrl,const DeepCollectionEquality().hash(imageUrls),const DeepCollectionEquality().hash(waveformData),mediaDuration,mentionedUserId,mentionedUserName,sentAt,isMe,isGroup,const DeepCollectionEquality().hash(reactions),isRead,readAt,isSending,hasFailed]);

@override
String toString() {
  return 'MessageModel(id: $id, senderId: $senderId, senderName: $senderName, senderAvatar: $senderAvatar, content: $content, type: $type, mediaUrl: $mediaUrl, imageUrls: $imageUrls, waveformData: $waveformData, mediaDuration: $mediaDuration, mentionedUserId: $mentionedUserId, mentionedUserName: $mentionedUserName, sentAt: $sentAt, isMe: $isMe, isGroup: $isGroup, reactions: $reactions, isRead: $isRead, readAt: $readAt, isSending: $isSending, hasFailed: $hasFailed)';
}


}

/// @nodoc
abstract mixin class $MessageModelCopyWith<$Res>  {
  factory $MessageModelCopyWith(MessageModel value, $Res Function(MessageModel) _then) = _$MessageModelCopyWithImpl;
@useResult
$Res call({
 String id, String senderId, String senderName, String? senderAvatar, String content, MessageType type, String? mediaUrl, List<String> imageUrls, List<double> waveformData, String? mediaDuration, String? mentionedUserId, String? mentionedUserName, DateTime sentAt, bool isMe, bool isGroup, List<ReactionModel> reactions, bool isRead, DateTime? readAt, bool isSending, bool hasFailed
});




}
/// @nodoc
class _$MessageModelCopyWithImpl<$Res>
    implements $MessageModelCopyWith<$Res> {
  _$MessageModelCopyWithImpl(this._self, this._then);

  final MessageModel _self;
  final $Res Function(MessageModel) _then;

/// Create a copy of MessageModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? senderId = null,Object? senderName = null,Object? senderAvatar = freezed,Object? content = null,Object? type = null,Object? mediaUrl = freezed,Object? imageUrls = null,Object? waveformData = null,Object? mediaDuration = freezed,Object? mentionedUserId = freezed,Object? mentionedUserName = freezed,Object? sentAt = null,Object? isMe = null,Object? isGroup = null,Object? reactions = null,Object? isRead = null,Object? readAt = freezed,Object? isSending = null,Object? hasFailed = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,senderId: null == senderId ? _self.senderId : senderId // ignore: cast_nullable_to_non_nullable
as String,senderName: null == senderName ? _self.senderName : senderName // ignore: cast_nullable_to_non_nullable
as String,senderAvatar: freezed == senderAvatar ? _self.senderAvatar : senderAvatar // ignore: cast_nullable_to_non_nullable
as String?,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as MessageType,mediaUrl: freezed == mediaUrl ? _self.mediaUrl : mediaUrl // ignore: cast_nullable_to_non_nullable
as String?,imageUrls: null == imageUrls ? _self.imageUrls : imageUrls // ignore: cast_nullable_to_non_nullable
as List<String>,waveformData: null == waveformData ? _self.waveformData : waveformData // ignore: cast_nullable_to_non_nullable
as List<double>,mediaDuration: freezed == mediaDuration ? _self.mediaDuration : mediaDuration // ignore: cast_nullable_to_non_nullable
as String?,mentionedUserId: freezed == mentionedUserId ? _self.mentionedUserId : mentionedUserId // ignore: cast_nullable_to_non_nullable
as String?,mentionedUserName: freezed == mentionedUserName ? _self.mentionedUserName : mentionedUserName // ignore: cast_nullable_to_non_nullable
as String?,sentAt: null == sentAt ? _self.sentAt : sentAt // ignore: cast_nullable_to_non_nullable
as DateTime,isMe: null == isMe ? _self.isMe : isMe // ignore: cast_nullable_to_non_nullable
as bool,isGroup: null == isGroup ? _self.isGroup : isGroup // ignore: cast_nullable_to_non_nullable
as bool,reactions: null == reactions ? _self.reactions : reactions // ignore: cast_nullable_to_non_nullable
as List<ReactionModel>,isRead: null == isRead ? _self.isRead : isRead // ignore: cast_nullable_to_non_nullable
as bool,readAt: freezed == readAt ? _self.readAt : readAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isSending: null == isSending ? _self.isSending : isSending // ignore: cast_nullable_to_non_nullable
as bool,hasFailed: null == hasFailed ? _self.hasFailed : hasFailed // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [MessageModel].
extension MessageModelPatterns on MessageModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MessageModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MessageModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MessageModel value)  $default,){
final _that = this;
switch (_that) {
case _MessageModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MessageModel value)?  $default,){
final _that = this;
switch (_that) {
case _MessageModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String senderId,  String senderName,  String? senderAvatar,  String content,  MessageType type,  String? mediaUrl,  List<String> imageUrls,  List<double> waveformData,  String? mediaDuration,  String? mentionedUserId,  String? mentionedUserName,  DateTime sentAt,  bool isMe,  bool isGroup,  List<ReactionModel> reactions,  bool isRead,  DateTime? readAt,  bool isSending,  bool hasFailed)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MessageModel() when $default != null:
return $default(_that.id,_that.senderId,_that.senderName,_that.senderAvatar,_that.content,_that.type,_that.mediaUrl,_that.imageUrls,_that.waveformData,_that.mediaDuration,_that.mentionedUserId,_that.mentionedUserName,_that.sentAt,_that.isMe,_that.isGroup,_that.reactions,_that.isRead,_that.readAt,_that.isSending,_that.hasFailed);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String senderId,  String senderName,  String? senderAvatar,  String content,  MessageType type,  String? mediaUrl,  List<String> imageUrls,  List<double> waveformData,  String? mediaDuration,  String? mentionedUserId,  String? mentionedUserName,  DateTime sentAt,  bool isMe,  bool isGroup,  List<ReactionModel> reactions,  bool isRead,  DateTime? readAt,  bool isSending,  bool hasFailed)  $default,) {final _that = this;
switch (_that) {
case _MessageModel():
return $default(_that.id,_that.senderId,_that.senderName,_that.senderAvatar,_that.content,_that.type,_that.mediaUrl,_that.imageUrls,_that.waveformData,_that.mediaDuration,_that.mentionedUserId,_that.mentionedUserName,_that.sentAt,_that.isMe,_that.isGroup,_that.reactions,_that.isRead,_that.readAt,_that.isSending,_that.hasFailed);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String senderId,  String senderName,  String? senderAvatar,  String content,  MessageType type,  String? mediaUrl,  List<String> imageUrls,  List<double> waveformData,  String? mediaDuration,  String? mentionedUserId,  String? mentionedUserName,  DateTime sentAt,  bool isMe,  bool isGroup,  List<ReactionModel> reactions,  bool isRead,  DateTime? readAt,  bool isSending,  bool hasFailed)?  $default,) {final _that = this;
switch (_that) {
case _MessageModel() when $default != null:
return $default(_that.id,_that.senderId,_that.senderName,_that.senderAvatar,_that.content,_that.type,_that.mediaUrl,_that.imageUrls,_that.waveformData,_that.mediaDuration,_that.mentionedUserId,_that.mentionedUserName,_that.sentAt,_that.isMe,_that.isGroup,_that.reactions,_that.isRead,_that.readAt,_that.isSending,_that.hasFailed);case _:
  return null;

}
}

}

/// @nodoc


class _MessageModel implements MessageModel {
  const _MessageModel({required this.id, required this.senderId, required this.senderName, this.senderAvatar, required this.content, required this.type, this.mediaUrl, final  List<String> imageUrls = const [], final  List<double> waveformData = const [], this.mediaDuration, this.mentionedUserId, this.mentionedUserName, required this.sentAt, required this.isMe, this.isGroup = false, final  List<ReactionModel> reactions = const [], this.isRead = false, this.readAt, this.isSending = false, this.hasFailed = false}): _imageUrls = imageUrls,_waveformData = waveformData,_reactions = reactions;
  

@override final  String id;
@override final  String senderId;
@override final  String senderName;
@override final  String? senderAvatar;
@override final  String content;
@override final  MessageType type;
@override final  String? mediaUrl;
 final  List<String> _imageUrls;
@override@JsonKey() List<String> get imageUrls {
  if (_imageUrls is EqualUnmodifiableListView) return _imageUrls;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_imageUrls);
}

 final  List<double> _waveformData;
@override@JsonKey() List<double> get waveformData {
  if (_waveformData is EqualUnmodifiableListView) return _waveformData;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_waveformData);
}

@override final  String? mediaDuration;
@override final  String? mentionedUserId;
@override final  String? mentionedUserName;
@override final  DateTime sentAt;
@override final  bool isMe;
@override@JsonKey() final  bool isGroup;
 final  List<ReactionModel> _reactions;
@override@JsonKey() List<ReactionModel> get reactions {
  if (_reactions is EqualUnmodifiableListView) return _reactions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_reactions);
}

@override@JsonKey() final  bool isRead;
@override final  DateTime? readAt;
@override@JsonKey() final  bool isSending;
@override@JsonKey() final  bool hasFailed;

/// Create a copy of MessageModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MessageModelCopyWith<_MessageModel> get copyWith => __$MessageModelCopyWithImpl<_MessageModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MessageModel&&(identical(other.id, id) || other.id == id)&&(identical(other.senderId, senderId) || other.senderId == senderId)&&(identical(other.senderName, senderName) || other.senderName == senderName)&&(identical(other.senderAvatar, senderAvatar) || other.senderAvatar == senderAvatar)&&(identical(other.content, content) || other.content == content)&&(identical(other.type, type) || other.type == type)&&(identical(other.mediaUrl, mediaUrl) || other.mediaUrl == mediaUrl)&&const DeepCollectionEquality().equals(other._imageUrls, _imageUrls)&&const DeepCollectionEquality().equals(other._waveformData, _waveformData)&&(identical(other.mediaDuration, mediaDuration) || other.mediaDuration == mediaDuration)&&(identical(other.mentionedUserId, mentionedUserId) || other.mentionedUserId == mentionedUserId)&&(identical(other.mentionedUserName, mentionedUserName) || other.mentionedUserName == mentionedUserName)&&(identical(other.sentAt, sentAt) || other.sentAt == sentAt)&&(identical(other.isMe, isMe) || other.isMe == isMe)&&(identical(other.isGroup, isGroup) || other.isGroup == isGroup)&&const DeepCollectionEquality().equals(other._reactions, _reactions)&&(identical(other.isRead, isRead) || other.isRead == isRead)&&(identical(other.readAt, readAt) || other.readAt == readAt)&&(identical(other.isSending, isSending) || other.isSending == isSending)&&(identical(other.hasFailed, hasFailed) || other.hasFailed == hasFailed));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,senderId,senderName,senderAvatar,content,type,mediaUrl,const DeepCollectionEquality().hash(_imageUrls),const DeepCollectionEquality().hash(_waveformData),mediaDuration,mentionedUserId,mentionedUserName,sentAt,isMe,isGroup,const DeepCollectionEquality().hash(_reactions),isRead,readAt,isSending,hasFailed]);

@override
String toString() {
  return 'MessageModel(id: $id, senderId: $senderId, senderName: $senderName, senderAvatar: $senderAvatar, content: $content, type: $type, mediaUrl: $mediaUrl, imageUrls: $imageUrls, waveformData: $waveformData, mediaDuration: $mediaDuration, mentionedUserId: $mentionedUserId, mentionedUserName: $mentionedUserName, sentAt: $sentAt, isMe: $isMe, isGroup: $isGroup, reactions: $reactions, isRead: $isRead, readAt: $readAt, isSending: $isSending, hasFailed: $hasFailed)';
}


}

/// @nodoc
abstract mixin class _$MessageModelCopyWith<$Res> implements $MessageModelCopyWith<$Res> {
  factory _$MessageModelCopyWith(_MessageModel value, $Res Function(_MessageModel) _then) = __$MessageModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String senderId, String senderName, String? senderAvatar, String content, MessageType type, String? mediaUrl, List<String> imageUrls, List<double> waveformData, String? mediaDuration, String? mentionedUserId, String? mentionedUserName, DateTime sentAt, bool isMe, bool isGroup, List<ReactionModel> reactions, bool isRead, DateTime? readAt, bool isSending, bool hasFailed
});




}
/// @nodoc
class __$MessageModelCopyWithImpl<$Res>
    implements _$MessageModelCopyWith<$Res> {
  __$MessageModelCopyWithImpl(this._self, this._then);

  final _MessageModel _self;
  final $Res Function(_MessageModel) _then;

/// Create a copy of MessageModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? senderId = null,Object? senderName = null,Object? senderAvatar = freezed,Object? content = null,Object? type = null,Object? mediaUrl = freezed,Object? imageUrls = null,Object? waveformData = null,Object? mediaDuration = freezed,Object? mentionedUserId = freezed,Object? mentionedUserName = freezed,Object? sentAt = null,Object? isMe = null,Object? isGroup = null,Object? reactions = null,Object? isRead = null,Object? readAt = freezed,Object? isSending = null,Object? hasFailed = null,}) {
  return _then(_MessageModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,senderId: null == senderId ? _self.senderId : senderId // ignore: cast_nullable_to_non_nullable
as String,senderName: null == senderName ? _self.senderName : senderName // ignore: cast_nullable_to_non_nullable
as String,senderAvatar: freezed == senderAvatar ? _self.senderAvatar : senderAvatar // ignore: cast_nullable_to_non_nullable
as String?,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as MessageType,mediaUrl: freezed == mediaUrl ? _self.mediaUrl : mediaUrl // ignore: cast_nullable_to_non_nullable
as String?,imageUrls: null == imageUrls ? _self._imageUrls : imageUrls // ignore: cast_nullable_to_non_nullable
as List<String>,waveformData: null == waveformData ? _self._waveformData : waveformData // ignore: cast_nullable_to_non_nullable
as List<double>,mediaDuration: freezed == mediaDuration ? _self.mediaDuration : mediaDuration // ignore: cast_nullable_to_non_nullable
as String?,mentionedUserId: freezed == mentionedUserId ? _self.mentionedUserId : mentionedUserId // ignore: cast_nullable_to_non_nullable
as String?,mentionedUserName: freezed == mentionedUserName ? _self.mentionedUserName : mentionedUserName // ignore: cast_nullable_to_non_nullable
as String?,sentAt: null == sentAt ? _self.sentAt : sentAt // ignore: cast_nullable_to_non_nullable
as DateTime,isMe: null == isMe ? _self.isMe : isMe // ignore: cast_nullable_to_non_nullable
as bool,isGroup: null == isGroup ? _self.isGroup : isGroup // ignore: cast_nullable_to_non_nullable
as bool,reactions: null == reactions ? _self._reactions : reactions // ignore: cast_nullable_to_non_nullable
as List<ReactionModel>,isRead: null == isRead ? _self.isRead : isRead // ignore: cast_nullable_to_non_nullable
as bool,readAt: freezed == readAt ? _self.readAt : readAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isSending: null == isSending ? _self.isSending : isSending // ignore: cast_nullable_to_non_nullable
as bool,hasFailed: null == hasFailed ? _self.hasFailed : hasFailed // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
