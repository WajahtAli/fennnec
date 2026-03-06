class AppConstants {
  //?API Constants
  //when we are on a live environment
  // static const baseUrl = '';

  //when we are on a testing environment
  static const baseUrl = 'https://api.fennecapp.io/';
  static const createAccount = 'auth/create-account';
  static const verifyCode = 'auth/verify-code';
  static const updateProfile = 'auth/update-profile';
  static const uploadSingle = 'upload/single';
  static const userPrompts = 'prompts';
  static const login = 'auth/login';
  static const loginGoogle = 'auth/auth-google';
  static const loginApple = 'auth/auth-apple';
  static const logout = 'auth/logout';
  static const reqPasswordReset = 'auth/request-password-reset';
  static const verifyResetCode = 'auth/verify-reset-code';
  static const resetPassword = 'auth/reset-password';
  static const fetchGroupInvitations = 'auth/pending-group-invitations';
  static const groupsAll = 'groups/all';
  static const resetVerificationCode = 'auth/resend-verification-code';
  static const groupsMembers = 'groups/members';
  static const groupInvite = 'groups/invite';
  static const groupById = 'groups/';
  static const groupByQr = 'groups/qr';
  static const refreshToken = 'auth/refresh-token';
  static const checkToken = 'auth/check-token';
  static const updatePrompt = 'prompts/';
  static const requestContactChange = 'auth/request-contact-change';
  static const verifyContactChange = 'auth/verify-contact-change';
  static const changePassword = 'auth/change-password';
  static const acceptGroupRequest = 'groups/accept-decline';
  static const chatAndCalls = 'groups/accept-decline';
  static const contactSupport = 'help-support/contact-support';
  static const fetchFaqs = 'help-support/faqs';
  static const reportProblem = 'help-support/report-problem';
  static const fetchPokeProducts = 'pokes/products';

  //!Agora Constants
  static const agoraAppId = "e02d6c955f5947f0a671b1b2dbb67514";
  static const agoraAppCertificate = "31748e63f9ff4d1188102acce4ee0e3a";

  static const googleClientId =
      "317592885652-v764tpb76ddus1rof26t55upqm7pamgm.apps.googleusercontent.com";

  //!Notification Constants
  static const String remindMeLater = "remind_me_later";
  static const String turnOffScheduler = "turn_off_scheduler";
  static const int notificationIntervalInMins = 15;
}
