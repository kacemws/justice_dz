

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:justice_dz/models/data/Categorie.dart';
import 'package:justice_dz/models/data/Commune.dart';
import 'package:justice_dz/models/data/Wilaya.dart';
import 'package:justice_dz/presentation/items/CatItem.dart';
import 'package:justice_dz/presentation/screens/MainHomePage.dart';
import 'package:justice_dz/presentation/tools/CustomDrawer.dart';
import 'package:provider/provider.dart';

import 'package:justice_dz/models/Justicedz.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {

  Wilaya selectedWilaya;
  Categorie selectedCategorie;
  Commune selectedCommune;
  List<Commune> empty = [];

  void confirmer(){
    Provider.of<Justicedz>(context, listen: false).selectedCategorie = selectedCategorie;
    Provider.of<Justicedz>(context, listen: false).selectedWilaya = selectedWilaya;
    Navigator.of(context).pushReplacementNamed(
      MainHomePage.route
    );
  }


  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

    var _appBar = AppBar(
      title: Text("Annuaire"),

      leading: IconButton(
        icon : Icon(Icons.menu),
        onPressed: (){
          _scaffoldKey.currentState.openDrawer();
        },
      ),

      centerTitle: true,
      elevation: 3,
      actions: <Widget>[
        
        IconButton(
          icon: Icon(
            Icons.pin_drop,
          ), 
          onPressed: (){
            print("TODO");
          }
        ),
      ],
    );

    var _height = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - MediaQuery.of(context).padding.bottom - _appBar.preferredSize.height;
    var _width = MediaQuery.of(context).size.width;

    var provider = Provider.of<Justicedz>(context);
    List<Categorie> categories = provider.allCategories();

    return SafeArea(

      top: true,
      right : true,
      bottom: true,
      left:true,

      child: Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        drawer: CustomDrawer(),
        body: Container(
          
          height: _height,
          width: _width,

          child: SingleChildScrollView(
            child: Stack(
              children: <Widget>[

                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[

                    Image.asset(
                      "assets/justice.png",
                      height: _height,
                      width: _width,
                      fit: BoxFit.cover,
                    ), 

                  ],
                ),

                Column(

                  children: <Widget>[

                    Container(

                      width: _width,
                      height: _height *0.4,

                      margin: EdgeInsets.symmetric(horizontal: _width * 0.05),

                      child : Form(

                        child: Column(

                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,

                          children: <Widget>[

                            TextFormField(
                                  
                              cursorColor: Theme.of(context).primaryColor,

                              decoration: InputDecoration(

                                filled: true,
                                fillColor: Colors.white.withOpacity(0.5),

                                suffixIcon: Icon(
                                  Icons.search
                                ),

                                hintText: "Rechercher dans l'annuaire",

                                hintStyle: Theme.of(context).textTheme.title.copyWith(
                                  color: Theme.of(context).primaryColor,
                                ),
                                    

                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor,
                                    width: 1.5
                                  )
                                )
                              ),

                              onFieldSubmitted: (_){
                                // FocusScope.of(context).requestFocus(passwordField); // move to the other textfield
                              },

                              validator: (value){
                                if(value.isEmpty) return "Veuillez Introduire Un Nom Valide";
                                return null;
                              },

                              // onSaved: (value){
                              //   _userInfos["email"] = value;
                              // },

                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.search,
                            ),

                            title(context, "Exemples : Maitre Hocini, Maitre Saidi, ...", _height, _width),
                            optionButton(_height, _width)

                          ],
                        ),
                      ),
                          
                    ),

                    Container(
                      width: _width,
                      height: _height *0.6,

                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            listOfCats(_height, _width, categories),
                            Expanded(child: SizedBox()),
                            pub(_height,_width)
                          ],
                        ),
                      ),

                    ),


                  ],
                ),
              ],
            ),
          ),
        ),

      ),
    );
  }

  Widget title(BuildContext context, String text, double height, double width){
    return Container(
      height: height * 0.1,
      width: width *0.8,
      // color: Colors.red,
      margin: EdgeInsets.symmetric(
        horizontal: width *0.05,
      ),

      alignment: Alignment.centerLeft,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          text,
          style: Theme.of(context).textTheme.title.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }
    Widget optionButton(double _height, double _width){
    return Container(

      height: _height * 0.075,
      width: _width * 0.65,

      margin: EdgeInsets.symmetric(
        horizontal: _width *0.05,
      ),

      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.6),
        borderRadius: BorderRadius.circular(10),
      ),
      alignment: Alignment.center,
      child: FittedBox(
        fit: BoxFit.scaleDown, 
        child: Text( 
          "Rechercher par catégorie", 
          style: Theme.of(context).textTheme.title.copyWith(
            color: Colors.white
          ),
        )
      ),
    );
  }

  Widget listOfCats(double height, double width, List<Categorie> cats){
    return Container(
      height: height *0.225,
      
      margin: EdgeInsets.symmetric(
        vertical: height *0.025
      ),

      child: ListView.builder(

        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        itemCount: cats.length,

        itemBuilder: (_,index){

          return Container(

            width: width *0.38,

            margin: EdgeInsets.only(
              top: height *0.01,
              bottom: height *0.01,
              left: width *0.05
            ),

            child: ChangeNotifierProvider.value(
              value: cats[index],
              child: CatItem(),
            ),

          );
          
        }
      ),
    );
  }

  Widget pub(double height, double width){
    return Container(

      height: height * 0.2,
      width : width,

      margin: EdgeInsets.symmetric(
        vertical: height *0.01,
        horizontal: width * 0.05
      ),

      
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.75),
        borderRadius: BorderRadius.circular(15)
      ),
      alignment: Alignment.center,
      child: Text(
        "Pub", 
        style: Theme.of(context).textTheme.title.copyWith(
          color: Colors.white
        )
      ),

    );
  }
}