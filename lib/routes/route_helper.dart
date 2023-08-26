import 'package:wsilny/views/authscreen/register.dart';
import 'package:wsilny/views/authscreen/signin.dart';
import 'package:wsilny/views/authscreen/update.dart';
import 'package:wsilny/views/authscreen/updatepassword.dart';
import 'package:wsilny/views/bottomsheet/bottombar.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:wsilny/views/homescreen/success.dart';
import 'package:wsilny/views/msgs/msgsdetails.dart';
import 'package:wsilny/views/msgs/msgslist.dart';
import 'package:wsilny/views/orderscreen/orderdetails.dart';
import 'package:wsilny/views/orderscreen/orders.dart';
import 'package:wsilny/views/splash.dart';
import 'package:wsilny/views/user/settings.dart';
import 'package:wsilny/views/user/user.dart';
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
  static const String chatPage = "/chat-page";


  static String getInitial()=> initial;
  static String getOrder(int pageId)=>'$orderDetails?pageId=$pageId';
  static String getMsgDetails(int pageId)=>'$msgDetails?pageId=$pageId';
  static String getChatPage(int pageId)=>'$chatPage?pageId=$pageId';
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

    GetPage(name: chatPage, page: (){
      var pageId = Get.parameters['pageId'];
      return ChatPage(id: pageId!,);
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