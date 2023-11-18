class EndPoints {
  static const String baseUrl = 'https://dashboard.stepoutnet.com/api/';
  static const String googleMapsBaseUrl = 'https://maps.googleapis.com';
  static const String imageUrl = 'https://dashboard.stepoutnet.com/';
  static const String apiKey =
      's7xrprFdw4G0F21rfLyD4TaBkjVJYgwGfI3y355yRnjw9zOggruX30eToVWvsASerert';
  static const String topic = 'stepOut';
  static const String logIn = 'login';
  static const String forgetPassword = 'resetPassword/email';
  static const String checkMailForResetPassword = 'resetPassword/checkCode';
  static const String resetPassword = 'resetPassword/newPassword';
  static changePassword(id) => 'client/$id';
  static const String register = 'client';
  static const String resend = 'email/verification';
  static const String verifyEmail = 'check/verificationCode';
  static getProfile(id) => 'client/$id';
  static deleteAcc(id) => 'client/$id';
  static updateProfile(id) => 'client/$id';
  static const String search = 'check/verificationCode';
  static getFavourites(id) => 'favorites/$id';
  static const String postFavourite = 'favorite';
  static const String banners = 'banner';
  static const String news = 'news';
  static getItemDetails(id) => 'favorites/$id';
  static const String category = 'category';
  static const String offers = 'offer';
  static const String aboutUs = 'about_us';
  static const String setting = 'setting';
  static const String notifications = 'notification/notification';
  static readNotification(id) => 'notification/read';
  static deleteNotification(id) => 'notification/read';
  static const String sendRate = 'rate/send';

  /// maps
  static const String GEOCODE_URI = '/maps/api/geocode/';
  static const String Autocomplete = '/maps/api/place/autocomplete/';
//https://maps.googleapis.com/maps/api/geocode/json?latlng=40.714224,-73.961452&key=AIzaSyB_l2x6zgnLTF4MKxX3S4Df9urLN6vLNP0
//'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=n,&key=AIzaSyB_l2x6zgnLTF4MKxX3S4Df9urLN6vLNP0
}
