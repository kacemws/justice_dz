
import 'package:flutter/material.dart';
import 'package:justice_dz/models/Justicedz.dart';
import 'package:justice_dz/models/data/Categorie.dart';
import 'package:justice_dz/models/data/Commune.dart';
import 'package:justice_dz/models/data/Wilaya.dart';
import 'package:justice_dz/presentation/tools/CustomAppBar.dart';
import 'package:justice_dz/presentation/tools/CustomDrawer.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  static final String route = "/signup-screen";
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  Map<String,String> values = {
    "nom" : "",
    "prenom" : "",
    "tel" : "",
    "adresse" : "",
    "email" : "",
    "horaire" : "",
    "details" : ""
  };

  Categorie selectedCat = null;
  Wilaya selectedWilaya = null;
  Commune selectedCom = null;

  setSpecialite(Categorie cat){
    setState(() {
      this.selectedCat = cat;
    });
  }
  setWilaya(Wilaya wilaya){
    setState(() {
      this.selectedWilaya = wilaya;
    });
  }
  setCommune(Commune commune){
    setState(() {
      this.selectedCom = commune;
    });
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final FocusNode prenom = FocusNode();
  final FocusNode tel = FocusNode();
  final FocusNode adresse = FocusNode();
  final FocusNode email = FocusNode();
  final FocusNode horaire = FocusNode();
  final FocusNode details = FocusNode();
  final FocusNode gps = FocusNode();

  @override
  Widget build(BuildContext context) {

    var provider = Provider.of<Justicedz>(context);
    var cats = provider.allCategories();
    var wilayas = provider.allWilayas();


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

                    CustomAppBar(width: _width, height: _height, scaffoldKey: _scaffoldKey,),

                    Stack(

                      alignment: Alignment.bottomCenter,

                      children: <Widget>[

                        Container(

                          width: _width,
                          height: _height*0.85,

                          margin: EdgeInsets.symmetric(
                            horizontal: _width * 0.025,
                            vertical: (_height *0.85) *0.0125
                          ),

                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.75),
                            borderRadius: BorderRadius.circular(15)
                          ),

                          child: Form(
                            child: SingleChildScrollView(
                              child: Column(
                                // mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  container(_height, _width, "Nom : ...................",null,prenom),
                                  container(_height, _width, "Prénoms : ...............", prenom, tel),
                                  container(_height, _width, "N° de téléphone : .......", tel, adresse),
                                  container(_height, _width, "Adresse exacte : ........", adresse, email),
                                  container(_height, _width, "Email : .................", email,horaire),
                                  dropDown(_height, _width, cats, selectedCat, setSpecialite),
                                  container(_height, _width, "Horaire d'ouverture :....", horaire,details),
                                  container(_height, _width, "Autres détails : ........", details,gps),
                                  dropDownWilaya(_height, _width, wilayas, selectedWilaya, setWilaya),
                                  dropDownCommune(_height, _width, selectedWilaya, selectedCom, setCommune),
                                  container(_height, _width, "GPS : ...................", gps),
                                ],
                              ),
                            ),
                          ),
                        ),

                        submitButton(_height, _width)
                      ],
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

  Widget container(double height, double width, String hintText, [FocusNode currentNode, FocusNode nextNode]){
    return Container(
      height: (height * 0.85) /13,
      width: width,
      // color: Colors.red,
      margin: EdgeInsets.symmetric(
        horizontal: width * 0.05,
        vertical: (height * 0.85) *0.00075
      ),
      child: TextFormField(

        focusNode: currentNode,

        cursorColor: Theme.of(context).primaryColor,

        decoration: InputDecoration(

          hintText: hintText,

          hintStyle: Theme.of(context).textTheme.title.copyWith(
            // color: Theme.of(context).primaryColor,
          ),
                                    
        ),

        onFieldSubmitted: (_){
          FocusScope.of(context).requestFocus(nextNode);// move to the other textfield
        },

        validator: (value){
          if(value.isEmpty) return "Veuillez Introduire Un Nom Valide";
          return null;
        },

        onSaved: (value){
          this.values[""] = value;
        },

        keyboardType: (hintText.contains("N° de téléphone")) ? TextInputType.phone : hintText.contains("Email") ? TextInputType.emailAddress  : TextInputType.text,
        textInputAction: hintText.contains("GPS")? TextInputAction.done : TextInputAction.next,
      ),
    );
  }

  Widget dropDown(double height, double width, List<Categorie> cats, Categorie selected, Function handler){

    return Container(

      height: (height * 0.85) /13,
      width: width,
      // color: Colors.red,
      margin: EdgeInsets.symmetric(
        horizontal: width * 0.05,
        vertical: (height * 0.85) * 0.00075
      ),
      
      child: DropdownButton<Categorie>(
        
        hint: Text("Spécialité : ............", style: Theme.of(context).textTheme.title, textAlign: TextAlign.start),
        value:selected,

        onChanged: (value){
          handler(value);
        },

        items: cats.map((Categorie cat){
          return DropdownMenuItem<Categorie>(
            value: cat,
            child: Text(cat.nom, style: Theme.of(context).textTheme.title)
          );
        }).toList(),

      )
    );
  }

  Widget dropDownWilaya(double height, double width, List<Wilaya> wilayas, Wilaya selected, Function handler){

    return Container(

      height: (height * 0.85) /13,
      width: width,
      // color: Colors.red,
      margin: EdgeInsets.symmetric(
        horizontal: width * 0.05,
        vertical: (height * 0.85) *0.00075
      ),
      
      child: DropdownButton<Wilaya>(
        
        hint: Text("Wilaya : ................", style: Theme.of(context).textTheme.title, textAlign: TextAlign.start),
        value:selected,

        onChanged: (value){
          handler(value);
        },

        items: wilayas.map((Wilaya wilaya){
          return DropdownMenuItem<Wilaya>(
            value: wilaya,
            child: Text(wilaya.nom, style: Theme.of(context).textTheme.title)
          );
        }).toList(),

      )
    );
  }

  Widget dropDownCommune(double height, double width, Wilaya selected, Commune selectedCom, Function handler){

    return Container(

      height: (height * 0.85) /13,
      width: width,
      // color: Colors.red,
      margin: EdgeInsets.symmetric(
        horizontal: width * 0.05,
        vertical: (height * 0.85) *0.00075
      ),
      
      child: DropdownButton<Commune>(
        hint: Text("Commune : ...............", style: Theme.of(context).textTheme.title, textAlign: TextAlign.start),
        value:selectedCom,

        onChanged: (value){
          handler(value);
        },

        items: selected == null? [] : selected.communes.map((Commune commune){
          return DropdownMenuItem<Commune>(
            value: commune,
            child: Text(commune.nom, style: Theme.of(context).textTheme.title)
          );
        }).toList(),

      )
    );
  }

  Widget submitButton(double height, double width){
    return Container(

      height: (height * 0.8) *0.1,
      width: width *0.4,
      margin: EdgeInsets.only(
        top: (height * 0.85)*0.025
      ),
      decoration: BoxDecoration(

        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(10)
      ),

      child: FittedBox(
        fit : BoxFit.scaleDown,
        child: Text("Envoyer la demande", style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
      ),

    );
  }
}
