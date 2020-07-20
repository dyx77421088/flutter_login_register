import 'package:flutter/material.dart';
import 'package:loginregister/pages/login/login.dart';
import 'pages/my_home/my_home.dart';
import 'pages/routes/routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  //配置路由

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
      onGenerateRoute: onGenerateRoute,
      onUnknownRoute: onUnknownRoute,
//      初始化路由
      initialRoute: LoginPage.route,
    );
  }
  //

}

