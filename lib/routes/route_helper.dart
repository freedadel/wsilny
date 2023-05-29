import 'package:wassilni/views/authscreen/register.dart';
import 'package:wassilni/views/authscreen/signin.dart';
import 'package:wassilni/views/authscreen/update.dart';
import 'package:wassilni/views/authscreen/updatepassword.dart';
import 'package:wassilni/views/bottomsheet/bottombar.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:wassilni/views/homescreen/success.dart';
import 'package:wassilni/views/msgs/msgsdetails.dart';
import 'package:wassilni/views/msgs/msgslist.dart';
import 'package:wassilni/views/orderscreen/orderdetails.dart';
import 'package:wassilni/views/orderscreen/orders.dart';
import 'package:wassilni/views/splash.dart';
import 'package:wassilni/views/user/settings.dart';
import 'package:wassilni/views/user/user.dart';
import '../views/authscreen/forgotpassword.dart';
import '../views/authscreen/registerdriver.dart';
import '../views/authscreen/usertype.dart';
import '../views/msgs/chatpage.dart';




class RouteHelper{
  static const String initial = "/";
  static const String allMsgs = "/allmsgs";
  static const String register = "/register";
  static const String registerDriver = "/register-driver";
  static const String usertype = "/usertype";
  static const String login = "/login";
  static const String updatePassword = "/updatePassword";
  static const String profile = "/profile";
  static const String orders = "/orders";
  static const String msgDetails = "/msg-details";
  static const String orderDetails = "/order-details";
  static const String orderDone = "/order-done";
  static const String settings = "/settings";
  static const String pickAddress = "/pick-address";
  static const String updateUser = "/update-user";
  static const String forgot = "/forgot";


  static String getInitial()=> initial;
  static String getOrder(int pageId)=>'$orderDetails?pageId=$pageId';
  static String getMsgDetails(int pageId)=>'$msgDetails?pageId=$pageId';
  static String getRegister()=>register;
  static String getRegisterDriver()=>registerDriver;
  static String getUsertype()=>usertype;
  static String getLogin()=>login;
  static String getUpdatePassword()=>updatePassword;
  static String getForgot()=>forgot;
  static String getProfile()=>profile;
  static String getOrders()=>orders;
  static String getMsgs()=>allMsgs;
  static String getOrderDone()=>orderDone;
  static String getSettings()=>settings;
  static String getPickAddress()=>pickAddress;
  static String getUpdateUser()=>updateUser;

  static List<GetPage> routes = [
  GetPage(name: initial, page: ()=>const Bottomhome()),
    GetPage(name: allMsgs, page: ()=>const ChatPage(id: '1',)),
    GetPage(name: updatePassword, page: ()=>const UpdatePassword()),

    GetPage(name: register, page: ()=>const Register()),
    GetPage(name: registerDriver, page: ()=>const Registerdriver()),
    GetPage(name: usertype, page: ()=>const Usertype()),
    GetPage(name: login, page: ()=>const SignIn()),
    GetPage(name: forgot, page: ()=>const Forgot()),
    GetPage(name: profile, page: ()=>const User()),
    GetPage(name: orders, page: ()=>const Orders()),
    GetPage(name: orderDone, page: ()=>const Succsess()),
    GetPage(name: settings, page: ()=>const Settings()),
    GetPage(name: updateUser, page: ()=>const Update()),


    GetPage(name: msgDetails, page: (){
      var pageId = Get.parameters['pageId'];
      return MessageDetails(pageId: int.parse(pageId!));
    },
      transition: Transition.fadeIn,
    ),



    GetPage(name: orderDetails, page: () {
      var pageId = Get.parameters['pageId'];
      return OrderDetails(pageId: int.parse(pageId!));
    },
      transition: Transition.fadeIn,
    ),






  ];

}