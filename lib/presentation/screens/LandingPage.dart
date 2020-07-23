

import 'package:flutter/material.dart';
import 'package:justice_dz/models/data/Categorie.dart';
import 'package:justice_dz/models/data/Wilaya.dart';
import 'package:justice_dz/presentation/screens/MainHomePage.dart';
import 'package:provider/provider.dart';

import 'package:justice_dz/models/Justicedz.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  Wilaya selectedWilaya;
  Categorie selectedCategorie;

  @override
  void initState() {

    super.initState();

    Future.delayed(Duration.zero).then((_) async {
      await Provider.of<Justicedz>(context, listen: false).fetchData();
      selectedWilaya = Provider.of<Justicedz>(context, listen: false).allWilayas().first;
      selectedCategorie = Provider.of<Justicedz>(context, listen: false).allCategories().first;
    });

  }

  void confirmer(){
    Provider.of<Justicedz>(context, listen: false).selectedCategorie = selectedCategorie;
    Provider.of<Justicedz>(context, listen: false).selectedWilaya = selectedWilaya;
    Navigator.of(context).pushReplacementNamed(
      MainHomePage.route
    );
  }


  @override
  Widget build(BuildContext context) {

    var _appBar = AppBar(
      title: Text("Justice DZ"),
      centerTitle: true,
      elevation: 3,
    );

    var _height = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - MediaQuery.of(context).padding.bottom - _appBar.preferredSize.height;
    var _width = MediaQuery.of(context).size.width;

    return SafeArea(

      top: true,
      right : true,
      bottom: true,
      left:true,

      child: Scaffold(
        appBar: _appBar,
        body: Center(
          child: Consumer<Justicedz>(
            builder: (context, provider,_) {
              if(provider.loaded) return Container(
                height: _height *0.9,
                width: double.infinity,

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                    
                  children: <Widget>[

                    title(context, "Veuillez choisir une wilaya", _height, _width),

                    DropdownButton<Wilaya>(

                      elevation: 3,
                      hint:  Text("Veuillez choisir une wilaya"),
                      value: selectedWilaya,

                      onChanged: (Wilaya newValue) {
                        setState(() {
                          selectedWilaya = newValue;
                        });
                      },

                      items: provider.allWilayas().map((Wilaya wilaya) {
                        return  DropdownMenuItem<Wilaya>(           
                          value: wilaya,
                          child: Text(wilaya.nom)
                        );
                      }).toList(),
                    ),
                    title(context, "Veuillez choisir une categorie", _height, _width),
                    DropdownButton<Categorie>(

                      elevation: 3,
                      hint:  Text("Veuillez choisir une catégorie"),
                      value: selectedCategorie,

                      onChanged: (Categorie newValue) {
                        setState(() {
                          selectedCategorie = newValue;
                        });
                      },

                      items: provider.allCategories().map((Categorie categorie) {
                        return  DropdownMenuItem<Categorie>(           
                          value: categorie,
                          child: Text(categorie.nom)
                        );
                      }).toList(),
                    ),

                    continueButton(_height, _width, context, confirmer)

                  ],
                ),
              );             
              return CircularProgressIndicator();
            }
          ),
        ),

      ),
    );
  }

  Widget title(BuildContext context, String text, double height, double width){
    return Container(
      // color: Colors.amber,
      // height: height * 0.105,

      margin: EdgeInsets.symmetric(
        horizontal: width *0.05,
        vertical: height *0.01
      ),

      alignment: Alignment.topLeft,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          text,
          style: Theme.of(context).textTheme.title.copyWith(
            color: Colors.black,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }
    Widget continueButton(double _height, double _width, BuildContext context, Function handler){
    return GestureDetector(
      
      onTap: handler,

      child: Container(

        height: _height * 0.1,
        width: _width * 0.4,

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

        child: Center(child: Text( "Continuer", style: Theme.of(context).textTheme.title,)),

      ),
    );
  }
}