
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:justice_dz/models/Texts.dart';
import 'package:justice_dz/presentation/screens/About.dart';
import 'package:justice_dz/presentation/screens/ContactUs.dart';
import 'package:justice_dz/presentation/screens/LandingPage.dart';
import 'package:justice_dz/presentation/screens/Profile.dart';
import 'package:justice_dz/presentation/screens/Settings.dart';
import 'package:justice_dz/presentation/screens/SignIn.dart';
import 'package:justice_dz/presentation/screens/SignupScreen.dart';
import 'package:provider/provider.dart';
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
    var texts = Provider.of<Texts>(context);
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
              child: Text(
                texts.guideJustice(),
                style: Theme.of(context).textTheme.headline4.copyWith(
                  color: Theme.of(context).primaryColor
                ),
                textAlign: texts.isFrench? TextAlign.left : TextAlign.center,
              ),
            ),

            ListTile(
              leading: texts.isFrench? Icon(FontAwesomeIcons.home) : SizedBox(),
              title: Text(texts.accueil(), style: Theme.of(context).textTheme.subtitle1.copyWith(fontWeight: FontWeight.bold),textAlign: texts.isFrench? TextAlign.left : TextAlign.right,),
              onTap: (){
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (ctx)=>LandingPage()),
                  (Route<dynamic> route) => false
                );
              },
              trailing: !texts.isFrench? Icon(FontAwesomeIcons.home) : SizedBox(),
            ),

            Container(
              height: 1,
              width: _width *0.75,
              color: Theme.of(context).primaryColor.withOpacity(0.5),
            ),

            ListTile(
              leading: texts.isFrench? FaIcon(FontAwesomeIcons.userPlus) : SizedBox(),
              title: Text(texts.sinscrire(), style: Theme.of(context).textTheme.subtitle1.copyWith(fontWeight: FontWeight.bold),textAlign: texts.isFrench? TextAlign.left : TextAlign.right,),
              onTap: (){
                Navigator.of(context).pushNamed(SignupScreen.route);
              },
              trailing: !texts.isFrench? FaIcon(FontAwesomeIcons.userPlus) : SizedBox(),
            ),

            Container(
              height: 1,
              width: _width *0.75,
              color: Theme.of(context).primaryColor.withOpacity(0.5),
            ),

            ListTile(
              leading: texts.isFrench? FaIcon(FontAwesomeIcons.userAlt) : SizedBox(),
              title: Text(texts.profil(), style: Theme.of(context).textTheme.subtitle1.copyWith(fontWeight: FontWeight.bold),textAlign: texts.isFrench? TextAlign.left : TextAlign.right,),
              onTap: () async{
                var currentUser = FirebaseAuth.instance.currentUser;
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
              trailing : !texts.isFrench? FaIcon(FontAwesomeIcons.userAlt) : SizedBox(),
            ),

            Container(
              height: 1,
              width: _width *0.75,
              color: Theme.of(context).primaryColor.withOpacity(0.5),
            ),
      
            ListTile(
              leading: texts.isFrench? FaIcon(FontAwesomeIcons.headset) : SizedBox(),
              title: Text(texts.nousContacter() , style: Theme.of(context).textTheme.subtitle1.copyWith(fontWeight: FontWeight.bold),textAlign: texts.isFrench? TextAlign.left : TextAlign.right,),
              onTap: (){
                Navigator.of(context).pushNamedAndRemoveUntil(
                  ContactUs.route,
                  (Route<dynamic> route) => false
                );
              },
              trailing: !texts.isFrench? FaIcon(FontAwesomeIcons.headset) : SizedBox(),
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
              leading: texts.isFrench? Container(
                margin: EdgeInsets.only(
                  left: 7.5
                ),
                child: FaIcon(FontAwesomeIcons.info)
              ) : SizedBox(),
              title: Text(texts.apropos() , style: Theme.of(context).textTheme.subtitle1.copyWith(fontWeight: FontWeight.bold),textAlign: texts.isFrench? TextAlign.left : TextAlign.right,),
              onTap: (){
                Navigator.of(context).pushNamedAndRemoveUntil(
                  About.route,
                  (Route<dynamic> route) => false
                );
              },
              trailing: !texts.isFrench? Container(
                margin: EdgeInsets.only(
                  right: 7.5
                ),
                child: FaIcon(FontAwesomeIcons.info)
              ) : SizedBox(),
            ),

            Container(
              height: 1,
              width: _width *0.75,
              color: Theme.of(context).primaryColor.withOpacity(0.5),
            ),

            ListTile(
              leading: texts.isFrench? FaIcon(FontAwesomeIcons.cog,) : SizedBox(),
              title: Text(texts.params(),style: Theme.of(context).textTheme.subtitle1.copyWith(fontWeight: FontWeight.bold),textAlign: texts.isFrench? TextAlign.left : TextAlign.right,),
              onTap: (){
                Navigator.of(context).pushNamedAndRemoveUntil(
                  Settings.route,
                  (Route<dynamic> route) => false
                );
              },
              trailing: !texts.isFrench? FaIcon(FontAwesomeIcons.cog,) : SizedBox(),
            ),

          ],
        ),
      ),
    );
  }
}