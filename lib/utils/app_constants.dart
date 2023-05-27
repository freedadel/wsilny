import 'language.dart';

class AppConstants{
  static const String APP_NAME = "Wsilny";
  static const int APP_VSERSION = 1;
  static const String BASE_URL = "http://admin.wsilny.com/";

  //auth route
  static const String REGISTRATION_URI = "api/auth/register";
  static const String LOGIN_URI = "api/auth/login";
  static const String USER_INFO_URI = "api/user-info";

  static const String ALL_MESSAGES_URI = "api/all-messages";

  static const String STORE_MESSAGE_URI = "api/message-store";
  static const String STORE_ORDER_URI = "api/order-store";
  static const String STORE_ADDRESS_URI = "api/address-store";
  static const String ADD_ADDRESS_URI = "api/add-address";
  static const String STORE_PET_URI = "api/pet-store";
  static const String STORE_PET_ADOPT_URI = "api/pet-for-adopt-store";
  static const String REQUEST_ADOPT_URI = "api/request-adopt-store";
  static const String STORE_MY_PET_URI = "api/my-pet-store";
  static const String UPDATE_USER_URI = "api/updateUser";

  static const String GET_ADDRESS_URI = "api/get-address";
  static const String GET_PETS_URI = "api/get-pets";
  static const String GET_PETS_CITY_URI = "api/get-pets-city";
  static const String GET_MY_PETS_URI = "api/get-my-pets";
  static const String GET_MY_REQUESTS_URI = "api/get-my-requests";
  static const String GET_MY_REQUESTS_IN_URI = "api/get-my-requests-in";

  static const String BOOKING_URI = "api/booking";
  static const String POPULAR_PRODUCT_URI = "api/products";
  static const String RECOMENDED_PRODUCT_URI = "api/recommended";
  static const String CLINICS_URI = "api/clinics";
  static const String CLINICS_CITY_URI = "api/clinics-city";
  static const String ORDERS_URI = "api/orders";
  static const String DRIVER_MESSAGES_URI = "api/driver-messages";
  static const String CUSTOMER_MESSAGES_URI = "api/customer-messages";
  static const String DETAILS_MESSAGES_URI = "api/get-details";
  static const String ADS_URI = "api/ads";
  static const String USER_ADDRESS = "user_address";
  static const String GEOCODE_URI = "api/geocode";
  static const String PRODUCTS_URI = "api/products";
  static const String BOOKINGS_URI = "api/bookings";
  static const String SERVICES_URI = "api/services";
  static const String IMAGES_URI = "img/clinics/";
  static const String ADS_IMAGES_URI = "img/ads/";
  static const String PETS_IMAGES_URI = "img/pets/";
  static const String PRODUCTS_IMAGES_URI = "img/items/";
  static const String USERS_IMAGES_URI = "img/users/";

  static const String CART_LIST = "cart-list";

  static const String TOKEN = "";
  static const String PHONE = "";
  static const String PASSWORD = "";
  static String USERNAME = "";
  static String PERMISSION = "";
  static String USER_ID = "";
  List<dynamic> MESSAGE_LIST = [];

  static const String LANGUAGE__LANGUAGE_CODE_KEY =
      'LANGUAGE__LANGUAGE_CODE_KEY';
  static const String LANGUAGE__COUNTRY_CODE_KEY = 'LANGUAGE__COUNTRY_CODE_KEY';
  static const String LANGUAGE__LANGUAGE_NAME_KEY =
      'LANGUAGE__LANGUAGE_NAME_KEY';
  static final Language defaultLanguage =
  Language(languageCode: 'ar', countryCode: 'DZ', name: 'Arabic');

  static final List<Language> psSupportedLanguageList = <Language>[
    Language(languageCode: 'en', countryCode: 'US', name: 'English'),
    Language(languageCode: 'ar', countryCode: 'DZ', name: 'Arabic'),
  ];
}