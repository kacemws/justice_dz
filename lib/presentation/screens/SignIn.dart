import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:justice_dz/models/Texts.dart';
import 'package:justice_dz/models/auth.dart';
import 'package:justice_dz/presentation/screens/Profile.dart';
import 'package:justice_dz/presentation/tools/CustomDrawer.dart';

import 'package:provider/provider.dart';

import 'SignupScreen.dart';

import '../../models/HttpException.dart';

class SignIn extends StatefulWidget {
  static final route = "/sign-in";
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final passwordField = FocusNode(); //to move to the other textfield
  var _hidePassword = true; // to control wheter we want to show the password or not
  var _isloading = false;

  var _userInfos = {
    "email" : "",
    "password" : ""
  };

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var _formKey = GlobalKey<FormState>(); // to control the form 

  void switchToggle(){ // function that changes to visibility of the password
    setState(() {
      _hidePassword = !_hidePassword;
    });
  }

  

  @override
  Widget build(BuildContext context) {
    var textProvider = Provider.of<Texts>(context);

    void _showErrorDialog(String message) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Erreur!'),
          content: Text(message),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            )
          ],
        ),
      );
    }

    Future<void> _saveFields() async{

      FocusScope.of(context).unfocus();
      var isValid = _formKey.currentState.validate();
      if(!isValid) return;
      
      _formKey.currentState.save();

      print(_userInfos["email"]+" : "+_userInfos["password"]);
      setState(() {
        _isloading = true;
      });
      try{
        await Provider.of<Auth>(context, listen: false).login(
          _userInfos['email'],
          _userInfos['password'],
        );
        var currentUser = FirebaseAuth.instance.currentUser;
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (ctx)=>ProfilePage(
            userId: currentUser.uid,
          ))
        );

      } on HttpException catch(error){
        var errorMessage = 'Authentication failed';

        if (error.toString().contains('INVALID_EMAIL')) {
          errorMessage = 'Email Invalide.';
        } else if (error.toString().contains('ERROR_USER_NOT_FOUND')) {
          errorMessage = 'Email non trouvé.';
        } else if (error.toString().contains('ERROR_WRONG_PASSWORD')) {
          errorMessage = 'Mot De Passe Invalide.';
        }
        _showErrorDialog(errorMessage);
      } catch(error){
        const errorMessage = 'Could not authenticate you. Please try again later.';
        _showErrorDialog(errorMessage);
      }
      setState(() {
        _isloading = false;
      });
    
    }
    var _appBar = AppBar(
      title: Text(textProvider.profil()),
      centerTitle: true,
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
                    key : _formKey,
                    child: Column(

                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[

                        Directionality(
                          textDirection: textProvider.isFrench? TextDirection.ltr : TextDirection.rtl,
                          child: TextFormField(
                            // textAlign: textProvider.isFrench? TextAlign.left : TextAlign.right,
                            cursorColor: Theme.of(context).primaryColor,

                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.5),
                              hintText: textProvider.email(),
                              hintStyle: Theme.of(context).textTheme.headline6,

                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                  width: 1.5
                                )
                              )
                            ),

                            onFieldSubmitted: (_){
                              FocusScope.of(context).requestFocus(passwordField); // move to the other textfield
                            },

                            validator: (value){
                              if(!value.contains("@") || value.isEmpty) return textProvider.errEmail();
                                return null;
                            },

                            onSaved: (value){
                              _userInfos["email"] = value;
                            },

                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,                
                                              
                          ),
                        ),

                        SizedBox(
                          height: _height * 0.015,
                        ),

                        Directionality(
                          textDirection: textProvider.isFrench? TextDirection.ltr : TextDirection.rtl,
                          child: TextFormField(
                            // textAlign: textProvider.isFrench? TextAlign.left : TextAlign.right,
                            cursorColor: Theme.of(context).primaryColor,
                            
                            decoration: InputDecoration(
                              
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.5),
                              hintText: textProvider.mtp(),
                              hintStyle: Theme.of(context).textTheme.headline6,

                              suffixIcon: IconButton(
                                color: Theme.of(context).primaryColor,
                                icon: Icon(_hidePassword? Icons.visibility_off : Icons.visibility ), 
                                onPressed: switchToggle
                              ),

                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                  width: 1.5
                                )
                              )
                                        
                            ),

                            focusNode: passwordField,

                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.visiblePassword,

                            obscureText: _hidePassword,

                            validator: (value){
                              return value.isEmpty? textProvider.errMtp() : null;
                            },

                            onFieldSubmitted: (_)=>_saveFields(),

                            onSaved: (value){
                              _userInfos["password"] = value;
                            },                      

                          ),
                        ),

                        SizedBox(
                          height: _height * 0.02,
                        ),

                        Container(
                          margin: EdgeInsets.symmetric(vertical: _height * 0.0075, horizontal: _width * 0.05),
                          width: _width * 0.55,
                          child: _isloading? Center(child: CircularProgressIndicator()) :GestureDetector(
                            onTap: _saveFields,
                            child: Container(

                              height: _height * 0.1,
                                // width: _width * 0.5,

                              margin: EdgeInsets.symmetric(
                                horizontal: _width *0.05,
                                vertical: _height *0.01
                              ),

                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.75),
                                borderRadius: BorderRadius.circular(10),
                              ),

                              alignment: Alignment.center,
                              child: FittedBox(
                                fit: BoxFit.scaleDown, 
                                child: Text( 
                                 textProvider.seCon(), 
                                  style: Theme.of(context).textTheme.headline6.copyWith(
                                    // color: Theme.of(context).primaryColor
                                  ),
                                )
                              ),
                            ),
                          )
                        ),

                        Container(
                          margin: EdgeInsets.symmetric(vertical: _height * 0.0075, horizontal: _width * 0.05),
                                            
                          width: _width * 0.55,
                          height: _height*0.05,
                          child: SizedBox(),

                        ),

                        Container(
                          height: _height *0.1,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.75),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                textProvider.isFrench? textProvider.pum() : textProvider.inscrivezVous(),
                                style: TextStyle(fontSize: 20,fontWeight: FontWeight.w300),
                              ),

                              GestureDetector(
                                onTap: ()=>Navigator.of(context).pushNamed(
                                  SignupScreen.route,
                                ),

                                child:Text(
                                  !textProvider.isFrench? textProvider.pum() : textProvider.inscrivezVous(),
                                  style: TextStyle(fontSize: 20,fontWeight: FontWeight.w300,color: Theme.of(context).primaryColor)
                                ),

                              )
                            ],
                          ),
                        )
                      ]
                    )
                  ),
                ),
              ],
            ),
          )
        ),
      ),
    );
  }
}
