class Apis {
  static final String baseURL = 'http://192.168.1.10:8000';
  static final String root = '$baseURL/api';

  //auth
  static String getSignUpUrl = '$root/register';
  static String getSignInUrl = '$root/login';
  static String getLogoutUrl = '$root/logout';
  static String getSignInSocialUrl = '$root/registerSocial';

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
}
