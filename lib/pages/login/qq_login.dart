import 'package:flutter/material.dart';
import 'package:flutter_qq/flutter_qq.dart';



class QQLoginPage extends StatefulWidget {
  static final route = "/qq_login";
  @override
  _QQLoginPageState createState() => _QQLoginPageState();
}

class _QQLoginPageState extends State<QQLoginPage> with SingleTickerProviderStateMixin{
  var _output;


  @override
  void initState() {
    super.initState();
    print('开始了！！！！！！！！！！！！！！！！！！！！！！！！');

  }

  Future<Null> _handleLogin() async {
    var t = await FlutterQq.registerQQ("101877325");
    try {
      var qqResult = await FlutterQq.login();
      var output;
      if (qqResult.code == 0) {
        output = "登录成功" + qqResult.response.toString();
      } else if (qqResult.code == 1) {
        output = "登录失败" + qqResult.message;
      } else {
        output = "用户取消";
      }
      setState(() {
        _output = output;
        print('$_output');
      });
    } catch (error) {
      print("flutter_plugin_qq_example:" + error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('qq登录'),
      ),
      body: Column(
        children: <Widget>[
            Text('${this._output}'),
            RaisedButton(child: Text('qq登录'), onPressed: _handleLogin,)
          ],
      )
    );
  }
}
