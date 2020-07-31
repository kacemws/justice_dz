

import 'dart:async';

import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/material.dart';
import 'package:justice_dz/models/Justicedz.dart';
import 'package:justice_dz/presentation/screens/LandingPage.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  final FlareControls controls = FlareControls();
  
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

  void refresh(){
    Timer.periodic(new Duration(milliseconds: 1200), (_) {
      controls.play("go");
    });
  }
  
  @override
  Widget build(BuildContext context) {
    print("build");
    refresh();
    // var _height = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - MediaQuery.of(context).padding.bottom;

    return Scaffold(
      // backgroundColor: Colors.grey[50],
      body: Center(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Colors.grey[350],
                Colors.grey[50],
                Colors.grey[350],
              ]
            )
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[

              Container(
                width: double.infinity,
                alignment: Alignment.center,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: FlareActor(
                    "assets/Logo.flr",
                    alignment: Alignment.center,
                    fit: BoxFit.contain,
                    controller: controls,
                    animation: "go",
                  ),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}