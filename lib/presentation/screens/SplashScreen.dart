

import 'dart:async';

import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/material.dart';
import 'package:justice_dz/models/Justicedz.dart';
import 'package:justice_dz/models/Texts.dart';
import 'package:justice_dz/presentation/screens/LandingPage.dart';
import 'package:provider/provider.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool loaded = false;
  bool french;
  final FlareControls controls = FlareControls();
  
  @override
  void initState() {

    super.initState();

    Future.delayed(Duration.zero).then((_) async {
      await Provider.of<Justicedz>(context, listen: false).fetchData().then((_){
        // Navigator.of(context).pushReplacement(
        //   MaterialPageRoute(builder: (ctx)=>LandingPage())
        // );
        setState(() {
          loaded = true;
        });
      });
    });

  }

  
  
  @override
  Widget build(BuildContext context) {
    print("build");

    Future<void> setLanguage() async{

      print("into language");
      try{
        Provider.of<Texts>(context, listen: false).isFrench = french;
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (ctx)=>LandingPage())
        );
      }catch (error){

      }
      print("call me up");
      
    }

    var _height = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - MediaQuery.of(context).padding.bottom;
    var _width = MediaQuery.of(context).size.width;
    return Scaffold(
      // backgroundColor: Colors.grey[50],
      body: Center(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Colors.grey[350],
                Colors.grey[50],
                Colors.grey[350],
              ]
            )
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[

              Container(
                height: _height *0.75,
                width: double.infinity,
                alignment: Alignment.center,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: FlareActor(
                    "assets/Logo.flr",
                    alignment: Alignment.center,
                    fit: BoxFit.contain,
                    controller: controls,
                    animation: loaded? "idle" : "go",
                  ),
                ),
              ),

              AnimatedOpacity(
                opacity: loaded? 1 : 0, 
                duration: Duration(microseconds: 350),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(

                      onTap: (){
                        setState(() {
                          french = true;
                        });
                        setLanguage();
                      },

                      child: AnimatedContainer(

                        width: _width *0.1,
                        height: _height*0.05,

                        margin: EdgeInsets.symmetric(
                          horizontal: _width *0.0125
                        ),

                        alignment: Alignment.center,

                        duration: Duration(microseconds: 200),

                        decoration: BoxDecoration(
                          border: Border.all(
                            style: BorderStyle.solid,
                            color: Colors.black,
                            width: 1
                          ),
                          borderRadius: BorderRadius.circular(10),
                          color: (french == null || !french )? Colors.white : Theme.of(context).primaryColor.withOpacity(0.25)
                        ),

                        child: Text("Fr")
                      ),
                    ),
                    GestureDetector(

                      onTap: (){
                        setState(() {
                          french = false;
                        });
                        setLanguage();
                      },

                      child: AnimatedContainer(

                        width: _width *0.1,
                        height: _height*0.05,

                        margin: EdgeInsets.symmetric(
                          horizontal: _width *0.0125
                        ),

                        alignment: Alignment.center,

                        duration: Duration(microseconds: 200),

                        decoration: BoxDecoration(
                          border: Border.all(
                            style: BorderStyle.solid,
                            color: Colors.black,
                            width: 1
                          ),
                          borderRadius: BorderRadius.circular(10),
                          color: (french == null || french )? Colors.white : Theme.of(context).primaryColor.withOpacity(0.25)
                        ),
                        
                        child: Text("عربى")
                      ),
                    )
                  ],
                )
                 
              )

            ],
          ),
        ),
      ),
    );
  }
}