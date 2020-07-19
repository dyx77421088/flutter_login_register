import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:loginregister/my_ui/my_text_form_field.dart';
import 'package:loginregister/service/http_request.dart';
import 'package:loginregister/utils/toast.dart';

typedef OnRegisterCallback(String userName, String password, String phone, String code);

class RegisterInfo extends StatefulWidget {
  final OnRegisterCallback onRegister;

  RegisterInfo(this.onRegister);

  @override
  _RegisterInfoState createState() => _RegisterInfoState();
}

class _RegisterInfoState extends State<RegisterInfo> {
  //表单中的key
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //用户名的控制器
  TextEditingController _userController = TextEditingController();

  //密码的控制器
  TextEditingController _pwdController = TextEditingController();

  //确认密码的控制器
  TextEditingController _rePwdController = TextEditingController();

  //手机号的控制器
  TextEditingController _phoneController = TextEditingController();

  //验证码的控制器
  TextEditingController _codeController = TextEditingController();

  //单击了登录按钮后的监听，
  void onLogin() {
    //先验证输入是否合法，合法执行后面的
    if (_formKey.currentState.validate()) {
      widget.onRegister(
          _userController.text, _pwdController.text, _phoneController.text, _codeController.text);
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
            buildUserName(),
            buildPassword(),
            buildRePassword(),
            buildPhoneNumber(),
            buildCode(),
            SizedBox(height: 20),
            buildRegisterButton(),
          ],
        ),
      ),
    );
  }

  /// 用户名输入框
  MyTextFormField buildUserName() => MyTextFormField(
      labelText: "用户名",
      controller: _userController,
      hintText: "请输入用户名",
      validator: (value) {
        if(value.trim().length < 2) {
          return "用户名的长度需要大于等于2位";
        }
        return null;
      },
    );

  /// 密码输入框
  MyTextFormField buildPassword() => MyTextFormField(
    labelText: "密码",
    isPassword: true,
    controller: _pwdController,
    hintText: "请输入密码",
    leftIcon: Icon(Icons.lock),
  );

  /// 确认密码输入框
  MyTextFormField buildRePassword() {
    return MyTextFormField(
      labelText: "确认密码",
      isPassword: true,
      controller: _rePwdController,
      hintText: "请再次输入密码",
      leftIcon: Icon(Icons.lock),
      validator: (value) {
        if (value.trim().length < 6) {
          return "需要大于等于6个字符";
        } else if (_rePwdController.text != _pwdController.text) {
          return "两次输入不正确";
        }
        return null;
      },
    );
  }

  /// 手机号输入框
  MyTextFormField buildPhoneNumber() {
    return MyTextFormField(
      labelText: "手机号",
      isPassword: false,
      controller: _phoneController,
      hintText: "手机号",
      leftIcon: Icon(Icons.phone),
      validator: (value) {
        RegExp exp = RegExp(
            r'^((13[0-9])|(14[0-9])|(15[0-9])|(166)|(17[0-9])|(18[0-9])|(19[0-9]))\d{8}$');
        bool matched = exp.hasMatch(value);
        if (!matched) return "手机号格式不正确";
        return null;
      },
    );
  }

  /// 验证码输入框
  Widget buildCode() {
    return MyTextFormField(
      maxLength: 6,
      hintText: "请输入验证码",
      leftIcon: Icon(Icons.code),
      suffixIcon: FlatButton(child: Text(countTime <= 0 ? '获得验证码' : "$countTime秒后重试"),
        onPressed: countTime <= 0 ? sendCode : null,),
      controller: _codeController,
//      validator: (value) {
//        if(value != code) {
//          return "验证码不正确";
//        }
//        return null;
//      },
    );
  }

  /// 发送验证码
  void sendCode() {
    RegExp exp = RegExp(
        r'^((13[0-9])|(14[0-9])|(15[0-9])|(166)|(17[0-9])|(18[0-9])|(19[0-9]))\d{8}$');
    String phoneNumber = _phoneController.text;
    bool matched = exp.hasMatch(phoneNumber);
    if (!matched) {
      DYXToast(context).showToast("手机号格式错误");
      return;
    }
    print(phoneNumber);
    Map<String, dynamic> data = {
      "phone_number": phoneNumber
    };
    // 发送手机号获得验证码
    HttpRequest().request("user/sendCode", method: "post", data: data, inter: InterceptorsWrapper(
        onError: (response) {
          print("错误的");
          print(response.response.statusCode);
          print(response.response.data);
        }
    )).then((res) {
      print('$res');
      startTimer();
    });
  }

  var countTime = 0;
  Timer timer;
  String code;
  /// 计时器
  void startTimer() {
//    // 随机6位验证码
//    code = Random().nextInt(1000000).toString();
//    print(code);

    countTime = 60;

    final call = (_) {
      if(countTime <= 0) {
        timer.cancel();
      } else {
        setState(() {
          countTime -= 1;
        });
      }
    };
    timer = Timer.periodic(Duration(seconds: 1), call);
  }

  /// 注册按钮
  Widget buildRegisterButton() => Container(
    width: double.infinity,
    child: FlatButton(
      child: Text('注册'),
      onPressed: this.onLogin,
      color: Colors.blue,
      textColor: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
    ),
  );

  @override
  void dispose() {
    super.dispose();
    if (timer != null) {
      timer.cancel();
    }
  }
}
