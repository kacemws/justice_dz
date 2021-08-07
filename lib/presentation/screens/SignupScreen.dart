
import 'package:flutter/material.dart';
import 'package:justice_dz/models/Justicedz.dart';
import 'package:justice_dz/models/Texts.dart';
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
    "details" : "",
    "gps" : "",
    "wilaya" : "",
    "commune" : "",
    "spécialité" : "",
  };

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  final FocusNode prenom = FocusNode();
  final FocusNode tel = FocusNode();
  final FocusNode adresse = FocusNode();
  final FocusNode email = FocusNode();
  final FocusNode specialite = FocusNode();
  final FocusNode horaire = FocusNode();
  final FocusNode details = FocusNode();
  final FocusNode wilaya = FocusNode();
  final FocusNode commune = FocusNode();

  @override
  Widget build(BuildContext context) {

    var provider = Provider.of<Justicedz>(context);
    var textProvider = Provider.of<Texts>(context);
    
    var _height = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - MediaQuery.of(context).padding.bottom;
    var _width = MediaQuery.of(context).size.width;

    void _saveFields(){

      FocusScope.of(context).unfocus();

      var isValid = _formKey.currentState.validate();

      if(!isValid) return;
      
      _formKey.currentState.save();
      print(
        "nom : " + values["nom"]+
        "\nprenom : " + values["prenom"]+
        "\ntel : " + values["tel"]+
        "\nadresse : " + values["adresse"]+
        "\nemail : " + values["email"]+
        "\nspécialité : " + values["spécialité"]+
        "\nhoraire : " + values["horaire"]+
        "\ndetails : " + values["details"]+
        "\nwilaya : " + values["wilaya"]+
        "\ncommune : " + values["commune"]
      );

      try{
        provider.sendSignup(values: values);
      }catch (error){

      }
    
    }

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

                    CustomAppBar(width: _width, height: _height, scaffoldKey: _scaffoldKey,text: textProvider.demandeDins(),),

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
                            key: _formKey,
                            child: SingleChildScrollView(
                              child: Column(
                                // mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[

                                  container(_height, _width, textProvider.nomHint(), "nom",textProvider.isFrench, null,prenom),
                                  container(_height, _width, textProvider.prenomHint(), "prenom",textProvider.isFrench, prenom, tel),
                                  container(_height, _width, textProvider.telHint(), "tel",textProvider.isFrench, tel, adresse),
                                  container(_height, _width, textProvider.adrHint(), "adresse",textProvider.isFrench, adresse, email),
                                  container(_height, _width, textProvider.emailHint(), "email",textProvider.isFrench, email,specialite),
                                  container(_height, _width, textProvider.specHint(), "spécialité",textProvider.isFrench, specialite,horaire),
                                  container(_height, _width, textProvider.horaireHint(), "horaire",textProvider.isFrench, horaire,details),
                                  container(_height, _width, textProvider.detailsHint(), "details",textProvider.isFrench, details,wilaya),
                                  container(_height, _width, textProvider.wilayaHint(), "wilaya",textProvider.isFrench, wilaya,commune),
                                  container(_height, _width, textProvider.communeHint(), "commune",textProvider.isFrench, commune),
                                ],
                              ),
                            ),
                          ),
                        ),

                        submitButton(_height, _width,_saveFields,textProvider.envDemande())
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

  Widget container(double height, double width, String hintText, String fieldName, bool isFrench, [FocusNode currentNode, FocusNode nextNode]){
    return Container(
      // height: (height * 0.85) /13,
      width: width,
      // color: Colors.red,
      margin: EdgeInsets.symmetric(
        horizontal: width * 0.05,
        vertical: (height * 0.85) *0.00075
      ),
      child: Directionality(
        textDirection: isFrench? TextDirection.ltr : TextDirection.rtl,
        child: TextFormField(
          // textAlign: isFrench? TextAlign.left : TextAlign.right,
          focusNode: currentNode,

          cursorColor: Theme.of(context).primaryColor,

          decoration: InputDecoration(

            hintText: hintText,

            hintStyle: Theme.of(context).textTheme.headline6.copyWith(
              // color: Theme.of(context).primaryColor,
            ),
                                      
          ),

          onFieldSubmitted: (_){
            FocusScope.of(context).requestFocus(nextNode);// move to the other textfield
          },

          validator: (value){
            if(value.isEmpty) return isFrench? "Veuillez Introduire Une valeur Valide" : "الرجاء إدخال قيمة صالحة";
            return null;
          },

          onSaved: (value){
            this.values[fieldName] = value;
          },

          keyboardType: (fieldName.contains("tel")) ? TextInputType.phone : fieldName.contains("email") ? TextInputType.emailAddress  : TextInputType.text,
          textInputAction: fieldName.contains("commune")? TextInputAction.done : TextInputAction.next,
        ),
      ),
    );
  }

  Widget submitButton(double height, double width, Function handler,String text){
    return GestureDetector(
      onTap: handler,
      child: Container(

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
          child: Text(text, style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
        ),

      ),
    );
  }
}
