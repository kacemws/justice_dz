

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:justice_dz/models/Texts.dart';
import 'package:justice_dz/models/data/Categorie.dart';
import 'package:justice_dz/models/data/Commune.dart';
import 'package:justice_dz/models/data/Wilaya.dart';
import 'package:justice_dz/presentation/items/CatItem.dart';
import 'package:justice_dz/presentation/screens/LocationSelector.dart';
import 'package:justice_dz/presentation/screens/MainHomePage.dart';
import 'package:justice_dz/presentation/screens/SignupScreen.dart';
import 'package:justice_dz/presentation/tools/CustomDrawer.dart';
import 'package:justice_dz/presentation/tools/Pub.dart';
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
  String keywords;
  List<Commune> empty = [];
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<Justicedz>(context);
    var textProvider = Provider.of<Texts>(context);

    void _saveFields(){

      FocusScope.of(context).unfocus();

      var isValid = _formKey.currentState.validate();

      if(!isValid) return;
      
      _formKey.currentState.save();
      provider.keywords = keywords;
      Navigator.of(context).pushNamed(
        MainHomePage.route
      );

    
    }

    var _appBar = AppBar(
      title: Text(textProvider.getTitreAppBarLandingPage()),

      leading: GestureDetector(
        onTap: (){
          _scaffoldKey.currentState.openDrawer();
        },
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[

              Icon(
                Icons.menu,
                // size: 20,
              ), 
              Text(textProvider.getMenu(),style: TextStyle(fontSize: 12 ),)

            ],
          ),
      ),

      centerTitle: true,
      elevation: 3,
      actions: <Widget>[
        
        Padding(
          padding: const EdgeInsets.all(6.0),
          child: GestureDetector(

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                Icon(
                  Icons.pin_drop,
                  // size: 20,
                ), 
                Text(textProvider.getPlan(),style: TextStyle(fontSize: 12 ),)

              ],
            ),
          ),
        ),
      ],
    );

    var _height = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - MediaQuery.of(context).padding.bottom - _appBar.preferredSize.height;
    var _width = MediaQuery.of(context).size.width;

    List<Categorie> categories = provider.allCategories();

    void chooseCat(Categorie selected){
      provider.selectedCategorie = selected;
      Navigator.of(context).pushNamed(
        WilayaSelector.route
      );
    }

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
                      "assets/justice-b.jpg",
                      height: _height * 1,
                      width: _width,
                      fit: BoxFit.cover,
                    ), 

                  ],
                ),

                Container(

                  width: _width,
                  height: _height,

                  margin: EdgeInsets.symmetric(horizontal: _width * 0.05),

                  child : Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(

                        crossAxisAlignment: CrossAxisAlignment.center,
                        // mainAxisAlignment: MainAxisAlignment.center,

                        children: <Widget>[
                          space(_height * 0.05),
                          Directionality(
                            textDirection: textProvider.isFrench? TextDirection.ltr : TextDirection.rtl,
                            child: TextFormField(
                                      
                              cursorColor: Theme.of(context).primaryColor,

                              decoration: InputDecoration(

                                filled: true,
                                fillColor: Colors.white.withOpacity(0.5),

                                suffixIcon:Icon(
                                  Icons.search,
                                  color: Colors.black,
                                ),
                                hintText: textProvider.getRechDansLann(),

                                hintStyle: Theme.of(context).textTheme.headline6.copyWith(
                                  // color: Theme.of(context).primaryColor,
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
                                _saveFields();
                              },

                              validator: (value){
                                if(value.isEmpty) return textProvider.isFrench? "Veuillez Introduire Un Nom Valide" : "رجاء ادخل اسما صحيحا";
                                return null;
                              },

                              onSaved: (value){
                                keywords = value;
                                // _userInfos["email"] = value;
                              },

                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.search,
                            ),
                          ),

                          title(context, textProvider.getLandingExemple(), _height, _width),
                          optionButton(_height, _width,textProvider.getRechParCat()),
                          listOfCats(_height, _width, categories, chooseCat),
                          // Expanded(child: SizedBox()),
                          Pub(height : _height, width : _width),
                          signupButton(_height, _width,textProvider.inscrivezvous()),

                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      )
    );
  }

  Widget space(double height){
    return SizedBox(
      height: height,
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
          style: Theme.of(context).textTheme.headline6.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }

  Widget optionButton(double _height, double _width,String text){
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
          text, 
          style: Theme.of(context).textTheme.headline6.copyWith(
            color: Colors.white
          ),
        )
      ),
    );
  }

  Widget signupButton(double _height, double _width,String text){
    return GestureDetector(
      onTap: (){
        Navigator.of(context).pushNamed(
          SignupScreen.route
        );
      },
      child: Container(

        height: _height * 0.075,
        width: _width * 0.8,

        margin: EdgeInsets.symmetric(
          horizontal: _width *0.05,
          vertical: _height *0.02,
        ),

        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.6),
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        child: FittedBox(
          fit: BoxFit.scaleDown, 
          child: Text( 
            text, 
            style: Theme.of(context).textTheme.headline6.copyWith(
              // color: Theme.of(context).primaryColor
            ),
          )
        ),
      ),
    );
  }

  Widget listOfCats(double height, double width, List<Categorie> cats, Function handler){
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
              right: width *0.025
            ),

            child: ChangeNotifierProvider.value(
              value: cats[index],
              child: CatItem(handler : handler),
            ),

          );
          
        }
      ),
    );
  }

}