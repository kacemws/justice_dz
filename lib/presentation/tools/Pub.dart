import 'package:flutter/material.dart';

class Pub extends StatelessWidget {

  final double height;
  final double width;

  Pub({@required this.height, @required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(

      height: height * 0.25,
      width : width,

      margin: EdgeInsets.symmetric(
        vertical: height *0.01,
        horizontal: width * 0.05
      ),

      
      decoration: BoxDecoration(
        // color: Theme.of(context).primaryColor.withOpacity(0.75),
        borderRadius: BorderRadius.circular(15)
      ),
      alignment: Alignment.center,
      child: Image.asset(
        'assets/pub.gif',
        height: height *0.25,
      )

    );
  }
}

