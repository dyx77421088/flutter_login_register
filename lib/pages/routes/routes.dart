import 'package:flutter/material.dart';
import 'package:loginregister/pages/routes/un_known.dart';

import '../login/login.dart';
import '../login/qq_login.dart';
import '../shoushi/cs.dart';
import '../register/register.dart';

// 路由
final routes = {
  LoginPage.route: (context) => LoginPage(),
  QQLoginPage.route: (context) => QQLoginPage(),
  MainPage.route: (context) => MainPage(),
  Register.route: (context) => Register(),
};

///命名路由传参
Route onGenerateRoute(RouteSettings settings) {
  //获得路由名称
  final name = settings.name;
  //获得路由对应的function
  final Function function = routes[name];

  if(function != null) {
    //如果传参不为空，那么就把这个参数传过去
    if(settings.arguments != null) {
      return MaterialPageRoute(
          builder:(context) => function(context, arguments:settings.arguments)
      );
    } else {
      return MaterialPageRoute(
          builder:(context) => function(context)
      );
    }
  }
  return null;
}

///没找到后返回的界面
Route onUnknownRoute(_) {
  return MaterialPageRoute(
      builder: (_) {
        return UnKnown();
      }
  );
}