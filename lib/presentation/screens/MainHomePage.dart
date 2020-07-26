

import 'package:flutter/material.dart';
import 'package:justice_dz/presentation/tools/BottomNavigation.dart';
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
    var _appBar = AppBar(
      title: Text("Justice DZ"),
      centerTitle: true,
      elevation: 3,
    );
    var _height = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - MediaQuery.of(context).padding.bottom - _appBar.preferredSize.height;

    return SafeArea(

      top: true,
      right : true,
      bottom: true,
      left:true,

      child: Scaffold(
        drawer: CustomDrawer(),
        appBar: _appBar,
        body: Center(
          child: Consumer<Justicedz>(
            builder: (context, wasseli,_) {
              if(wasseli.loaded) return Container(
                height: _height *0.9,
                width: double.infinity,
                child: bodyBuilder()              
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