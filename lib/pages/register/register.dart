import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:loginregister/pages/register/register_info.dart';
import 'package:loginregister/service/http_request.dart';

class Register extends StatelessWidget {
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

  register(userName, password, phoneNumber) {
    Map<String, dynamic> params = {
      "userName" : userName,
      "password" : password,
      "phoneNumber" : phoneNumber
    };
    HttpRequest().request("user/register", params: params, method: "post").then((res) {
      print('$res');
    });
  }
}
