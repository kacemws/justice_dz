

import 'package:flutter/material.dart';
import 'package:justice_dz/presentation/tools/BottomNavigation.dart';
import 'package:justice_dz/presentation/tools/CustomAppBar.dart';
import 'package:justice_dz/presentation/tools/CustomDrawer.dart';
import 'package:provider/provider.dart';

import 'package:justice_dz/models/Justicedz.dart';
import 'Favourites.dart';
import 'HomePage.dart';

class MainHomePage extends StatefulWidget {
  static final String route = "/main-screen";
  @override
  _MainHomePageState createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  int current;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  void initState() {

    super.initState();
    current = 0;

  }

  void changeIndex(index){
    setState(() {
      current = index;
      print(index);
    });
  }

  Widget bodyBuilder(){
    if(current == 0) return HomePage();
    return Favourites();
  }

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - MediaQuery.of(context).padding.bottom;
    var _width = MediaQuery.of(context).size.width;

    return SafeArea(

      top: true,
      right : true,
      bottom: true,
      left:true,

      child: Scaffold(
        key: _scaffoldKey,
        drawer: CustomDrawer(),
        body: Center(
          child: Consumer<Justicedz>(
            builder: (context, provider,_) {
              if(provider.loaded) return Stack(
                children: <Widget>[

                  Column(
                    children: <Widget>[

                      SizedBox(
                        width: _width,
                        height: _height *0.1,
                      ),

                      Image.asset(
                        "assets/justice-b.jpg",
                        height: _height *0.8,
                        width: _width,
                        fit: BoxFit.cover,
                      ),

                    ],
                  ),
                  
                  Column(
                    children: <Widget>[
                      CustomAppBar(width: _width, height: _height, text: provider.selectedCategorie != null? provider.selectedCategorie.nom : "Tous", scaffoldKey: _scaffoldKey),
                      Container(
                        height: _height *0.8,
                        width: double.infinity,
                        child: bodyBuilder()              
                      ),
                    ],
                  ),
                ],
              );
              return CircularProgressIndicator();
            }
          ),
        ),

        bottomNavigationBar: Container(
          height: _height *0.1,
          color: Colors.black,
          width: double.infinity,
          child: BottomNavigation(current: current, handler: changeIndex)
        ),
      ),
    );
  }
}