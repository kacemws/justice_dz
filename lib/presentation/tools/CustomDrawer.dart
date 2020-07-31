
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
    var _width = MediaQuery.of(context).size.width;
    return Drawer(
      elevation: 10,
      child: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[




            Image.asset(
              "assets/Logo.png",
              height: _height *0.2225,
              fit: BoxFit.scaleDown,
            ),

            Container(
              width: double.infinity,
              padding: EdgeInsets.only(bottom: 20, left: 40),
              child: Text("Guide Justice",style: Theme.of(context).textTheme.headline4.copyWith(
                color: Theme.of(context).primaryColor
              ),),
            ),

            ListTile(
              leading: Icon(FontAwesomeIcons.home),
              title: Text("Accueil", style: Theme.of(context).textTheme.headline6,),
              onTap: (){
                Navigator.of(context).pushNamedAndRemoveUntil(
                  '/',
                  (Route<dynamic> route) => false
                );
              },
            ),

            Container(
              height: 1,
              width: _width *0.75,
              color: Theme.of(context).primaryColor.withOpacity(0.5),
            ),

            ListTile(
              leading: FaIcon(FontAwesomeIcons.userPlus),
              title: Text("S'inscrire", style: Theme.of(context).textTheme.headline6,),
              onTap: (){
                Navigator.of(context).pushNamedAndRemoveUntil(
                  '/',
                  (Route<dynamic> route) => false
                );
              },
            ),

            Container(
              height: 1,
              width: _width *0.75,
              color: Theme.of(context).primaryColor.withOpacity(0.5),
            ),
      
            ListTile(
              leading: FaIcon(FontAwesomeIcons.headset),
              title: Text("Nous Contacter", style: Theme.of(context).textTheme.headline6,),
              onTap: (){
                Navigator.of(context).pushNamedAndRemoveUntil(
                  '/',
                  (Route<dynamic> route) => false
                );
              },
            ),

            Container(
              height: 1,
              width: _width *0.75,
              color: Theme.of(context).primaryColor.withOpacity(0.5),
            ),

            Expanded(
              child: SizedBox(),
            ),

            Container(
              height: 2,
              width: _width,
              color: Theme.of(context).primaryColor.withOpacity(0.5),
            ),

            ListTile(
              leading: Container(
                margin: EdgeInsets.only(
                  left: 7.5
                ),
                child: FaIcon(FontAwesomeIcons.info)
              ),
              title: Text("A propos", style: Theme.of(context).textTheme.headline6,),
              onTap: (){
                Navigator.of(context).pushNamedAndRemoveUntil(
                  '/',
                  (Route<dynamic> route) => false
                );
              },
            ),

            Container(
              height: 1,
              width: _width *0.75,
              color: Theme.of(context).primaryColor.withOpacity(0.5),
            ),

            ListTile(
              leading: FaIcon(FontAwesomeIcons.cog,),
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