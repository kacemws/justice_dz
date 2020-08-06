

import 'package:flutter/material.dart';
import 'package:justice_dz/models/Justicedz.dart';
import 'package:justice_dz/models/data/Commune.dart';
import 'package:justice_dz/models/data/Wilaya.dart';
import 'package:justice_dz/presentation/screens/MainHomePage.dart';
import 'package:justice_dz/presentation/tools/CustomAppBar.dart';
import 'package:justice_dz/presentation/tools/CustomDrawer.dart';
import 'package:justice_dz/presentation/tools/Pub.dart';
import 'package:provider/provider.dart';

import 'SignupScreen.dart';

class WilayaSelector extends StatefulWidget {
  static final route = "/location-selector";
  @override
  _WilayaSelectorState createState() => _WilayaSelectorState();
}

class _WilayaSelectorState extends State<WilayaSelector> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  Wilaya selectedWilaya;
  Commune selectedCommune;
  String keywords;

  @override
  Widget build(BuildContext context) {

    var provider = Provider.of<Justicedz>(context);
    var wilayas = provider.allWilayas();

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
    

    setW(Wilaya newOne){
      
      setState(() {
        selectedWilaya = newOne;
        selectedCommune = null;
      });

      if(selectedWilaya.nom == "Tous"){
        provider.selectedWilaya = selectedWilaya;
        provider.keywords = "";
        Navigator.of(context).pushNamed(MainHomePage.route);
      }
    }
    
    setC(Commune newOne){
      setState(() {
        selectedCommune = newOne;
      });
      provider.selectedWilaya = selectedWilaya;
      provider.selectedCommune = selectedCommune;
      provider.keywords = "";
      Navigator.of(context).pushNamed(
        MainHomePage.route
      );
    }
    
    var _height = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - MediaQuery.of(context).padding.bottom;
    var _width = MediaQuery.of(context).size.width;

    return SafeArea(
      
      left: true,
      right : true,
      bottom : true,
      top : true,

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

                    CustomAppBar(width: _width, height: _height, scaffoldKey: _scaffoldKey, text : provider.selectedCategorie.nom),
                    Container(
                      height: _height *0.9,
                      width: _width,
                      child: Form(
                        key: _formKey,
                        child: SingleChildScrollView(
                          child: Column(
                            children: <Widget>[

                              SizedBox(
                                height: _height *0.9 *0.05,
                                width: _width,
                              ),

                              wilayaDropDown(_height, _width,wilayas, selectedWilaya, setW),

                              columnDropDown(_height, _width,selectedWilaya, selectedCommune, setC),
                              findByName(_height, _width,_saveFields),

                              Pub(height : _height, width : _width),

                              signupButton(_height,_width)

                            ],
                          ),
                        ),
                      ),
                    )

                  ],
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget columnDropDown(double height, double width, Wilaya selected, Commune selectedC, Function handler) {
    return Container(
      height: height *0.9 *0.15,
      width: width,
      margin: EdgeInsets.symmetric(
        horizontal: width * 0.05,
        vertical: height *0.0125
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(10)
      ),

      alignment: Alignment.center,
      child: DropdownButton<Commune>(
        
        hint: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text("Commune : ................", style: Theme.of(context).textTheme.headline6, textAlign: TextAlign.start),
            Icon(Icons.search)
          ],
        ),
        value:selectedC,

        onChanged: (value){
          handler(value);
        },

        items: selected == null? [] : selected.communes.map((Commune commune){
          return DropdownMenuItem<Commune>(
            value: commune,
            child: Text(commune.nom, style: Theme.of(context).textTheme.headline6)
          );
        }).toList(),

      ),
    );
  }

  Widget wilayaDropDown(double height, double width, List<Wilaya> wilayas, Wilaya selected, Function handler) {
    return Container(
      height: height *0.9 *0.15,
      width: width,
      margin: EdgeInsets.symmetric(
        horizontal: width * 0.05,
        vertical: height *0.0125
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(10)
      ),
      
      alignment: Alignment.center,
      child: DropdownButton<Wilaya>(
        
        hint: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text("Wilaya : ................", style: Theme.of(context).textTheme.headline6, textAlign: TextAlign.start),
            Icon(Icons.search)
          ],
        ),
        value:selected,

        onChanged: (value){
          print(value.nom);
          handler(value);
        },

        items: wilayas.map((Wilaya wilaya){
          return DropdownMenuItem<Wilaya>(
            value: wilaya,
            child: Text(wilaya.nom, style: Theme.of(context).textTheme.headline6)
          );
        }).toList(),

      ),
    );
  }

  Widget signupButton(double _height, double _width){
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
          color: Theme.of(context).primaryColor.withOpacity(0.6),
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        child: FittedBox(
          fit: BoxFit.scaleDown, 
          child: Text( 
            "Practicien? Inscrivez-vous! ", 
            style: Theme.of(context).textTheme.headline6.copyWith(
              color: Colors.white
            ),
          )
        ),
      ),
    );
  }

  Widget findByName(double height, double width, Function handler){
    return Container(
      height: height *0.9 *0.1,
      width: width,
      margin: EdgeInsets.symmetric(
        horizontal: width * 0.05,
        vertical: height *0.0125
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(10)
      ),

      child: TextFormField(
                                    
        cursorColor: Theme.of(context).primaryColor,

        decoration: InputDecoration(

          suffixIcon: Icon(
            Icons.search,
            color: Colors.black,
          ),

          hintText: "Rechercher par nom",

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
          handler();
        },

        validator: (value){
          if(value.isEmpty) return "Veuillez Introduire Un Nom Valide";
          return null;
        },

        onSaved: (value){
          keywords = value;
        },

        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.search,
      ),
    );
  }
  
}