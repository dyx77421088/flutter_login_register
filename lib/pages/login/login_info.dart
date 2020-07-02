import 'package:flutter/material.dart';
import 'package:loginregister/my_ui/my_text_form_field.dart';

typedef OnLoginCallback(String userName, String password);


class LoginInfoPage extends StatefulWidget {
  final OnLoginCallback onLogin;

  LoginInfoPage(this.onLogin);

  @override
  _LoginInfoPageState createState() => _LoginInfoPageState();
}

class _LoginInfoPageState extends State<LoginInfoPage> {
  //表单中的key
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  //用户名的控制器
  TextEditingController _userController = TextEditingController();
  //密码的控制器
  TextEditingController _pwdController = TextEditingController();

  //单击了登录按钮后的监听，
  void onLogin() {
    //先验证输入是否合法，合法执行后面的
    if(_formKey.currentState.validate()) {
      widget.onLogin(_userController.text, _pwdController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            MyTextFormField(labelText: "用户名", controller: _userController,hintText: "请输入手机号或用户名",),
            MyTextFormField(labelText: "密码", isPassword: true, controller: _pwdController,hintText: "请输入密码",leftIcon: Icon(Icons.lock),),
            SizedBox(height: 20),
            Container(
              width: double.infinity,
              child: FlatButton(
                child: Text('登录'),
                onPressed: this.onLogin,
                color: Colors.blue,
                textColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                InkWell(
                  child: Text('忘记密码?', style: Theme.of(context).textTheme.caption,),
                ),
                InkWell(
                  child: Text('现在注册'),
                  onTap: () => Navigator.pushNamed(context, "/register"),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
