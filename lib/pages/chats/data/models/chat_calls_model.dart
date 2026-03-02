class ChatsAndCallsModel {
  final bool? success;
  final String? message;
  final ChatsAndCallData? data;

  ChatsAndCallsModel({this.success, this.message, this.data});

  ChatsAndCallsModel copyWith({
    bool? success,
    String? message,
    ChatsAndCallData? data,
  }) => ChatsAndCallsModel(
    success: success ?? this.success,
    message: message ?? this.message,
    data: data ?? this.data,
  );

  factory ChatsAndCallsModel.fromJson(Map<String, dynamic> json) =>
      ChatsAndCallsModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : ChatsAndCallData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class ChatsAndCallData {
  final List<Chat>? chats;
  final List<Call>? calls;

  ChatsAndCallData({this.chats, this.calls});

  ChatsAndCallData copyWith({List<Chat>? chats, List<Call>? calls}) =>
      ChatsAndCallData(chats: chats ?? this.chats, calls: calls ?? this.calls);

  factory ChatsAndCallData.fromJson(Map<String, dynamic> json) =>
      ChatsAndCallData(
        chats: json["chats"] == null
            ? []
            : List<Chat>.from(json["chats"]!.map((x) => Chat.fromJson(x))),
        calls: json["calls"] == null
            ? []
            : List<Call>.from(json["calls"]!.map((x) => Call.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "chats": chats == null
        ? []
        : List<dynamic>.from(chats!.map((x) => x.toJson())),
    "calls": calls == null
        ? []
        : List<dynamic>.from(calls!.map((x) => x.toJson())),
  };
}

class Call {
  final String? id;
  final String? name;
  final String? image;
  final List<Member>? members;
  final String? callTypeLabel;
  final String? duration;
  final String? timeAgo;
  final Id? callerId;
  final String? channelName;
  final String? mediaType;
  final String? callType;
  final List<Id>? participantIds;
  final DateTime? startedAt;
  final DateTime? endedAt;
  final int? durationSeconds;
  final String? status;

  Call({
    this.id,
    this.name,
    this.image,
    this.members,
    this.callTypeLabel,
    this.duration,
    this.timeAgo,
    this.callerId,
    this.channelName,
    this.mediaType,
    this.callType,
    this.participantIds,
    this.startedAt,
    this.endedAt,
    this.durationSeconds,
    this.status,
  });

  Call copyWith({
    String? id,
    String? name,
    String? image,
    List<Member>? members,
    String? callTypeLabel,
    String? duration,
    String? timeAgo,
    Id? callerId,
    String? channelName,
    String? mediaType,
    String? callType,
    List<Id>? participantIds,
    DateTime? startedAt,
    DateTime? endedAt,
    int? durationSeconds,
    String? status,
  }) => Call(
    id: id ?? this.id,
    name: name ?? this.name,
    image: image ?? this.image,
    members: members ?? this.members,
    callTypeLabel: callTypeLabel ?? this.callTypeLabel,
    duration: duration ?? this.duration,
    timeAgo: timeAgo ?? this.timeAgo,
    callerId: callerId ?? this.callerId,
    channelName: channelName ?? this.channelName,
    mediaType: mediaType ?? this.mediaType,
    callType: callType ?? this.callType,
    participantIds: participantIds ?? this.participantIds,
    startedAt: startedAt ?? this.startedAt,
    endedAt: endedAt ?? this.endedAt,
    durationSeconds: durationSeconds ?? this.durationSeconds,
    status: status ?? this.status,
  );

  factory Call.fromJson(Map<String, dynamic> json) => Call(
    id: json["_id"],
    name: json["name"],
    image: json["image"],
    members: json["members"] == null
        ? []
        : List<Member>.from(json["members"]!.map((x) => Member.fromJson(x))),
    callTypeLabel: json["callTypeLabel"],
    duration: json["duration"],
    timeAgo: json["timeAgo"],
    callerId: json["callerId"] == null ? null : Id.fromJson(json["callerId"]),
    channelName: json["channelName"],
    mediaType: json["mediaType"],
    callType: json["callType"],
    participantIds: json["participantIds"] == null
        ? []
        : List<Id>.from(json["participantIds"]!.map((x) => Id.fromJson(x))),
    startedAt: json["startedAt"] == null
        ? null
        : DateTime.parse(json["startedAt"]),
    endedAt: json["endedAt"] == null ? null : DateTime.parse(json["endedAt"]),
    durationSeconds: json["durationSeconds"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "image": image,
    "members": members == null
        ? []
        : List<dynamic>.from(members!.map((x) => x.toJson())),
    "callTypeLabel": callTypeLabel,
    "duration": duration,
    "timeAgo": timeAgo,
    "callerId": callerId?.toJson(),
    "channelName": channelName,
    "mediaType": mediaType,
    "callType": callType,
    "participantIds": participantIds == null
        ? []
        : List<dynamic>.from(participantIds!.map((x) => x.toJson())),
    "startedAt": startedAt?.toIso8601String(),
    "endedAt": endedAt?.toIso8601String(),
    "durationSeconds": durationSeconds,
    "status": status,
  };
}

class Id {
  final IdEnum? id;
  final FirstName? firstName;
  final LastName? lastName;
  final List<String>? bestShorts;

  Id({this.id, this.firstName, this.lastName, this.bestShorts});

  Id copyWith({
    IdEnum? id,
    FirstName? firstName,
    LastName? lastName,
    List<String>? bestShorts,
  }) => Id(
    id: id ?? this.id,
    firstName: firstName ?? this.firstName,
    lastName: lastName ?? this.lastName,
    bestShorts: bestShorts ?? this.bestShorts,
  );

  factory Id.fromJson(Map<String, dynamic> json) => Id(
    id: idEnumValues.map[json["_id"]]!,
    firstName: firstNameValues.map[json["firstName"]]!,
    lastName: lastNameValues.map[json["lastName"]]!,
    bestShorts: json["bestShorts"] == null
        ? []
        : List<String>.from(json["bestShorts"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "_id": idEnumValues.reverse[id],
    "firstName": firstNameValues.reverse[firstName],
    "lastName": lastNameValues.reverse[lastName],
    "bestShorts": bestShorts == null
        ? []
        : List<dynamic>.from(bestShorts!.map((x) => x)),
  };
}

enum FirstName { MOAZZAM, WAJAHAT }

final firstNameValues = EnumValues({
  "Moazzam": FirstName.MOAZZAM,
  "Wajahat ": FirstName.WAJAHAT,
});

enum IdEnum {
  THE_697_CDC5_B738503_F0_F50_F854_B,
  THE_69863_C585_F012_B8_BCB5_CAB7_C,
}

final idEnumValues = EnumValues({
  "697cdc5b738503f0f50f854b": IdEnum.THE_697_CDC5_B738503_F0_F50_F854_B,
  "69863c585f012b8bcb5cab7c": IdEnum.THE_69863_C585_F012_B8_BCB5_CAB7_C,
});

enum LastName { ALI }

final lastNameValues = EnumValues({"Ali": LastName.ALI});

class Member {
  final IdEnum? id;
  final Name? name;
  final String? image;

  Member({this.id, this.name, this.image});

  Member copyWith({IdEnum? id, Name? name, String? image}) => Member(
    id: id ?? this.id,
    name: name ?? this.name,
    image: image ?? this.image,
  );

  factory Member.fromJson(Map<String, dynamic> json) => Member(
    id: idEnumValues.map[json["id"]]!,
    name: nameValues.map[json["name"]]!,
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": idEnumValues.reverse[id],
    "name": nameValues.reverse[name],
    "image": image,
  };
}

enum Name { MOAZZAM_ALI, WAJAHAT_ALI }

final nameValues = EnumValues({
  "Moazzam Ali": Name.MOAZZAM_ALI,
  "Wajahat  Ali": Name.WAJAHAT_ALI,
});

class Chat {
  final String? type;
  final String? id;
  final String? name;
  final List<Member>? members;
  final String? lastMessage;
  final int? unreadCount;
  final Meta? meta;

  Chat({
    this.type,
    this.id,
    this.name,
    this.members,
    this.lastMessage,
    this.unreadCount,
    this.meta,
  });

  Chat copyWith({
    String? type,
    String? id,
    String? name,
    List<Member>? members,
    String? lastMessage,
    int? unreadCount,
    Meta? meta,
  }) => Chat(
    type: type ?? this.type,
    id: id ?? this.id,
    name: name ?? this.name,
    members: members ?? this.members,
    lastMessage: lastMessage ?? this.lastMessage,
    unreadCount: unreadCount ?? this.unreadCount,
    meta: meta ?? this.meta,
  );

  factory Chat.fromJson(Map<String, dynamic> json) => Chat(
    type: json["type"],
    id: json["id"],
    name: json["name"],
    members: json["members"] == null
        ? []
        : List<Member>.from(json["members"]!.map((x) => Member.fromJson(x))),
    lastMessage: json["lastMessage"],
    unreadCount: json["unreadCount"],
    meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "id": id,
    "name": name,
    "members": members == null
        ? []
        : List<dynamic>.from(members!.map((x) => x.toJson())),
    "lastMessage": lastMessage,
    "unreadCount": unreadCount,
    "meta": meta?.toJson(),
  };
}

class Meta {
  final String? groupId;

  Meta({this.groupId});

  Meta copyWith({String? groupId}) => Meta(groupId: groupId ?? this.groupId);

  factory Meta.fromJson(Map<String, dynamic> json) =>
      Meta(groupId: json["groupId"]);

  Map<String, dynamic> toJson() => {"groupId": groupId};
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
