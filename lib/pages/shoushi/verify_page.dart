import 'package:flutter/material.dart';
import 'package:gesture_recognition/gesture_view.dart';
class VerifyPage extends StatefulWidget {
  @override
  _VerifyPageState createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  GlobalKey<GestureState> gestureStateKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    GlobalKey<GestureState> gestureStateKey = GlobalKey();
    return GestureView(
      key: this.gestureStateKey,
      size: MediaQuery.of(context).size.width*0.8,
      selectColor: Colors.blue,
      onPanUp: (List<int> items) {
        analysisGesture(items);
      },
      immediatelyClear: true,
      onPanDown: () {
        gestureStateKey.currentState.selectColor = Colors.blue;
        setState(() {
          status = 0;
        });
      },
    );
  }

  var status = 0;
  void analysisGesture(List<int> items) {

  }
}
