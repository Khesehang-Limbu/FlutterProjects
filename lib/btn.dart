import 'package:flutter/material.dart';

class Btn extends StatelessWidget {
  Btn(this.bg, this.btnName, this.onPressed, {super.key});

  Color bg;
  String btnName;
  void Function()? onPressed;

  @override
  Widget build(context) {
    return TextButton(
        style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(bg), foregroundColor: MaterialStatePropertyAll(Colors.white)),
        onPressed: onPressed,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            btnName,
            style: TextStyle(color: Colors.black, fontSize: 30),
          ),
        ));
  }
}
