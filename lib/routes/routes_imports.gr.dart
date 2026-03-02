// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i50;
import 'package:collection/collection.dart' as _i54;
import 'package:fennac_app/pages/auth/presentation/screen/create_account_screen.dart'
    as _i10;
import 'package:fennac_app/pages/auth/presentation/screen/login_screen.dart'
    as _i33;
import 'package:fennac_app/pages/auth/presentation/screen/otp_verification_screen.dart'
    as _i40;
import 'package:fennac_app/pages/auth/presentation/screen/reset_password_screen.dart'
    as _i44;
import 'package:fennac_app/pages/auth/presentation/screen/set_new_password_screen.dart'
    as _i45;
import 'package:fennac_app/pages/auth/presentation/screen/verify_phone_screen.dart'
    as _i47;
import 'package:fennac_app/pages/buy_poke/presentation/screen/buy_poke_screen.dart'
    as _i4;
import 'package:fennac_app/pages/call/presentation/screen/audio_call_screen.dart'
    as _i3;
import 'package:fennac_app/pages/call/presentation/screen/call_screen.dart'
    as _i5;
import 'package:fennac_app/pages/call/presentation/screen/group_audio_call_screen.dart'
    as _i21;
import 'package:fennac_app/pages/call/presentation/screen/video_call_screen.dart'
    as _i48;
import 'package:fennac_app/pages/chats/data/models/message_model.dart' as _i53;
import 'package:fennac_app/pages/chats/presentation/screen/chat_landing_screen.dart'
    as _i8;
import 'package:fennac_app/pages/chats/presentation/screen/group_chat_screen.dart'
    as _i22;
import 'package:fennac_app/pages/chats/presentation/screen/group_detail_screen.dart'
    as _i23;
import 'package:fennac_app/pages/chats/presentation/screen/media_preview_screen.dart'
    as _i35;
import 'package:fennac_app/pages/create_group/presentation/screen/add_member_screen.dart'
    as _i1;
import 'package:fennac_app/pages/create_group/presentation/screen/create_group_gallery_screen.dart'
    as _i11;
import 'package:fennac_app/pages/create_group/presentation/screen/create_group_screen.dart'
    as _i12;
import 'package:fennac_app/pages/dashboard/presentation/screen/dashboard_screen.dart'
    as _i13;
import 'package:fennac_app/pages/filter/presentation/screen/distance_screen.dart'
    as _i14;
import 'package:fennac_app/pages/filter/presentation/screen/filter_screen.dart'
    as _i18;
import 'package:fennac_app/pages/find_group/presentation/screen/find_group_screen.dart'
    as _i19;
import 'package:fennac_app/pages/get_poked/presentation/screen/get_pocked_screen.dart'
    as _i20;
import 'package:fennac_app/pages/home/data/models/groups_model.dart' as _i52;
import 'package:fennac_app/pages/home/presentation/screen/home_screen.dart'
    as _i26;
import 'package:fennac_app/pages/homelanding/presentation/screen/home_landing_screen.dart'
    as _i25;
import 'package:fennac_app/pages/kyc/presentation/screen/kyc_details_screen.dart'
    as _i27;
import 'package:fennac_app/pages/kyc/presentation/screen/kyc_gallery_screen.dart'
    as _i28;
import 'package:fennac_app/pages/kyc/presentation/screen/kyc_match_screen.dart'
    as _i29;
import 'package:fennac_app/pages/kyc/presentation/screen/kyc_prompt_screen.dart'
    as _i30;
import 'package:fennac_app/pages/kyc/presentation/screen/kyc_screen.dart'
    as _i31;
import 'package:fennac_app/pages/landing/presentation/screen/landing_screen.dart'
    as _i32;
import 'package:fennac_app/pages/my_group/presentation/screen/edit_group_screen.dart'
    as _i15;
import 'package:fennac_app/pages/my_group/presentation/screen/my_group_screen.dart'
    as _i36;
import 'package:fennac_app/pages/profile/presentation/screen/appearence_screen.dart'
    as _i2;
import 'package:fennac_app/pages/profile/presentation/screen/change_email_phone_screen.dart'
    as _i6;
import 'package:fennac_app/pages/profile/presentation/screen/change_password.dart'
    as _i7;
import 'package:fennac_app/pages/profile/presentation/screen/contact_support_screen.dart'
    as _i9;
import 'package:fennac_app/pages/edit_profile/presentation/screen/edit_public_profile_screen.dart'
    as _i16;
import 'package:fennac_app/pages/profile/presentation/screen/faq_screen.dart'
    as _i17;
import 'package:fennac_app/pages/profile/presentation/screen/help_support_screen.dart'
    as _i24;
import 'package:fennac_app/pages/profile/presentation/screen/manage_subscriptions_screen.dart'
    as _i34;
import 'package:fennac_app/pages/profile/presentation/screen/notification_settings_screen.dart'
    as _i37;
import 'package:fennac_app/pages/profile/presentation/screen/privacy_permissions_screen.dart'
    as _i41;
import 'package:fennac_app/pages/profile/presentation/screen/profile_screen.dart'
    as _i42;
import 'package:fennac_app/pages/profile/presentation/screen/report_problem_screen.dart'
    as _i43;
import 'package:fennac_app/pages/profile/presentation/screen/your_groups_screen.dart'
    as _i49;
import 'package:fennac_app/pages/splash/presentation/screen/onboarding_screen.dart'
    as _i38;
import 'package:fennac_app/pages/splash/presentation/screen/onboarding_screen1.dart'
    as _i39;
import 'package:fennac_app/pages/splash/presentation/screen/splash_screen.dart'
    as _i46;
import 'package:flutter/material.dart' as _i51;

/// generated route for
/// [_i1.AddMemberScreen]
class AddMemberRoute extends _i50.PageRouteInfo<void> {
  const AddMemberRoute({List<_i50.PageRouteInfo>? children})
    : super(AddMemberRoute.name, initialChildren: children);

  static const String name = 'AddMemberRoute';

  static _i50.PageInfo page = _i50.PageInfo(
    name,
    builder: (data) {
      return const _i1.AddMemberScreen();
    },
  );
}

/// generated route for
/// [_i2.AppearenceScreen]
class AppearenceRoute extends _i50.PageRouteInfo<void> {
  const AppearenceRoute({List<_i50.PageRouteInfo>? children})
    : super(AppearenceRoute.name, initialChildren: children);

  static const String name = 'AppearenceRoute';

  static _i50.PageInfo page = _i50.PageInfo(
    name,
    builder: (data) {
      return const _i2.AppearenceScreen();
    },
  );
}

/// generated route for
/// [_i3.AudioCallScreen]
class AudioCallRoute extends _i50.PageRouteInfo<void> {
  const AudioCallRoute({List<_i50.PageRouteInfo>? children})
    : super(AudioCallRoute.name, initialChildren: children);

  static const String name = 'AudioCallRoute';

  static _i50.PageInfo page = _i50.PageInfo(
    name,
    builder: (data) {
      return const _i3.AudioCallScreen();
    },
  );
}

/// generated route for
/// [_i4.BuyPokeScreen]
class BuyPokeRoute extends _i50.PageRouteInfo<void> {
  const BuyPokeRoute({List<_i50.PageRouteInfo>? children})
    : super(BuyPokeRoute.name, initialChildren: children);

  static const String name = 'BuyPokeRoute';

  static _i50.PageInfo page = _i50.PageInfo(
    name,
    builder: (data) {
      return const _i4.BuyPokeScreen();
    },
  );
}

/// generated route for
/// [_i5.CallScreen]
class CallRoute extends _i50.PageRouteInfo<void> {
  const CallRoute({List<_i50.PageRouteInfo>? children})
    : super(CallRoute.name, initialChildren: children);

  static const String name = 'CallRoute';

  static _i50.PageInfo page = _i50.PageInfo(
    name,
    builder: (data) {
      return const _i5.CallScreen();
    },
  );
}

/// generated route for
/// [_i6.ChangeEmailPhoneScreen]
class ChangeEmailPhoneRoute extends _i50.PageRouteInfo<void> {
  const ChangeEmailPhoneRoute({List<_i50.PageRouteInfo>? children})
    : super(ChangeEmailPhoneRoute.name, initialChildren: children);

  static const String name = 'ChangeEmailPhoneRoute';

  static _i50.PageInfo page = _i50.PageInfo(
    name,
    builder: (data) {
      return const _i6.ChangeEmailPhoneScreen();
    },
  );
}

/// generated route for
/// [_i7.ChangePasswordScreen]
class ChangePasswordRoute extends _i50.PageRouteInfo<void> {
  const ChangePasswordRoute({List<_i50.PageRouteInfo>? children})
    : super(ChangePasswordRoute.name, initialChildren: children);

  static const String name = 'ChangePasswordRoute';

  static _i50.PageInfo page = _i50.PageInfo(
    name,
    builder: (data) {
      return const _i7.ChangePasswordScreen();
    },
  );
}

/// generated route for
/// [_i8.ChatLandingScreen]
class ChatLandingRoute extends _i50.PageRouteInfo<void> {
  const ChatLandingRoute({List<_i50.PageRouteInfo>? children})
    : super(ChatLandingRoute.name, initialChildren: children);

  static const String name = 'ChatLandingRoute';

  static _i50.PageInfo page = _i50.PageInfo(
    name,
    builder: (data) {
      return const _i8.ChatLandingScreen();
    },
  );
}

/// generated route for
/// [_i9.ContactSupportScreen]
class ContactSupportRoute extends _i50.PageRouteInfo<void> {
  const ContactSupportRoute({List<_i50.PageRouteInfo>? children})
    : super(ContactSupportRoute.name, initialChildren: children);

  static const String name = 'ContactSupportRoute';

  static _i50.PageInfo page = _i50.PageInfo(
    name,
    builder: (data) {
      return const _i9.ContactSupportScreen();
    },
  );
}

/// generated route for
/// [_i10.CreateAccountScreen]
class CreateAccountRoute extends _i50.PageRouteInfo<void> {
  const CreateAccountRoute({List<_i50.PageRouteInfo>? children})
    : super(CreateAccountRoute.name, initialChildren: children);

  static const String name = 'CreateAccountRoute';

  static _i50.PageInfo page = _i50.PageInfo(
    name,
    builder: (data) {
      return const _i10.CreateAccountScreen();
    },
  );
}

/// generated route for
/// [_i11.CreateGroupGalleryScreen]
class CreateGroupGalleryRoute
    extends _i50.PageRouteInfo<CreateGroupGalleryRouteArgs> {
  CreateGroupGalleryRoute({
    _i51.Key? key,
    bool isEditMode = false,
    List<_i50.PageRouteInfo>? children,
  }) : super(
         CreateGroupGalleryRoute.name,
         args: CreateGroupGalleryRouteArgs(key: key, isEditMode: isEditMode),
         initialChildren: children,
       );

  static const String name = 'CreateGroupGalleryRoute';

  static _i50.PageInfo page = _i50.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CreateGroupGalleryRouteArgs>(
        orElse: () => const CreateGroupGalleryRouteArgs(),
      );
      return _i11.CreateGroupGalleryScreen(
        key: args.key,
        isEditMode: args.isEditMode,
      );
    },
  );
}

class CreateGroupGalleryRouteArgs {
  const CreateGroupGalleryRouteArgs({this.key, this.isEditMode = false});

  final _i51.Key? key;

  final bool isEditMode;

  @override
  String toString() {
    return 'CreateGroupGalleryRouteArgs{key: $key, isEditMode: $isEditMode}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! CreateGroupGalleryRouteArgs) return false;
    return key == other.key && isEditMode == other.isEditMode;
  }

  @override
  int get hashCode => key.hashCode ^ isEditMode.hashCode;
}

/// generated route for
/// [_i12.CreateGroupScreen]
class CreateGroupRoute extends _i50.PageRouteInfo<CreateGroupRouteArgs> {
  CreateGroupRoute({
    _i51.Key? key,
    bool isEditMode = false,
    List<_i50.PageRouteInfo>? children,
  }) : super(
         CreateGroupRoute.name,
         args: CreateGroupRouteArgs(key: key, isEditMode: isEditMode),
         initialChildren: children,
       );

  static const String name = 'CreateGroupRoute';

  static _i50.PageInfo page = _i50.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CreateGroupRouteArgs>(
        orElse: () => const CreateGroupRouteArgs(),
      );
      return _i12.CreateGroupScreen(key: args.key, isEditMode: args.isEditMode);
    },
  );
}

class CreateGroupRouteArgs {
  const CreateGroupRouteArgs({this.key, this.isEditMode = false});

  final _i51.Key? key;

  final bool isEditMode;

  @override
  String toString() {
    return 'CreateGroupRouteArgs{key: $key, isEditMode: $isEditMode}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! CreateGroupRouteArgs) return false;
    return key == other.key && isEditMode == other.isEditMode;
  }

  @override
  int get hashCode => key.hashCode ^ isEditMode.hashCode;
}

/// generated route for
/// [_i13.DashboardScreen]
class DashboardRoute extends _i50.PageRouteInfo<void> {
  const DashboardRoute({List<_i50.PageRouteInfo>? children})
    : super(DashboardRoute.name, initialChildren: children);

  static const String name = 'DashboardRoute';

  static _i50.PageInfo page = _i50.PageInfo(
    name,
    builder: (data) {
      return const _i13.DashboardScreen();
    },
  );
}

/// generated route for
/// [_i14.DistanceScreen]
class DistanceRoute extends _i50.PageRouteInfo<void> {
  const DistanceRoute({List<_i50.PageRouteInfo>? children})
    : super(DistanceRoute.name, initialChildren: children);

  static const String name = 'DistanceRoute';

  static _i50.PageInfo page = _i50.PageInfo(
    name,
    builder: (data) {
      return const _i14.DistanceScreen();
    },
  );
}

/// generated route for
/// [_i15.EditGroupScreen]
class EditGroupRoute extends _i50.PageRouteInfo<EditGroupRouteArgs> {
  EditGroupRoute({
    _i51.Key? key,
    required String groupId,
    List<_i50.PageRouteInfo>? children,
  }) : super(
         EditGroupRoute.name,
         args: EditGroupRouteArgs(key: key, groupId: groupId),
         initialChildren: children,
       );

  static const String name = 'EditGroupRoute';

  static _i50.PageInfo page = _i50.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EditGroupRouteArgs>();
      return _i15.EditGroupScreen(key: args.key, groupId: args.groupId);
    },
  );
}

class EditGroupRouteArgs {
  const EditGroupRouteArgs({this.key, required this.groupId});

  final _i51.Key? key;

  final String groupId;

  @override
  String toString() {
    return 'EditGroupRouteArgs{key: $key, groupId: $groupId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! EditGroupRouteArgs) return false;
    return key == other.key && groupId == other.groupId;
  }

  @override
  int get hashCode => key.hashCode ^ groupId.hashCode;
}

/// generated route for
/// [_i16.EditPublicProfileScreen]
class EditPublicProfileRoute extends _i50.PageRouteInfo<void> {
  const EditPublicProfileRoute({List<_i50.PageRouteInfo>? children})
    : super(EditPublicProfileRoute.name, initialChildren: children);

  static const String name = 'EditPublicProfileRoute';

  static _i50.PageInfo page = _i50.PageInfo(
    name,
    builder: (data) {
      return const _i16.EditPublicProfileScreen();
    },
  );
}

/// generated route for
/// [_i17.FaqScreen]
class FaqRoute extends _i50.PageRouteInfo<void> {
  const FaqRoute({List<_i50.PageRouteInfo>? children})
    : super(FaqRoute.name, initialChildren: children);

  static const String name = 'FaqRoute';

  static _i50.PageInfo page = _i50.PageInfo(
    name,
    builder: (data) {
      return const _i17.FaqScreen();
    },
  );
}

/// generated route for
/// [_i18.FilterScreen]
class FilterRoute extends _i50.PageRouteInfo<void> {
  const FilterRoute({List<_i50.PageRouteInfo>? children})
    : super(FilterRoute.name, initialChildren: children);

  static const String name = 'FilterRoute';

  static _i50.PageInfo page = _i50.PageInfo(
    name,
    builder: (data) {
      return const _i18.FilterScreen();
    },
  );
}

/// generated route for
/// [_i19.FindGroupScreen]
class FindGroupRoute extends _i50.PageRouteInfo<FindGroupRouteArgs> {
  FindGroupRoute({
    _i51.Key? key,
    String? qrCode,
    List<_i50.PageRouteInfo>? children,
  }) : super(
         FindGroupRoute.name,
         args: FindGroupRouteArgs(key: key, qrCode: qrCode),
         initialChildren: children,
       );

  static const String name = 'FindGroupRoute';

  static _i50.PageInfo page = _i50.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<FindGroupRouteArgs>(
        orElse: () => const FindGroupRouteArgs(),
      );
      return _i19.FindGroupScreen(key: args.key, qrCode: args.qrCode);
    },
  );
}

class FindGroupRouteArgs {
  const FindGroupRouteArgs({this.key, this.qrCode});

  final _i51.Key? key;

  final String? qrCode;

  @override
  String toString() {
    return 'FindGroupRouteArgs{key: $key, qrCode: $qrCode}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! FindGroupRouteArgs) return false;
    return key == other.key && qrCode == other.qrCode;
  }

  @override
  int get hashCode => key.hashCode ^ qrCode.hashCode;
}

/// generated route for
/// [_i20.GetPockedScreen]
class GetPockedRoute extends _i50.PageRouteInfo<GetPockedRouteArgs> {
  GetPockedRoute({
    _i51.Key? key,
    required _i52.Group group,
    List<_i50.PageRouteInfo>? children,
  }) : super(
         GetPockedRoute.name,
         args: GetPockedRouteArgs(key: key, group: group),
         initialChildren: children,
       );

  static const String name = 'GetPockedRoute';

  static _i50.PageInfo page = _i50.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<GetPockedRouteArgs>();
      return _i20.GetPockedScreen(key: args.key, group: args.group);
    },
  );
}

class GetPockedRouteArgs {
  const GetPockedRouteArgs({this.key, required this.group});

  final _i51.Key? key;

  final _i52.Group group;

  @override
  String toString() {
    return 'GetPockedRouteArgs{key: $key, group: $group}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! GetPockedRouteArgs) return false;
    return key == other.key && group == other.group;
  }

  @override
  int get hashCode => key.hashCode ^ group.hashCode;
}

/// generated route for
/// [_i21.GroupAudioCallScreen]
class GroupAudioCallRoute extends _i50.PageRouteInfo<GroupAudioCallRouteArgs> {
  GroupAudioCallRoute({
    _i51.Key? key,
    required _i52.Group group,
    bool isVideoCall = false,
    List<_i50.PageRouteInfo>? children,
  }) : super(
         GroupAudioCallRoute.name,
         args: GroupAudioCallRouteArgs(
           key: key,
           group: group,
           isVideoCall: isVideoCall,
         ),
         initialChildren: children,
       );

  static const String name = 'GroupAudioCallRoute';

  static _i50.PageInfo page = _i50.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<GroupAudioCallRouteArgs>();
      return _i21.GroupAudioCallScreen(
        key: args.key,
        group: args.group,
        isVideoCall: args.isVideoCall,
      );
    },
  );
}

class GroupAudioCallRouteArgs {
  const GroupAudioCallRouteArgs({
    this.key,
    required this.group,
    this.isVideoCall = false,
  });

  final _i51.Key? key;

  final _i52.Group group;

  final bool isVideoCall;

  @override
  String toString() {
    return 'GroupAudioCallRouteArgs{key: $key, group: $group, isVideoCall: $isVideoCall}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! GroupAudioCallRouteArgs) return false;
    return key == other.key &&
        group == other.group &&
        isVideoCall == other.isVideoCall;
  }

  @override
  int get hashCode => key.hashCode ^ group.hashCode ^ isVideoCall.hashCode;
}

/// generated route for
/// [_i22.GroupChatScreen]
class GroupChatRoute extends _i50.PageRouteInfo<GroupChatRouteArgs> {
  GroupChatRoute({
    _i51.Key? key,
    bool isGroup = true,
    required String groupId,
    String? contactName,
    String? contactAvatar,
    bool isOnline = false,
    List<_i50.PageRouteInfo>? children,
  }) : super(
         GroupChatRoute.name,
         args: GroupChatRouteArgs(
           key: key,
           isGroup: isGroup,
           groupId: groupId,
           contactName: contactName,
           contactAvatar: contactAvatar,
           isOnline: isOnline,
         ),
         initialChildren: children,
       );

  static const String name = 'GroupChatRoute';

  static _i50.PageInfo page = _i50.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<GroupChatRouteArgs>();
      return _i22.GroupChatScreen(
        key: args.key,
        isGroup: args.isGroup,
        groupId: args.groupId,
        contactName: args.contactName,
        contactAvatar: args.contactAvatar,
        isOnline: args.isOnline,
      );
    },
  );
}

class GroupChatRouteArgs {
  const GroupChatRouteArgs({
    this.key,
    this.isGroup = true,
    required this.groupId,
    this.contactName,
    this.contactAvatar,
    this.isOnline = false,
  });

  final _i51.Key? key;

  final bool isGroup;

  final String groupId;

  final String? contactName;

  final String? contactAvatar;

  final bool isOnline;

  @override
  String toString() {
    return 'GroupChatRouteArgs{key: $key, isGroup: $isGroup, groupId: $groupId, contactName: $contactName, contactAvatar: $contactAvatar, isOnline: $isOnline}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! GroupChatRouteArgs) return false;
    return key == other.key &&
        isGroup == other.isGroup &&
        groupId == other.groupId &&
        contactName == other.contactName &&
        contactAvatar == other.contactAvatar &&
        isOnline == other.isOnline;
  }

  @override
  int get hashCode =>
      key.hashCode ^
      isGroup.hashCode ^
      groupId.hashCode ^
      contactName.hashCode ^
      contactAvatar.hashCode ^
      isOnline.hashCode;
}

/// generated route for
/// [_i23.GroupDetailScreen]
class GroupDetailRoute extends _i50.PageRouteInfo<GroupDetailRouteArgs> {
  GroupDetailRoute({
    _i51.Key? key,
    bool isGroup = true,
    String? contactName,
    String? contactAvatar,
    bool isOnline = false,
    List<_i50.PageRouteInfo>? children,
  }) : super(
         GroupDetailRoute.name,
         args: GroupDetailRouteArgs(
           key: key,
           isGroup: isGroup,
           contactName: contactName,
           contactAvatar: contactAvatar,
           isOnline: isOnline,
         ),
         initialChildren: children,
       );

  static const String name = 'GroupDetailRoute';

  static _i50.PageInfo page = _i50.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<GroupDetailRouteArgs>(
        orElse: () => const GroupDetailRouteArgs(),
      );
      return _i23.GroupDetailScreen(
        key: args.key,
        isGroup: args.isGroup,
        contactName: args.contactName,
        contactAvatar: args.contactAvatar,
        isOnline: args.isOnline,
      );
    },
  );
}

class GroupDetailRouteArgs {
  const GroupDetailRouteArgs({
    this.key,
    this.isGroup = true,
    this.contactName,
    this.contactAvatar,
    this.isOnline = false,
  });

  final _i51.Key? key;

  final bool isGroup;

  final String? contactName;

  final String? contactAvatar;

  final bool isOnline;

  @override
  String toString() {
    return 'GroupDetailRouteArgs{key: $key, isGroup: $isGroup, contactName: $contactName, contactAvatar: $contactAvatar, isOnline: $isOnline}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! GroupDetailRouteArgs) return false;
    return key == other.key &&
        isGroup == other.isGroup &&
        contactName == other.contactName &&
        contactAvatar == other.contactAvatar &&
        isOnline == other.isOnline;
  }

  @override
  int get hashCode =>
      key.hashCode ^
      isGroup.hashCode ^
      contactName.hashCode ^
      contactAvatar.hashCode ^
      isOnline.hashCode;
}

/// generated route for
/// [_i24.HelpSupportScreen]
class HelpSupportRoute extends _i50.PageRouteInfo<void> {
  const HelpSupportRoute({List<_i50.PageRouteInfo>? children})
    : super(HelpSupportRoute.name, initialChildren: children);

  static const String name = 'HelpSupportRoute';

  static _i50.PageInfo page = _i50.PageInfo(
    name,
    builder: (data) {
      return const _i24.HelpSupportScreen();
    },
  );
}

/// generated route for
/// [_i25.HomeLandingScreen]
class HomeLandingRoute extends _i50.PageRouteInfo<void> {
  const HomeLandingRoute({List<_i50.PageRouteInfo>? children})
    : super(HomeLandingRoute.name, initialChildren: children);

  static const String name = 'HomeLandingRoute';

  static _i50.PageInfo page = _i50.PageInfo(
    name,
    builder: (data) {
      return const _i25.HomeLandingScreen();
    },
  );
}

/// generated route for
/// [_i26.HomeScreen]
class HomeRoute extends _i50.PageRouteInfo<void> {
  const HomeRoute({List<_i50.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i50.PageInfo page = _i50.PageInfo(
    name,
    builder: (data) {
      return const _i26.HomeScreen();
    },
  );
}

/// generated route for
/// [_i27.KycDetailsScreen]
class KycDetailsRoute extends _i50.PageRouteInfo<void> {
  const KycDetailsRoute({List<_i50.PageRouteInfo>? children})
    : super(KycDetailsRoute.name, initialChildren: children);

  static const String name = 'KycDetailsRoute';

  static _i50.PageInfo page = _i50.PageInfo(
    name,
    builder: (data) {
      return const _i27.KycDetailsScreen();
    },
  );
}

/// generated route for
/// [_i28.KycGalleryScreen]
class KycGalleryRoute extends _i50.PageRouteInfo<KycGalleryRouteArgs> {
  KycGalleryRoute({
    _i51.Key? key,
    bool? isEditMode = false,
    List<_i50.PageRouteInfo>? children,
  }) : super(
         KycGalleryRoute.name,
         args: KycGalleryRouteArgs(key: key, isEditMode: isEditMode),
         initialChildren: children,
       );

  static const String name = 'KycGalleryRoute';

  static _i50.PageInfo page = _i50.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<KycGalleryRouteArgs>(
        orElse: () => const KycGalleryRouteArgs(),
      );
      return _i28.KycGalleryScreen(key: args.key, isEditMode: args.isEditMode);
    },
  );
}

class KycGalleryRouteArgs {
  const KycGalleryRouteArgs({this.key, this.isEditMode = false});

  final _i51.Key? key;

  final bool? isEditMode;

  @override
  String toString() {
    return 'KycGalleryRouteArgs{key: $key, isEditMode: $isEditMode}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! KycGalleryRouteArgs) return false;
    return key == other.key && isEditMode == other.isEditMode;
  }

  @override
  int get hashCode => key.hashCode ^ isEditMode.hashCode;
}

/// generated route for
/// [_i29.KycMatchScreen]
class KycMatchRoute extends _i50.PageRouteInfo<void> {
  const KycMatchRoute({List<_i50.PageRouteInfo>? children})
    : super(KycMatchRoute.name, initialChildren: children);

  static const String name = 'KycMatchRoute';

  static _i50.PageInfo page = _i50.PageInfo(
    name,
    builder: (data) {
      return const _i29.KycMatchScreen();
    },
  );
}

/// generated route for
/// [_i30.KycPromptScreen]
class KycPromptRoute extends _i50.PageRouteInfo<KycPromptRouteArgs> {
  KycPromptRoute({
    _i51.Key? key,
    required bool showSkipButton,
    String? title,
    String? subtitle,
    bool? isEditMode = false,
    List<_i50.PageRouteInfo>? children,
  }) : super(
         KycPromptRoute.name,
         args: KycPromptRouteArgs(
           key: key,
           showSkipButton: showSkipButton,
           title: title,
           subtitle: subtitle,
           isEditMode: isEditMode,
         ),
         initialChildren: children,
       );

  static const String name = 'KycPromptRoute';

  static _i50.PageInfo page = _i50.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<KycPromptRouteArgs>();
      return _i30.KycPromptScreen(
        key: args.key,
        showSkipButton: args.showSkipButton,
        title: args.title,
        subtitle: args.subtitle,
        isEditMode: args.isEditMode,
      );
    },
  );
}

class KycPromptRouteArgs {
  const KycPromptRouteArgs({
    this.key,
    required this.showSkipButton,
    this.title,
    this.subtitle,
    this.isEditMode = false,
  });

  final _i51.Key? key;

  final bool showSkipButton;

  final String? title;

  final String? subtitle;

  final bool? isEditMode;

  @override
  String toString() {
    return 'KycPromptRouteArgs{key: $key, showSkipButton: $showSkipButton, title: $title, subtitle: $subtitle, isEditMode: $isEditMode}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! KycPromptRouteArgs) return false;
    return key == other.key &&
        showSkipButton == other.showSkipButton &&
        title == other.title &&
        subtitle == other.subtitle &&
        isEditMode == other.isEditMode;
  }

  @override
  int get hashCode =>
      key.hashCode ^
      showSkipButton.hashCode ^
      title.hashCode ^
      subtitle.hashCode ^
      isEditMode.hashCode;
}

/// generated route for
/// [_i31.KycScreen]
class KycRoute extends _i50.PageRouteInfo<KycRouteArgs> {
  KycRoute({
    _i51.Key? key,
    bool? isEditMode = false,
    List<_i50.PageRouteInfo>? children,
  }) : super(
         KycRoute.name,
         args: KycRouteArgs(key: key, isEditMode: isEditMode),
         initialChildren: children,
       );

  static const String name = 'KycRoute';

  static _i50.PageInfo page = _i50.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<KycRouteArgs>(
        orElse: () => const KycRouteArgs(),
      );
      return _i31.KycScreen(key: args.key, isEditMode: args.isEditMode);
    },
  );
}

class KycRouteArgs {
  const KycRouteArgs({this.key, this.isEditMode = false});

  final _i51.Key? key;

  final bool? isEditMode;

  @override
  String toString() {
    return 'KycRouteArgs{key: $key, isEditMode: $isEditMode}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! KycRouteArgs) return false;
    return key == other.key && isEditMode == other.isEditMode;
  }

  @override
  int get hashCode => key.hashCode ^ isEditMode.hashCode;
}

/// generated route for
/// [_i32.LandingScreen]
class LandingRoute extends _i50.PageRouteInfo<void> {
  const LandingRoute({List<_i50.PageRouteInfo>? children})
    : super(LandingRoute.name, initialChildren: children);

  static const String name = 'LandingRoute';

  static _i50.PageInfo page = _i50.PageInfo(
    name,
    builder: (data) {
      return const _i32.LandingScreen();
    },
  );
}

/// generated route for
/// [_i33.LoginScreen]
class LoginRoute extends _i50.PageRouteInfo<void> {
  const LoginRoute({List<_i50.PageRouteInfo>? children})
    : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static _i50.PageInfo page = _i50.PageInfo(
    name,
    builder: (data) {
      return const _i33.LoginScreen();
    },
  );
}

/// generated route for
/// [_i34.ManageSubscriptionsScreen]
class ManageSubscriptionsRoute extends _i50.PageRouteInfo<void> {
  const ManageSubscriptionsRoute({List<_i50.PageRouteInfo>? children})
    : super(ManageSubscriptionsRoute.name, initialChildren: children);

  static const String name = 'ManageSubscriptionsRoute';

  static _i50.PageInfo page = _i50.PageInfo(
    name,
    builder: (data) {
      return const _i34.ManageSubscriptionsScreen();
    },
  );
}

/// generated route for
/// [_i35.MediaPreviewScreen]
class MediaPreviewRoute extends _i50.PageRouteInfo<MediaPreviewRouteArgs> {
  MediaPreviewRoute({
    _i51.Key? key,
    required List<_i53.MessageModel> messages,
    required int initialIndex,
    List<_i50.PageRouteInfo>? children,
  }) : super(
         MediaPreviewRoute.name,
         args: MediaPreviewRouteArgs(
           key: key,
           messages: messages,
           initialIndex: initialIndex,
         ),
         initialChildren: children,
       );

  static const String name = 'MediaPreviewRoute';

  static _i50.PageInfo page = _i50.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<MediaPreviewRouteArgs>();
      return _i35.MediaPreviewScreen(
        key: args.key,
        messages: args.messages,
        initialIndex: args.initialIndex,
      );
    },
  );
}

class MediaPreviewRouteArgs {
  const MediaPreviewRouteArgs({
    this.key,
    required this.messages,
    required this.initialIndex,
  });

  final _i51.Key? key;

  final List<_i53.MessageModel> messages;

  final int initialIndex;

  @override
  String toString() {
    return 'MediaPreviewRouteArgs{key: $key, messages: $messages, initialIndex: $initialIndex}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! MediaPreviewRouteArgs) return false;
    return key == other.key &&
        const _i54.ListEquality<_i53.MessageModel>().equals(
          messages,
          other.messages,
        ) &&
        initialIndex == other.initialIndex;
  }

  @override
  int get hashCode =>
      key.hashCode ^
      const _i54.ListEquality<_i53.MessageModel>().hash(messages) ^
      initialIndex.hashCode;
}

/// generated route for
/// [_i36.MyGroupScreen]
class MyGroupRoute extends _i50.PageRouteInfo<void> {
  const MyGroupRoute({List<_i50.PageRouteInfo>? children})
    : super(MyGroupRoute.name, initialChildren: children);

  static const String name = 'MyGroupRoute';

  static _i50.PageInfo page = _i50.PageInfo(
    name,
    builder: (data) {
      return const _i36.MyGroupScreen();
    },
  );
}

/// generated route for
/// [_i37.NotificationSettingsScreen]
class NotificationSettingsRoute extends _i50.PageRouteInfo<void> {
  const NotificationSettingsRoute({List<_i50.PageRouteInfo>? children})
    : super(NotificationSettingsRoute.name, initialChildren: children);

  static const String name = 'NotificationSettingsRoute';

  static _i50.PageInfo page = _i50.PageInfo(
    name,
    builder: (data) {
      return const _i37.NotificationSettingsScreen();
    },
  );
}

/// generated route for
/// [_i38.OnBoardingScreen]
class OnBoardingRoute extends _i50.PageRouteInfo<void> {
  const OnBoardingRoute({List<_i50.PageRouteInfo>? children})
    : super(OnBoardingRoute.name, initialChildren: children);

  static const String name = 'OnBoardingRoute';

  static _i50.PageInfo page = _i50.PageInfo(
    name,
    builder: (data) {
      return const _i38.OnBoardingScreen();
    },
  );
}

/// generated route for
/// [_i39.OnBoardingScreen1]
class OnBoardingRoute1 extends _i50.PageRouteInfo<void> {
  const OnBoardingRoute1({List<_i50.PageRouteInfo>? children})
    : super(OnBoardingRoute1.name, initialChildren: children);

  static const String name = 'OnBoardingRoute1';

  static _i50.PageInfo page = _i50.PageInfo(
    name,
    builder: (data) {
      return const _i39.OnBoardingScreen1();
    },
  );
}

/// generated route for
/// [_i40.OtpVerificationScreen]
class OtpVerificationRoute extends _i50.PageRouteInfo<void> {
  const OtpVerificationRoute({List<_i50.PageRouteInfo>? children})
    : super(OtpVerificationRoute.name, initialChildren: children);

  static const String name = 'OtpVerificationRoute';

  static _i50.PageInfo page = _i50.PageInfo(
    name,
    builder: (data) {
      return const _i40.OtpVerificationScreen();
    },
  );
}

/// generated route for
/// [_i41.PrivacyPermissionsScreen]
class PrivacyPermissionsRoute extends _i50.PageRouteInfo<void> {
  const PrivacyPermissionsRoute({List<_i50.PageRouteInfo>? children})
    : super(PrivacyPermissionsRoute.name, initialChildren: children);

  static const String name = 'PrivacyPermissionsRoute';

  static _i50.PageInfo page = _i50.PageInfo(
    name,
    builder: (data) {
      return const _i41.PrivacyPermissionsScreen();
    },
  );
}

/// generated route for
/// [_i42.ProfileScreen]
class ProfileRoute extends _i50.PageRouteInfo<void> {
  const ProfileRoute({List<_i50.PageRouteInfo>? children})
    : super(ProfileRoute.name, initialChildren: children);

  static const String name = 'ProfileRoute';

  static _i50.PageInfo page = _i50.PageInfo(
    name,
    builder: (data) {
      return const _i42.ProfileScreen();
    },
  );
}

/// generated route for
/// [_i43.ReportProblemScreen]
class ReportProblemRoute extends _i50.PageRouteInfo<void> {
  const ReportProblemRoute({List<_i50.PageRouteInfo>? children})
    : super(ReportProblemRoute.name, initialChildren: children);

  static const String name = 'ReportProblemRoute';

  static _i50.PageInfo page = _i50.PageInfo(
    name,
    builder: (data) {
      return const _i43.ReportProblemScreen();
    },
  );
}

/// generated route for
/// [_i44.ResetPasswordScreen]
class ResetPasswordRoute extends _i50.PageRouteInfo<void> {
  const ResetPasswordRoute({List<_i50.PageRouteInfo>? children})
    : super(ResetPasswordRoute.name, initialChildren: children);

  static const String name = 'ResetPasswordRoute';

  static _i50.PageInfo page = _i50.PageInfo(
    name,
    builder: (data) {
      return const _i44.ResetPasswordScreen();
    },
  );
}

/// generated route for
/// [_i45.SetNewPasswordScreen]
class SetNewPasswordRoute extends _i50.PageRouteInfo<SetNewPasswordRouteArgs> {
  SetNewPasswordRoute({
    _i51.Key? key,
    required String email,
    required String resetCode,
    List<_i50.PageRouteInfo>? children,
  }) : super(
         SetNewPasswordRoute.name,
         args: SetNewPasswordRouteArgs(
           key: key,
           email: email,
           resetCode: resetCode,
         ),
         initialChildren: children,
       );

  static const String name = 'SetNewPasswordRoute';

  static _i50.PageInfo page = _i50.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SetNewPasswordRouteArgs>();
      return _i45.SetNewPasswordScreen(
        key: args.key,
        email: args.email,
        resetCode: args.resetCode,
      );
    },
  );
}

class SetNewPasswordRouteArgs {
  const SetNewPasswordRouteArgs({
    this.key,
    required this.email,
    required this.resetCode,
  });

  final _i51.Key? key;

  final String email;

  final String resetCode;

  @override
  String toString() {
    return 'SetNewPasswordRouteArgs{key: $key, email: $email, resetCode: $resetCode}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! SetNewPasswordRouteArgs) return false;
    return key == other.key &&
        email == other.email &&
        resetCode == other.resetCode;
  }

  @override
  int get hashCode => key.hashCode ^ email.hashCode ^ resetCode.hashCode;
}

/// generated route for
/// [_i46.SplashScreen]
class SplashRoute extends _i50.PageRouteInfo<void> {
  const SplashRoute({List<_i50.PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static _i50.PageInfo page = _i50.PageInfo(
    name,
    builder: (data) {
      return const _i46.SplashScreen();
    },
  );
}

/// generated route for
/// [_i47.VerifyPhoneNumberScreen]
class VerifyPhoneNumberRoute
    extends _i50.PageRouteInfo<VerifyPhoneNumberRouteArgs> {
  VerifyPhoneNumberRoute({
    _i51.Key? key,
    bool? isFromProfile = false,
    List<_i50.PageRouteInfo>? children,
  }) : super(
         VerifyPhoneNumberRoute.name,
         args: VerifyPhoneNumberRouteArgs(
           key: key,
           isFromProfile: isFromProfile,
         ),
         initialChildren: children,
       );

  static const String name = 'VerifyPhoneNumberRoute';

  static _i50.PageInfo page = _i50.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<VerifyPhoneNumberRouteArgs>(
        orElse: () => const VerifyPhoneNumberRouteArgs(),
      );
      return _i47.VerifyPhoneNumberScreen(
        key: args.key,
        isFromProfile: args.isFromProfile,
      );
    },
  );
}

class VerifyPhoneNumberRouteArgs {
  const VerifyPhoneNumberRouteArgs({this.key, this.isFromProfile = false});

  final _i51.Key? key;

  final bool? isFromProfile;

  @override
  String toString() {
    return 'VerifyPhoneNumberRouteArgs{key: $key, isFromProfile: $isFromProfile}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! VerifyPhoneNumberRouteArgs) return false;
    return key == other.key && isFromProfile == other.isFromProfile;
  }

  @override
  int get hashCode => key.hashCode ^ isFromProfile.hashCode;
}

/// generated route for
/// [_i48.VideoCallScreen]
class VideoCallRoute extends _i50.PageRouteInfo<void> {
  const VideoCallRoute({List<_i50.PageRouteInfo>? children})
    : super(VideoCallRoute.name, initialChildren: children);

  static const String name = 'VideoCallRoute';

  static _i50.PageInfo page = _i50.PageInfo(
    name,
    builder: (data) {
      return const _i48.VideoCallScreen();
    },
  );
}

/// generated route for
/// [_i49.YourGroupsScreen]
class YourGroupsRoute extends _i50.PageRouteInfo<void> {
  const YourGroupsRoute({List<_i50.PageRouteInfo>? children})
    : super(YourGroupsRoute.name, initialChildren: children);

  static const String name = 'YourGroupsRoute';

  static _i50.PageInfo page = _i50.PageInfo(
    name,
    builder: (data) {
      return const _i49.YourGroupsScreen();
    },
  );
}
