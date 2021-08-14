class Apis {
  static final String baseURL = 'http://192.168.1.10:8000';
  static final String root = '$baseURL/api';

  //auth
  static String getSignUpUrl = '$root/register';
  static String getSignInUrl = '$root/login';
  static String getLogoutUrl = '$root/logout';
  static String getSignInSocialUrl = '$root/registerSocial';
  static String postloginAndRegisterPhone = '$root/loginAndRegisterPhone';
  static String checkUserUrl = '$root/checkUser';
  static String postLoginPhoneUrl = '$root/loginPhone';

  //notify
  static String postNotificationUrl = '$root/sendNotification';
  static String saveNotificationUrl = '$root/saveNotification';

  //home
  static String getSlidersUrl = '$root/sliders';

  // static String getFoodsUrl = '$root/listfood';
  static String getRestaurantsUrl = '$root/listrestaurants';
  static String getUsersUrl = '$root/getuser';
  static String getAddressUrl = '$root/listaddress';
  static String getAddressUrl1 = '$root/address';

  static String getCardOrderUrl = '$root/getcardorder';

  static String getVoucherUrl = '$root/listdiscount';

  // restaurant
  static String getRestaurantUrl = '$root/listrestaurant';
  static String getFoodUrl = '$root/listfood';

  static String postAddCardUrl = '$root/addcardorder';
  static String getCardUrl = '$root/getcard';

  //order
  static String postOrderUrl = '$root/addorder';
  static String getOrderUrl = '$root/getOrder';
  static String getHistoryUrl = '$root/getHistory';
  static String getdraftOrderUrl = '$root/getdraftOrder';
  static String deleteDraftOrderUrl = '$root/deleteDraftOrder';

  //
  static String uploadImage = '$root/uploadImage';
  static String uploadAvatar = '$root/uploadAvatar';

  //proflie
  static String changeUsersUrl = '$root/changeUsers';
  static String changeNameUrl = '$root/changeName';
  static String changeDobUrl = '$root/changeDob';
  static String changeGenderUrl = '$root/changeGender';
  static String changeAvatarUrl = '$root/changeAvatar';

  // address
  static String addAddressUrl = '$root/addAddress';
  static String updateAddressUrl = '$root/updateAddress';
  static String deleteAddressUrl = '$root/deleteAddress';
  static String updateLocationUrl = '$root/updateLocation';
  static String getAddressFromIdUrl = '$root/getAddressFromId';
  //delivery
  static String getDeliveryUrl = '$root/getDelivery';
  static String receivedUrl = '$root/received';
  static String isDeliveryUrl = '$root/isDelivery';
  static String changeDeliveryUrl = '$root/changeDelivery';
  static String historyDeliveryUrl = '$root/historyDelivery';

  //review
  static String addReviewUrl = '$root/addReview';
}
