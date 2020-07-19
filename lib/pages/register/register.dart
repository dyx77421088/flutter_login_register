import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:loginregister/pages/register/register_info.dart';
import 'package:loginregister/service/http_request.dart';
import 'package:loginregister/utils/toast.dart';


class Register extends StatefulWidget{
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('注册'),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Card(
            child: RegisterInfo(this.register),
          ),
        )
      ),
    );
  }

  register(userName, password, phoneNumber, code) {
    Map<String, dynamic> data = {
      "user_name" : userName,
      "password" : password,
      "phone_number" : phoneNumber,
      "code" : code,
    };
    HttpRequest().request("user/insert", data: data, method: "post", inter: InterceptorsWrapper(
      onError: (error) {
        DYXToast(context).showToast(error.response.data['message']);
      }
    )).then((res) {
      print('$res');
      DYXToast(context).showToast("注册成功", color: Colors.black38);
    });
  }
}
