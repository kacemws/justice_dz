import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {

  const CustomAppBar({
    @required double width,
    @required double height,
    @required this.text,
    @required this.scaffoldKey
  }) : _width = width, _height = height;

  final double _width;
  final double _height;
  final String text;
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _width,
      height: _height *0.1,
      color: Theme.of(context).primaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,

        children: <Widget>[

          Container(
            width: _width *0.25,
            height: _height *0.1,
            alignment: Alignment.centerLeft,
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white), 
              onPressed: (){
                Navigator.of(context).pop();
              }
            ),
          ),

          Expanded(
            child: Center(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(text, style: Theme.of(context).textTheme.title.copyWith(color: Colors.white),),
              ),
            )
          ),

          Container(
            width: _width *0.25,
            height: _height *0.1,
            // color: Colors.white,

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                
                GestureDetector(
                  onTap: (){
                    scaffoldKey.currentState.openDrawer();
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.menu, color: Colors.white,),
                      Text("Menu",style: TextStyle(color:Colors.white),)
                    ],
                  ),
                ),

                GestureDetector(
                  onTap: (){

                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.place, color: Colors.white,),
                      Text("Plan",style: TextStyle(color:Colors.white),)
                    ],
                  ),
                ),


              ],
            ),
          ),
        ],

      ),
    );
  }
}