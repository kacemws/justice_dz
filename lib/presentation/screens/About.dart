

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:justice_dz/presentation/tools/CustomDrawer.dart';

class About extends StatelessWidget {
  static final route = "/about";
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {

    var _appBar = AppBar(
      centerTitle: true,
      title: Text("A propos"),
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
          width: _width,

          child: Stack(
              children: <Widget>[

              Image.asset(
                "assets/justice-b.jpg",
                height: _height * 1,
                width: _width,
                fit: BoxFit.cover,
              ),

              Container(

                width: _width,
                height: _height,
                
                margin: EdgeInsets.symmetric(
                  horizontal: _width * 0.05,
                  vertical: _height *0.025
                ),

                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.75),
                  borderRadius: BorderRadius.circular(15)
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[

                    Container(
                      height: _height *0.6,
                      width: _width,

                      margin: EdgeInsets.symmetric(
                        horizontal: _width * 0.05,
                        vertical: _height *0.005
                      ),

                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(0.75),
                        borderRadius: BorderRadius.circular(7.5)
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "Details",
                        style: Theme.of(context).textTheme.headline5.copyWith(
                          color: Colors.white
                        ),
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        FaIcon(
                          FontAwesomeIcons.facebookF,
                          color: Theme.of(context).primaryColor
                        ),
                        FaIcon(
                          FontAwesomeIcons.instagram,
                          color: Theme.of(context).primaryColor
                        ),
                      ],
                    )

                  ],
                ),

              ),

            ],
          ),
        )
      )
    );
  }


}