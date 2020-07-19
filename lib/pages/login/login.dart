import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:loginregister/pages/login/login_info.dart';
import 'package:loginregister/service/http_request.dart';
import 'package:loginregister/utils/toast.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  /// 验证完成之后进行登录
  void _onLogin(String userName, String password) {
//      showDialog(context: context, builder: (ctx)=> new AlertDialog(
//        content:  new Text('$userName $password'),
//        actions: <Widget>[
//          FlatButton(child: Text('确定'), onPressed: null),
//          FlatButton(child: Text('取消'), onPressed: null),
//        ],
//      ));
    Map<String, dynamic> data = {
      "user_name": userName,
      "password": password
    };
    HttpRequest().request("user/login", method: "post", data: data, inter: InterceptorsWrapper(
      onError: (error) {
        DYXToast(context).showToast(error.response.data['message']);
      }
    )).then((res) {
      print('$res');
      DYXToast(context).showToast("登录成功");
    });
    print('$userName  +++  $password');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
//          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              // 退出按钮
              buildExit(context),
              Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 50),
                      // 登录的一些信息
                      Card(child: LoginInfoPage(this._onLogin)),
                      SizedBox(height: 20),
                      //第三方登录提示字
                      buildOtherLoginText(),
                      SizedBox(height: 20),
                      // 第三方登录
                      buildOtherLogin(context)
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }

  /// 退出
  Container buildExit(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20, left: 5),
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.clear),
            onPressed: () => Navigator.pop(context),
          )
        ],
      ),
    );
  }

  /// 第三方登录的提示信息
  Row buildOtherLoginText() {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Divider(
            thickness: 1,
            color: Colors.black12,
          ),
        ),
        Text(
          '第三方登录方式',
          style: TextStyle(color: Colors.grey),
        ),
        Expanded(
          flex: 1,
          child: Divider(
            thickness: 1,
            color: Colors.black12,
          ),
        ),
      ],
    );
  }

  /// 第三方登录
  Container buildOtherLogin(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          InkWell(
            child: CircleAvatar(
              backgroundImage: AssetImage("images/qq.jpg"),
            ),
            onTap: () => Navigator.pushNamed(context, "/qq_login"),
          ),
          InkWell(
            child: CircleAvatar(
              backgroundImage: AssetImage("images/wx.jpg"),
            ),
            onTap: () => Navigator.pushNamed(context, "/qq_login"),
          ),
          InkWell(
            child: CircleAvatar(
              backgroundImage: AssetImage("images/wb.jpg"),
            ),
            onTap: () => Navigator.pushNamed(context, "/qq_login"),
          )
        ],
      ),
    );
  }
}
