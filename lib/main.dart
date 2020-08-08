import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:justice_dz/models/Justicedz.dart';
import 'package:justice_dz/models/auth.dart';
import 'package:justice_dz/presentation/screens/About.dart';
import 'package:justice_dz/presentation/screens/ContactUs.dart';
import 'package:justice_dz/presentation/screens/LocationSelector.dart';
import 'package:justice_dz/presentation/screens/MainHomePage.dart';
import 'package:justice_dz/presentation/screens/Settings.dart';
import 'package:justice_dz/presentation/screens/SignIn.dart';
import 'package:justice_dz/presentation/screens/SignupScreen.dart';
import 'package:justice_dz/presentation/screens/SplashScreen.dart';
import 'package:provider/provider.dart';

import 'presentation/screens/PersonDetails.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  final Map<int, Color> color =
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
  Widget build(BuildContext context) {

    MaterialColor colorCustom = MaterialColor(0xFF188687, color);

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: colorCustom,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor:colorCustom,
      systemNavigationBarIconBrightness: Brightness.light
    ));

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MultiProvider(

      providers: [
        ChangeNotifierProvider(
          create: (context)=>Justicedz()
        ),
        ChangeNotifierProvider(
          create: (context)=>Auth()
        )
      ],

      child: MaterialApp(

        title: 'Justice DZ',

        debugShowCheckedModeBanner: false,

        theme: ThemeData(
          primarySwatch: colorCustom,
          primaryColor: colorCustom
        ),

        routes: {
          '/' : (context)=> SplashScreen(),
          MainHomePage.route : (context) => MainHomePage(),
          SignupScreen.route : (context) => SignupScreen(),
          SignIn.route : (context) => SignIn(),
          WilayaSelector.route : (context) => WilayaSelector(),
          PersonDetails.route : (context)=> PersonDetails(),
          Settings.route : (context)=> Settings(),
          ContactUs.route : (context)=> ContactUs(),
          About.route : (context)=>About()
        },
      ),

    );
  }
}
