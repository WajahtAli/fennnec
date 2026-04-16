class SocketEvents {
  // 🔹 Messages
  static const newDirectMessage = 'direct:message:new';
  static const newGroupMessage = 'group:message:new';
  static const messagesReaction = 'direct:message:reaction';
  static const groupMessagesReaction = 'group:message:reaction';

  // 🔹 Typing
  static const directTyping = 'direct:typing';
  static const groupTyping = 'group:typing';

  // 🔹 Chat Updates
  static const chatUpdated1 = 'chatAndCallsUpdated';
  static const chatUpdated2 = 'chat-updated';
  static const chatUpdated3 = 'chat-updates';
  static const unifiedChatsUpdated = 'unified:chats:updated';
  static const unifiedChatsList = 'unified:chats:list';
  static const unifiedChatsCount = 'unified:chats:count';

  // 🔹 Calls
  static const callUpdated1 = 'call-updated';
  static const callUpdated2 = 'call-updates';

  // 🔹 Groups & Pokes
  static const groupsAllNew = 'groups:all:new';
  static const groupsSettingsUpdated = 'groups:settings:updated';
  static const pokeStartedChatIndividual = 'pokes:started-chat:individual';

  // 🔹 Likes
  static const peopleWhoLikedYouCount = 'groups:people-who-liked-you:count';
  static const peopleWhoLikedYouList = 'groups:people-who-liked-you:list';

  // 🔹 Emit Events (optional naming clarity)
  static const sendDirectMessage = 'direct:message:send';
  static const sendGroupMessage = 'group:message:send';

  // deactivate
  static const deactivateAccount = 'user:account:deactivated';

  // 🔹 Auth
  static const pendingGroupInvitations = 'auth:pending-group-invitations';
}
