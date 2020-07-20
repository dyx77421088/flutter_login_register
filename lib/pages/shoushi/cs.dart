import 'package:flutter/material.dart';
import 'package:loginregister/pages/shoushi/setting_page.dart';
import 'package:loginregister/pages/shoushi/verify_page.dart';

class MainPage extends StatelessWidget {
  static final route = "/cs";
  void _routeToPage(BuildContext context,Widget page) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context){
          return page;
        })
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Gesture Recoginition"),),
        body: Builder(
            builder: (context) {
              return Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    MaterialButton(
                        child: Container(
                          height: 60,
                          child: Center(
                            child: Text(
                              "Setting Gesture",
                              style: TextStyle(fontSize: 20,color: Colors.black),
                            ),
                          ),
                        ),
                        onPressed: () => _routeToPage(context,SettingPage())
                    ),
                    MaterialButton(
                        child: Container(
                          height: 60,
                          child: Center(
                            child: Text(
                              "Verification Gesture",
                              style: TextStyle(fontSize: 20,color: Colors.black),
                            ),
                          ),
                        ),
                        onPressed: () => _routeToPage(context,VerifyPage())
                    ),
                  ],
                ),
              );
            }
        ),
      ),
    );
  }
}