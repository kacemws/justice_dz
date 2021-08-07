
import 'package:flutter/material.dart';
import 'package:justice_dz/models/Justicedz.dart';
import 'package:justice_dz/models/Texts.dart';
import 'package:justice_dz/presentation/tools/CustomAppBar.dart';
import 'package:justice_dz/presentation/tools/CustomDrawer.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class PersonDetails extends StatelessWidget {

  static final String route = "/person-details";
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    
    var personId = ModalRoute.of(context).settings.arguments as String;
    var provider = Provider.of<Justicedz>(context);
    var textProvider = Provider.of<Texts>(context);
    var person = provider.getPersonById(personId);


    var _height = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.vertical;
    var _width = MediaQuery.of(context).size.width;

    return SafeArea(

      top: true,
      right: true,
      bottom: true,
      left: true,

      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.grey[50],
        drawer: CustomDrawer(),

        body: Container(
          height: _height,
          width: _width,

          child: SingleChildScrollView(
            child: Stack(
              children: <Widget>[

                Column(
                  children: <Widget>[

                    SizedBox(
                      width: _width,
                      height: _height *0.1,
                    ),

                    Image.asset(
                      "assets/justice-b.jpg",
                      height: _height *0.9,
                      width: _width,
                      fit: BoxFit.cover,
                    ),

                  ],
                ),

                Column(
                  children: <Widget>[
                    CustomAppBar(width: _width, height: _height, scaffoldKey: _scaffoldKey, text : textProvider.profil()),
                    space(_height * 0.04),

                    Container(

                      height: _height *0.325,
                      width: _width,
                      
                      margin: EdgeInsets.symmetric(
                        horizontal: _width *0.05
                      ),

                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(20)
                      ),

                      child: Center(
                        child: Image.asset(
                          "assets/Logo.png"
                        ),
                      ),
                    ),

                    Container(

                      height: _height *0.5,
                      width: _width,
                      
                      margin: EdgeInsets.symmetric(
                        horizontal: _width *0.05,
                        vertical: _height * 0.0125
                      ),

                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(0.375),
                        borderRadius: BorderRadius.circular(20)
                      ),

                      child: Column(
                        children: <Widget>[
                          space(_height * 0.015),

                          Container(

                            margin: EdgeInsets.symmetric(
                              vertical: _height *0.005
                            ),

                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.65),
                              borderRadius: BorderRadius.circular(5)
                            ),

                            child: Directionality(
                              textDirection: textProvider.isFrench? TextDirection.ltr : TextDirection.rtl,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  
                                  title(textProvider.isFrench? "Maitre : " : "الأستاذ : ", _height, _width, context, Alignment.centerLeft,false),
                                  
                                  Container(
                                    child: title(textProvider.isFrench? (person.nom + " " + person.prenom) : (person.nomAr+" "+person.prenomAr), _height, _width, context, Alignment.centerLeft,true)
                                  ),

                                ],
                              ),
                            ),
                          ),

                          Container(

                            margin: EdgeInsets.symmetric(
                              vertical: _height *0.005
                            ),

                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.65),
                              borderRadius: BorderRadius.circular(5)
                            ),
                            child: Directionality(
                              textDirection: textProvider.isFrench? TextDirection.ltr : TextDirection.rtl,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: <Widget>[

                                  title(textProvider.isFrench? "Adresse postale : " : "عنوان : ", _height, _width, context, Alignment.centerLeft,false),

                                  Container(
                                    child: title(person.adresse.adresse, _height, _width, context, Alignment.centerLeft,true)
                                  ),

                                ],
                              ),
                            ),
                          ),

                          Container(

                            margin: EdgeInsets.symmetric(
                              vertical: _height *0.005
                            ),

                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.65),
                              borderRadius: BorderRadius.circular(5)
                            ),

                            child: Directionality(
                              textDirection: textProvider.isFrench? TextDirection.ltr : TextDirection.rtl,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: <Widget>[

                                  title(textProvider.isFrench? "N°Telephone : " : "رقم الهاتف : ", _height, _width, context, Alignment.centerLeft,false),

                                  Container(
                                    child: title(person.numPhone, _height, _width, context, Alignment.centerLeft,true)
                                  ),

                                  Expanded(child: SizedBox()),

                                  IconButton(
                                    icon: Icon(Icons.phone), 
                                    onPressed: (){
                                      launch("tel:"+person.numPhone);
                                    }
                                  ),

                                ],
                              ),
                            ),
                          ),

                          Container(

                            margin: EdgeInsets.symmetric(
                              vertical: _height *0.005
                            ),

                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.65),
                              borderRadius: BorderRadius.circular(5)
                            ),
                            child: Directionality(
                              textDirection: textProvider.isFrench? TextDirection.ltr : TextDirection.rtl,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: <Widget>[

                                  title("GPS : ", _height, _width, context, Alignment.centerLeft,false),

                                  // Container(
                                  //   child: title("", _height, _width, context, Alignment.centerLeft,true)
                                  // ),

                                  Expanded(child: SizedBox()),

                                  IconButton(
                                    icon: Icon(Icons.explore), 
                                    onPressed: (){
                                      launch("https://www.google.com/maps/search/?api=1&query=${person.adresse.lat},${person.adresse.long}");
                                    }
                                  ),

                                ],
                              ),
                            ),
                          ),

                          Container(

                            margin: EdgeInsets.symmetric(
                              vertical: _height *0.005
                            ),

                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.65),
                              borderRadius: BorderRadius.circular(5)
                            ),

                            child: Directionality(
                              textDirection: textProvider.isFrench? TextDirection.ltr : TextDirection.rtl,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: <Widget>[

                                  title(textProvider.isFrench? "Horaire d'ouverture : " : "اوقات الفتح : ", _height, _width, context, Alignment.centerLeft,false),

                                  Container(
                                    // width: _width *0.65,
                                    child: title(person.horaire, _height, _width, context, Alignment.centerLeft,true)
                                  ),
                                ],
                              ),
                            ),
                          ),

                          Container(

                            margin: EdgeInsets.symmetric(
                              vertical: _height *0.005
                            ),

                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.65),
                              borderRadius: BorderRadius.circular(5)
                            ),

                            child: Directionality(
                              textDirection: textProvider.isFrench? TextDirection.ltr : TextDirection.rtl,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: <Widget>[

                                  title(textProvider.isFrench?"Spécialité : " : "التخصص : ", _height, _width, context, Alignment.centerLeft,false),

                                  Container(
                                    // width: _width *0.65,
                                    child: title(textProvider.isFrench?person.categorie.nom : person.categorie.nomAr, _height, _width, context, Alignment.centerLeft,true)
                                  ),
                                ],
                              ),
                            ),
                          ),


                        ],
                      ),
                    ),

                  ],
                )
              ],
            ),
          ),
        ),

      ),
    );

  }

  Widget title(String text, double height, double width, BuildContext context, AlignmentGeometry alignment, bool info){
    return Container(

      width: info? width*0.25 : null,

      height: height *0.05,

      margin: EdgeInsets.symmetric(
        horizontal: info? 0 : width *0.05,
        vertical: height *0.005
      ),

      alignment: alignment,
      child: FittedBox(
        fit:BoxFit.scaleDown,
        child: Text(
          text,
          style: info? Theme.of(context).textTheme.subtitle1 : Theme.of(context).textTheme.headline6.copyWith(
            fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }

  Widget space(double height){
    return SizedBox(
      height: height,
    );
  }

  Widget followButton(double _height, double _width, BuildContext context, String email){
    return GestureDetector(
      
      onTap: (){
        launch("mailto:"+email+"?subject=Reservation&body=");
      },

      child: Container(

        height: _height * 0.1,

        margin: EdgeInsets.symmetric(
          horizontal: _width *0.05,
          vertical: _height * 0.0125
        ),

        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(10),
          boxShadow: [

            BoxShadow(
              blurRadius: 5,
              color: Colors.black38,
              offset: Offset(2.5, 2.5)
            ),
            BoxShadow(
              blurRadius: 5,
              color: Colors.white60,
              offset: -Offset(2.5, 2.5)
            ),
          ]
        ),

        child: Center(child: Text( "Reserver", style: Theme.of(context).textTheme.headline6,)),

      ),
    );
  }

}