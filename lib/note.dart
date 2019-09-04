import 'package:flutter/material.dart';

class note extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
  return Scaffold(
    body: Center(
      child: SizedBox(
        width: 200,
        height: 400,
        child: Container(
            color: Colors.white,
            child: Text('Long Pressed', style: TextStyle(fontSize: 20),)),
      ),
    ),
  );
  }

}