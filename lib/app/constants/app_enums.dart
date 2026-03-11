enum DiscountType { fixed, percentage }

enum AdOnType { free, range, paid }

enum PaymentMethodType { onlinePay, applePay, walletPay, tabby, notSelected }

enum SwipeResult { left, right, none }

enum InvitationStatus { pending, accepted, declined, landing }

enum SelectionType { single, multiple }

enum PokeType { floating, image, text, audio }

enum SubscriptionStatus { subscribed, unsubscribed }

enum CallType { audio, video }

enum MessageType { text, image, video, audio, file, location, contact }

enum CropType {
  square, // 1:1
  portrait, // 9:16
}

enum FindGroupScreenType { qrProfileCode, createGroup }
