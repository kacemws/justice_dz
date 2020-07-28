

import 'package:flutter/material.dart';
import 'package:justice_dz/models/Justicedz.dart';
import 'package:justice_dz/presentation/screens/LandingPage.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {

    super.initState();

    Future.delayed(Duration.zero).then((_) async {
      await Provider.of<Justicedz>(context, listen: false).fetchData().then((_){
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (ctx)=>LandingPage())
        );
      });
    });

  }
  
  @override
  Widget build(BuildContext context) {

    var _height = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - MediaQuery.of(context).padding.bottom;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

            Image.asset(
              "assets/Logo.png",
              fit: BoxFit.scaleDown,
              height: _height *0.4,
            ),

          ],
        ),
      ),
    );
  }
}