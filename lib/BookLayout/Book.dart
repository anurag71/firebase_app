import 'package:flutter/material.dart';
import 'package:firebase_app/SizeConfig.dart';

class Book extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.contain,
            image: AssetImage("assets/download.jpg"),
        ),
      ),
    );
  }
}