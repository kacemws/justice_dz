
import 'package:flutter/material.dart';
import 'package:justice_dz/presentation/screens/Settings.dart';
// import 'package:meal_app/Presentation/Screens/Settings.dart';

class CustomDrawer extends StatelessWidget {
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
              child: Text("Justice Dz",style: Theme.of(context).textTheme.display1.copyWith(
                color: Colors.white
              ),),
              alignment: Alignment.bottomLeft
            ),

            SizedBox(height: 60,),

            ListTile(
              leading: Icon(Icons.home),
              title: Text("Accueil", style: Theme.of(context).textTheme.title,),
              onTap: (){
                Navigator.of(context).pushReplacementNamed(
                  '/'
                );
              },
            ),

            SizedBox(height: 20,),

            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Paramètres", style: Theme.of(context).textTheme.title,),
              onTap: (){
                print("TODO");
                Navigator.of(context).pushReplacementNamed(
                  Settings.route
                );
              },
            ),

          ],
        ),
      ),
    );
  }
}