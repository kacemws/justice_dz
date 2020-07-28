
import 'package:flutter/material.dart';
import 'package:justice_dz/presentation/screens/Settings.dart';
// import 'package:meal_app/Presentation/Screens/Settings.dart';

class CustomDrawer extends StatelessWidget {
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
    var _height = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - MediaQuery.of(context).padding.bottom;
    return Drawer(
      elevation: 10,
      child: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[

            Container(
              color: colorCustom,
              width: double.infinity,
              padding: EdgeInsets.only(bottom: 20, left: 40),
              height: _height *0.2225,
              child: Text("Justice Dz",style: Theme.of(context).textTheme.headline4.copyWith(
                color: Colors.white
              ),),
              alignment: Alignment.bottomLeft
            ),

            SizedBox(height: 60,),

            ListTile(
              leading: Icon(Icons.home),
              title: Text("Accueil", style: Theme.of(context).textTheme.headline6,),
              onTap: (){
                Navigator.of(context).pushNamedAndRemoveUntil(
                  '/',
                  (Route<dynamic> route) => false
                );
              },
            ),

            SizedBox(height: 20,),

            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Paramètres", style: Theme.of(context).textTheme.headline6,),
              onTap: (){
                print("TODO");
                Navigator.of(context).pushNamedAndRemoveUntil(
                  Settings.route,
                  (Route<dynamic> route) => false
                );
              },
            ),

          ],
        ),
      ),
    );
  }
}