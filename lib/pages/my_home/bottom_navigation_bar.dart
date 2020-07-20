import 'package:flutter/material.dart';
import 'package:loginregister/pages/home/home.dart';
import 'package:loginregister/pages/personal/person.dart';

List<BottomNavigationBarItem> bottomNavigation = [
  BottomNavigationBarItem(title: Text('主页'), icon: Icon(Icons.home)),
  BottomNavigationBarItem(title: Text('第二个'), icon: Icon(Icons.access_alarm)),
  BottomNavigationBarItem(title: Text('个人中心'), icon: Icon(Icons.person)),
];

List<Widget> pages = [
  HomePage(),
  HomePage(),
  PersonalPage(),
];
