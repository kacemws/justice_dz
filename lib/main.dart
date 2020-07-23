import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:justice_dz/models/Justicedz.dart';
import 'package:justice_dz/presentation/screens/MainHomePage.dart';
import 'package:provider/provider.dart';

import 'presentation/screens/PersonDetails.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  Map<int, Color> color =
  {
    50:Color.fromRGBO(12, 92, 76, 0.1),
    100:Color.fromRGBO(12, 92, 76, 0.2),
    200:Color.fromRGBO(12, 92, 76, 0.3),
    300:Color.fromRGBO(12, 92, 76, 0.4),
    400:Color.fromRGBO(12, 92, 76, 0.5),
    500:Color.fromRGBO(12, 92, 76, 0.6),
    600:Color.fromRGBO(12, 92, 76, 0.7),
    700:Color.fromRGBO(12, 92, 76, 0.8),
    800:Color.fromRGBO(12, 92, 76, 0.9),
    900:Color.fromRGBO(12, 92, 76, 1),
  };

  

  @override
  Widget build(BuildContext context) {

    MaterialColor colorCustom = MaterialColor(0xFF0C5C4C, color);

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
          '/' : (context)=> MainHomePage(),
          PersonDetails.route : (context)=> PersonDetails(),
        },
      ),

    );
  }
}
