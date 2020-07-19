import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DYXToast {
  FlutterToast flutterToast;

  _getToast(message, {color, icon, fontColor=Colors.black}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: color ?? Colors.black38,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon == null ? Text(''):icon,
          SizedBox(
            width: 12.0,
          ),
          Text(message, style: TextStyle(color: fontColor),),
        ],
      ),
    );
  }

  DYXToast(StatefulElement context): flutterToast=FlutterToast(context);

  showToast(message, {gravity=ToastGravity.BOTTOM, Duration toastDuration, color=Colors.red}) {
    flutterToast.showToast(
      child: _getToast(message, color: color, fontColor: Colors.white),
      gravity: gravity,
      toastDuration: toastDuration ?? Duration(seconds: 2),
    );
  }
}