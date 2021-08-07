
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:justice_dz/models/Justicedz.dart';
import 'package:justice_dz/models/data/Person.dart';
import 'package:justice_dz/presentation/screens/SignIn.dart';
import 'package:justice_dz/presentation/tools/CustomDrawer.dart';
import 'package:justice_dz/models/Texts.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  final String userId;
  ProfilePage({@required this.userId});
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Person loggedIn;
  var _isloading = false;
  Map<String,String> values = {
    "nom" : "",
    "prenom" : "",
    "nomAr" : "",
    "prenomAr" : "",
    "tel" : "",
    "adresse" : "",
    "horaire" : "",
  };

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  final FocusNode nom = FocusNode();
  TextEditingController nomController = TextEditingController(text: "");

  final FocusNode nomAr = FocusNode();
  TextEditingController nomArController = TextEditingController(text: "");

  final FocusNode prenom = FocusNode();
  TextEditingController prenomController = TextEditingController(text: "");
  
  final FocusNode prenomAr = FocusNode();
  TextEditingController prenomArController = TextEditingController(text: "");

  final FocusNode tel = FocusNode();
  TextEditingController telController = TextEditingController(text: "");

  final FocusNode adresse = FocusNode();
  TextEditingController adresseController = TextEditingController(text: "");

  final FocusNode horaire = FocusNode();
  TextEditingController horaireController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<Justicedz>(context);
    var textProvider = Provider.of<Texts>(context);

    loggedIn = provider.getPersonById(widget.userId);

    if(nomController.text == ""){
      nomController.text = loggedIn.nom;
    }
    if(prenomController.text == ""){
      prenomController.text = loggedIn.prenom;
    }

    if(nomArController.text == ""){
      nomArController.text = loggedIn.nomAr;
    }
    if(prenomArController.text == ""){
      prenomArController.text = loggedIn.prenomAr;
    }

    if(telController.text == ""){
      telController.text = loggedIn.numPhone;
    }
    if(adresseController.text == ""){
      adresseController.text = loggedIn.adresse.adresse;
    }
    if(horaireController.text == ""){
      horaireController.text = loggedIn.horaire;
    }

    Future<void> _saveFields() async{

      FocusScope.of(context).unfocus();

      var isValid = _formKey.currentState.validate();

      if(!isValid) return;
      
      _formKey.currentState.save();
      print(
        "nom : " + values["nom"]+
        "\nprenom : " + values["prenom"]+
        "\ntel : " + values["tel"]+
        "\nadresse : " + values["adresse"]+
        "\nhoraire : " + values["horaire"]
      );

      setState(() {
        _isloading = true;
      });

      try{
        var aux = Person(
          id: loggedIn.id,
          nom: values["nom"],
          nomAr: values["nomAr"],
          prenom: values["prenom"],
          prenomAr: values["prenomAr"],
          numPhone: values["tel"],
          email: loggedIn.email,
          horaire: values["horaire"],
          adresse: Adresse(lat: loggedIn.adresse.lat, long: loggedIn.adresse.long, adresse: values["adresse"]),
          wilaya: loggedIn.wilaya,
          categorie: loggedIn.categorie,
          commune: loggedIn.commune,
        );
        await provider.updateUser(aux);
      }catch (error){

      }
      setState(() {
        _isloading = false;
      });
    
    }

    var _appBar = AppBar(
      title: Text(textProvider.profil()),
      centerTitle: true,
      actions: <Widget>[
        IconButton(icon: Icon(Icons.exit_to_app), onPressed: (){
          FirebaseAuth.instance.signOut();
          Navigator.of(context).pushReplacementNamed(
            SignIn.route,
          );
        })
      ],
    );

    
    var _height = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - MediaQuery.of(context).padding.bottom - _appBar.preferredSize.height;
    var _width = MediaQuery.of(context).size.width; // the width of the current screen

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

                Image.asset(
                  "assets/justice-b.jpg",
                  height: _height,
                  width: _width,
                  fit: BoxFit.cover,
                ),

                Stack(

                  alignment: Alignment.bottomCenter,

                  children: <Widget>[

                    Container(
                      alignment: Alignment.center,
                      width: _width,
                      height: _height * 0.85,

                      margin: EdgeInsets.symmetric(
                        horizontal: _width * 0.025,
                        vertical: (_height) *0.0125
                      ),

                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.75),
                        borderRadius: BorderRadius.circular(15)
                      ),

                      child: Form(
                        key: _formKey,
                        child: SingleChildScrollView(
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[

                              Container(

                                width: _width,

                                margin: EdgeInsets.symmetric(
                                  horizontal: _width * 0.05,
                                  vertical: (_height) *0.00075
                                ),

                                child: Directionality(
                                  textDirection: textProvider.isFrench? TextDirection.ltr : TextDirection.rtl,
                                  child: TextFormField(
                       
                                    focusNode: nom,
                                    controller: nomController,
                                    cursorColor: Theme.of(context).primaryColor,

                                    decoration: InputDecoration(

                                      labelText: textProvider.nomFr(),

                                      labelStyle: Theme.of(context).textTheme.headline6,
                                                                
                                    ),

                                    onFieldSubmitted: (_){
                                      FocusScope.of(context).requestFocus(nomAr);// move to the other textfield
                                    },

                                    validator: (value){
                                      if(value.isEmpty) return "Veuillez Introduire Un nom Valide";
                                      return null;
                                    },

                                    onSaved: (value){
                                      this.values["nom"] = value;
                                    },

                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.next,
                                  ),
                                ),
                              ),

                              Container(

                                width: _width,

                                margin: EdgeInsets.symmetric(
                                  horizontal: _width * 0.05,
                                  vertical: (_height) *0.00075
                                ),

                                child: Directionality(
                                  textDirection: textProvider.isFrench? TextDirection.ltr : TextDirection.rtl,
                                  child: TextFormField(
                       
                                    focusNode: nomAr,
                                    controller: nomArController,
                                    cursorColor: Theme.of(context).primaryColor,

                                    decoration: InputDecoration(

                                      labelText: textProvider.nomAr(),

                                      labelStyle: Theme.of(context).textTheme.headline6,
                                                                
                                    ),

                                    onFieldSubmitted: (_){
                                      FocusScope.of(context).requestFocus(prenom);// move to the other textfield
                                    },

                                    validator: (value){
                                      if(value.isEmpty) return "Veuillez Introduire Un nom Valide";
                                      return null;
                                    },

                                    onSaved: (value){
                                      this.values["nomAr"] = value;
                                    },

                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.next,
                                  ),
                                ),
                              ),

                              Container(

                                width: _width,

                                margin: EdgeInsets.symmetric(
                                  horizontal: _width * 0.05,
                                  vertical: (_height) *0.00075
                                ),
                                child: Directionality(
                                  textDirection: textProvider.isFrench? TextDirection.ltr : TextDirection.rtl,
                                  child: TextFormField(

                                    focusNode: prenom,
                                    controller: prenomController,
                                    cursorColor: Theme.of(context).primaryColor,

                                    decoration: InputDecoration(

                                      labelText: textProvider.prenomFr(),

                                      labelStyle: Theme.of(context).textTheme.headline6,
                                                                
                                    ),

                                    onFieldSubmitted: (_){
                                      FocusScope.of(context).requestFocus(prenomAr);// move to the other textfield
                                    },

                                    validator: (value){
                                      if(value.isEmpty) return "Veuillez Introduire Un prenom Valide";
                                      return null;
                                    },

                                    onSaved: (value){
                                      this.values["prenom"] = value;
                                    },

                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.next,
                                  ),
                                ),
                              ),

                              Container(

                                width: _width,

                                margin: EdgeInsets.symmetric(
                                  horizontal: _width * 0.05,
                                  vertical: (_height) *0.00075
                                ),
                                child: Directionality(
                                  textDirection: textProvider.isFrench? TextDirection.ltr : TextDirection.rtl,
                                  child: TextFormField(

                                    focusNode: prenomAr,
                                    controller: prenomArController,
                                    cursorColor: Theme.of(context).primaryColor,

                                    decoration: InputDecoration(

                                      labelText: textProvider.prenomAr(),

                                      labelStyle: Theme.of(context).textTheme.headline6,
                                                                
                                    ),

                                    onFieldSubmitted: (_){
                                      FocusScope.of(context).requestFocus(tel);// move to the other textfield
                                    },

                                    validator: (value){
                                      if(value.isEmpty) return "Veuillez Introduire Un prenom Valide";
                                      return null;
                                    },

                                    onSaved: (value){
                                      this.values["prenomAr"] = value;
                                    },

                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.next,
                                  ),
                                ),
                              ),

                              Container(

                                width: _width,

                                margin: EdgeInsets.symmetric(
                                  horizontal: _width * 0.05,
                                  vertical: (_height) *0.00075
                                ),
                                child: Directionality(
                                  textDirection: textProvider.isFrench? TextDirection.ltr : TextDirection.rtl,
                                  child: TextFormField(

                                    focusNode: tel,
                                    controller: telController,
                                    cursorColor: Theme.of(context).primaryColor,

                                    decoration: InputDecoration(

                                      labelText: textProvider.numero(),

                                      labelStyle: Theme.of(context).textTheme.headline6,
                                                                
                                    ),

                                    onFieldSubmitted: (_){
                                      FocusScope.of(context).requestFocus(adresse);// move to the other textfield
                                    },

                                    validator: (value){
                                      if(value.isEmpty || (!value.startsWith("07") && !value.startsWith("05") && !value.startsWith("06"))) return textProvider.isFrench? "Veuillez Introduire un numéro Valide" : "الرجاء إدخال قيمة صالحة";
                                      return null;
                                    },

                                    onSaved: (value){
                                      this.values["tel"] = value;
                                    },

                                    keyboardType: TextInputType.number,
                                    textInputAction: TextInputAction.next,
                                  ),
                                ),
                              ),

                              Container(

                                width: _width,

                                margin: EdgeInsets.symmetric(
                                  horizontal: _width * 0.05,
                                  vertical: (_height) *0.00075
                                ),
                                child: Directionality(
                                  textDirection: textProvider.isFrench? TextDirection.ltr : TextDirection.rtl,
                                  child: TextFormField(

                                    focusNode: adresse,
                                    controller: adresseController,
                                    cursorColor: Theme.of(context).primaryColor,

                                    decoration: InputDecoration(

                                      labelText: textProvider.adresse(),

                                      labelStyle: Theme.of(context).textTheme.headline6,
                                                                
                                    ),

                                    onFieldSubmitted: (_){
                                      FocusScope.of(context).requestFocus(horaire);// move to the other textfield
                                    },

                                    validator: (value){
                                      if(value.isEmpty ) return textProvider.isFrench? "Veuillez Introduire une adresse Valide" : "الرجاء إدخال قيمة صالحة";
                                      return null;
                                    },

                                    onSaved: (value){
                                      this.values["adresse"] = value;
                                    },

                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.next,
                                  ),
                                ),
                              ),

                              Container(

                                width: _width,

                                margin: EdgeInsets.symmetric(
                                  horizontal: _width * 0.05,
                                  vertical: (_height) *0.00075
                                ),
                                child: Directionality(
                                  textDirection: textProvider.isFrench? TextDirection.ltr : TextDirection.rtl,
                                  child: TextFormField(

                                    focusNode: horaire,
                                    controller: horaireController,
                                    cursorColor: Theme.of(context).primaryColor,

                                    decoration: InputDecoration(

                                      labelText: textProvider.horraire(),

                                      labelStyle: Theme.of(context).textTheme.headline6,
                                                                
                                    ),

                                    onFieldSubmitted: (_){
                                      // FocusScope.of(context).requestFocus(horaire);// move to the other textfield
                                      _saveFields();
                                    },

                                    validator: (value){
                                      if(value.isEmpty ) return textProvider.isFrench? "Veuillez Introduire une valeur Valide" : "الرجاء إدخال قيمة صالحة";
                                      return null;
                                    },

                                    onSaved: (value){
                                      this.values["horaire"] = value;
                                    },

                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.done,
                                  ),
                                ),
                              ),

                              
                            ],
                          ),
                        ),
                      ),
                    ),

                    submitButton(_height, _width,_saveFields)
                  ],
                ),
              ],
            ),
          ),
        )
      ),
    );
  }
  

  Widget submitButton(double height, double width, Function handler){
    return GestureDetector(
      onTap: handler,
      child: Container(

        height: (height) *0.1,
        width: width *0.4,
        margin: EdgeInsets.only(
          top: (height * 0.85)*0.025
        ),
        decoration: BoxDecoration(

          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(10)
        ),

        child: _isloading? Center(child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),)):FittedBox(
          fit : BoxFit.scaleDown,
          child: Text("Sauvegarder", style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
        ),

      ),
    );
  }
}