

import 'package:flutter/material.dart';
import 'package:justice_dz/models/Justicedz.dart';
import 'package:justice_dz/presentation/tools/CustomDrawer.dart';
import 'package:provider/provider.dart';

class ContactUs extends StatefulWidget {
  static final route = "/contact-us";
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  final FocusNode emailNode = FocusNode();
  final FocusNode objetNode = FocusNode();
  final FocusNode messageNode = FocusNode();
  bool loading = false;

  var userInfos = {
    "email" : "",
    "name" : "",
    "object" : "",
    "message" : ""
  };

  
  
  @override
  Widget build(BuildContext context) {

    var provider = Provider.of<Justicedz>(context);
    
    Future<void> _saveFields() async{

      FocusScope.of(context).unfocus();

      var isValid = _formKey.currentState.validate();

      if(!isValid) return;
        
      _formKey.currentState.save();

      setState(() {
        loading = true;
      });

      print("sent by ${userInfos["name"]} from email : ${userInfos["email"]} object : ${userInfos["object"]} holding : ${userInfos["message"]}");
        
      try{
        await provider.sendSupport(infos: userInfos);
        print("sent message");

        setState(() {
          loading = false;
        });

      }catch (error){
        print('Message not sent.');
        print(error);
        setState(() {
          loading = false;
        });
      }
    }


    var _appBar = AppBar(
      title: Text("Contactez-nous"),
      centerTitle: true,
    );

    var _height = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - MediaQuery.of(context).padding.bottom - _appBar.preferredSize.height;
    var _width = MediaQuery.of(context).size.width;

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
          width : _width,

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
                  height: _height,
                  width: _width,
                  margin: EdgeInsets.symmetric(
                    horizontal: _width *0.05
                  ),
                  
                  child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[

                          SizedBox(
                            height: _height *0.1,
                          ),


                          TextFormField(
                            cursorColor: Theme.of(context).primaryColor,

                            decoration: InputDecoration(
                              labelText: "Votre nom *",
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.5),

                              labelStyle: Theme.of(context).textTheme.headline6.copyWith(
                                // color: Theme.of(context).primaryColor,
                              ),
                              
                              border: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                  width: 2
                                )
                              )
                            ),

                            onFieldSubmitted: (_){
                              FocusScope.of(context).requestFocus(emailNode);
                            },

                            validator: (value){
                              if(value.isEmpty) return "Veuillez Introduire Un Nom Valide";
                              return null;
                            },

                            onSaved: (value){
                              userInfos["name"] = value;
                            },

                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            
                          ),

                          SizedBox(
                            height: _height *0.025,
                          ),

                          TextFormField(
                            cursorColor: Theme.of(context).primaryColor,
                            focusNode: emailNode,
                            decoration: InputDecoration(
                              labelText: "Votre adresse de messagerie *",
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.5),

                              labelStyle: Theme.of(context).textTheme.headline6.copyWith(
                                // color: Theme.of(context).primaryColor,
                              ),

                              border: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                  width: 2
                                )
                              )
                            ),

                            onFieldSubmitted: (_){
                              FocusScope.of(context).requestFocus(objetNode);
                            },

                            validator: (value){
                              if(value.isEmpty || !(value.contains("@"))) return "Veuillez Introduire Un Email Valide";
                              return null;
                            },

                            onSaved: (value){
                              userInfos["email"] = value;
                            },

                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            
                          ),

                          SizedBox(
                            height: _height *0.025,
                          ),

                          TextFormField(
                            cursorColor: Theme.of(context).primaryColor,
                            focusNode: objetNode,
                            decoration: InputDecoration(
                              labelText: "Objet",
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.5),

                              labelStyle: Theme.of(context).textTheme.headline6.copyWith(
                                // color: Theme.of(context).primaryColor,
                              ),
                              
                              border: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                  width: 2
                                )
                              )
                            ),

                            onFieldSubmitted: (_){
                              FocusScope.of(context).requestFocus(messageNode);
                            },

                            validator: (value){
                              // if(value.isEmpty) return "Veuillez Introduire Un Nom Valide";
                              return null;
                            },

                            onSaved: (value){
                              userInfos["object"] = value;
                            },

                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            
                          ),
                          
                          SizedBox(
                            height: _height *0.025,
                          ),

                          TextFormField(
                            maxLines: null,
                            minLines: 8,
                            focusNode: messageNode,
                            cursorColor: Theme.of(context).primaryColor,

                            decoration: InputDecoration(
                              alignLabelWithHint: true,
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.5),
                              labelText: "Votre message",
                              labelStyle: Theme.of(context).textTheme.headline6.copyWith(
                                // color: Theme.of(context).primaryColor,
                              ),
                                        

                              border: UnderlineInputBorder(
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
                              if(value.isEmpty) return "Veuillez Introduire Un Message Valide";
                              return null;
                            },

                            onSaved: (value){
                              userInfos["message"] = value;
                            },

                            keyboardType: TextInputType.multiline,
                            textInputAction: TextInputAction.send,

                          ),

                          callButton("Envoyer un email",_height, _width, _saveFields),

                        ],
                      ),
                    )
                  ),
                )

              ],
            ),
          ),
        ),
      ),

    );  
  }

  Widget callButton(String text, double _height, double _width, Function handler){
    return GestureDetector(
      onTap: handler,
      child: Container(

        height: _height * 0.1,
        width: _width * 0.65,

        margin: EdgeInsets.symmetric(
          horizontal: _width *0.05,
          vertical: _height *0.01
        ),

        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.85),
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        child: loading? CircularProgressIndicator() :  FittedBox(
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

  Widget title(BuildContext context, String text, double height, double width){
    return Container(
      height: height * 0.065,
      width: width *0.65,
      
      margin: EdgeInsets.symmetric(
        horizontal: width *0.05,
        vertical: height *0.01
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
            color: Colors.white,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }
}