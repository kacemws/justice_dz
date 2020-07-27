

import 'package:flutter/material.dart';
import 'package:justice_dz/models/Justicedz.dart';
import 'package:justice_dz/presentation/screens/LandingPage.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  Map<int, Color> color =
  {
    50:Color.fromRGBO(24, 134, 135, 0.1),
    100:Color.fromRGBO(24, 134, 135, 0.2),
    200:Color.fromRGBO(24, 134, 135, 0.3),
    300:Color.fromRGBO(24, 134, 135, 0.4),
    400:Color.fromRGBO(24, 134, 135, 0.5),
    500:Color.fromRGBO(24, 134, 135, 0.6),
    600:Color.fromRGBO(24, 134, 135, 0.7),
    700:Color.fromRGBO(24, 134, 135, 0.8),
    800:Color.fromRGBO(24, 134, 135, 0.9),
    900:Color.fromRGBO(24, 134, 135, 1),
  };

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

    MaterialColor colorCustom = MaterialColor(0xFF188687, color);
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