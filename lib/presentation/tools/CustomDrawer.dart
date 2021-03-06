
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:justice_dz/presentation/screens/About.dart';
import 'package:justice_dz/presentation/screens/ContactUs.dart';
import 'package:justice_dz/presentation/screens/LandingPage.dart';
import 'package:justice_dz/presentation/screens/Profile.dart';
import 'package:justice_dz/presentation/screens/Settings.dart';
import 'package:justice_dz/presentation/screens/SignIn.dart';
import 'package:justice_dz/presentation/screens/SignupScreen.dart';
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
              title: Text("Accueil", style: Theme.of(context).textTheme.subtitle1.copyWith(fontWeight: FontWeight.bold),),
              onTap: (){
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (ctx)=>LandingPage()),
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
              title: Text("S'inscrire", style: Theme.of(context).textTheme.subtitle1.copyWith(fontWeight: FontWeight.bold),),
              onTap: (){
                Navigator.of(context).pushNamed(SignupScreen.route);
              },
            ),

            Container(
              height: 1,
              width: _width *0.75,
              color: Theme.of(context).primaryColor.withOpacity(0.5),
            ),

            ListTile(
              leading: FaIcon(FontAwesomeIcons.userAlt),
              title: Text("Profil", style: Theme.of(context).textTheme.subtitle1.copyWith(fontWeight: FontWeight.bold),),
              onTap: () async{
                var currentUser = await FirebaseAuth.instance.currentUser();
                if(currentUser == null){
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    SignIn.route,
                    (Route<dynamic> route) => false
                  );
                }else{
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (ctx)=>ProfilePage(
                        userId: currentUser.uid,
                      ),
                    ), 
                    (Route<dynamic> route) => false
                  );
                }
              },
            ),

            Container(
              height: 1,
              width: _width *0.75,
              color: Theme.of(context).primaryColor.withOpacity(0.5),
            ),
      
            ListTile(
              leading: FaIcon(FontAwesomeIcons.headset),
              title: Text("Nous Contacter", style: Theme.of(context).textTheme.subtitle1.copyWith(fontWeight: FontWeight.bold),),
              onTap: (){
                Navigator.of(context).pushNamedAndRemoveUntil(
                  ContactUs.route,
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
              title: Text("A propos", style: Theme.of(context).textTheme.subtitle1.copyWith(fontWeight: FontWeight.bold),),
              onTap: (){
                Navigator.of(context).pushNamedAndRemoveUntil(
                  About.route,
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
              title: Text("Paramètres", style: Theme.of(context).textTheme.subtitle1.copyWith(fontWeight: FontWeight.bold),),
              onTap: (){
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