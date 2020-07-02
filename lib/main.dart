import 'package:flutter/material.dart';
import 'package:gesture_recognition/gesture_view.dart';
import 'package:loginregister/pages/register/register.dart';
import 'package:loginregister/pages/shoushi/cs.dart';
import 'pages/login/login.dart';
import 'pages/login/qq_login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  //配置路由
  final routes = {
    "/login": (context) => LoginPage(),
    "/qq_login": (context) => QQLoginPage(),
    "/cs": (context) => MainPage(),
    "/register": (context) => Register(),
  };
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
      onGenerateRoute: _onGenerateRoute,
      initialRoute: "/login",
    );
  }
  //
  Route _onGenerateRoute(RouteSettings settings) {
    //获得路由名称
    final name = settings.name;
    //获得路由对应的function
    final Function function = this.routes[name];

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
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GlobalKey<GestureState> gestureStateKey = GlobalKey();

//  onYanz() {
//
//  GestureView(
//    key: this.gestureStateKey,
//    size: MediaQuery.of(context).size.width*0.8,
//    selectColor: Colors.blue,
//    onPanUp: (List<int> items) {
//      analysisGesture(items);
//    },
//    onPanDown: () {
//      gestureStateKey.currentState.selectColor = Colors.blue;
//      setState(() {
//        status = 0;
//      });
//    },
//    )
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('首页'),),
      body: RaisedButton(
        child: Text('登录'),
        onPressed: ()=>Navigator.pushNamed(context, "/login"),
      ),
    );
  }

}
