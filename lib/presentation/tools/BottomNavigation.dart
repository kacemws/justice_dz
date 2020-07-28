
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';


class BottomNavigation extends StatelessWidget {
  final int current;
  final Function handler;

  BottomNavigation({@required this.current, @required this.handler});  

  final Map<int, Color> color =
  {
    50:Color.fromRGBO(24, 134, 135, 0.1),
    100:Color.fromRGBO(24, 134, 135, 0.2),
    200:Color.fromRGBO(24, 134, 135, 0.3),
    300:Color.fromRGBO(24, 134, 135, 0.4),
    400:Color.fromRGBO(24, 134, 135, 0.5),
    500:Color.fromRGBO(24, 134, 135, 0.6),
    600:Color.fromRGBO(24, 134, 135, 0.7),
    700:Color.fromRGBO(24, 134, 135, 0.8),
    800:Color.fromRGBO(24, 134, 135, 0.9),
    900:Color.fromRGBO(24, 134, 135, 1),
  };

  @override
  Widget build(BuildContext context) {

    MaterialColor colorCustom = MaterialColor(0xFF188687, color);

    return LayoutBuilder(

      builder: (_,constraints)=>Container(
        
        decoration: BoxDecoration(
          color: Colors.white, 
          boxShadow: [BoxShadow(
            blurRadius: 20, 
            color: Colors.black.withOpacity(.1)
          )]
        ),

        width: double.infinity,
        height: (MediaQuery.of(context).size.height <= 75)?constraints.maxHeight*0.95 : 55,

        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            //crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              navItem("Home",0,colorCustom),
              navItem("Fav",1,colorCustom),
            ],
          ),
        ),
      ),

    );

  }
  Widget navItem(String name,int index, MaterialColor colorCustom){
    return Flexible(
      flex: 1,
      fit: FlexFit.tight,
      child : Stack(
        children : [

          AnimatedContainer(
            duration: Duration(milliseconds: 500),
            height :5,
            alignment: Alignment.topCenter,
            color: index == current?colorCustom : Colors.white,
          ),

          GestureDetector(

            onTap: (){
              handler(index);
            },

            child : Container(
              width: double.infinity,
              alignment: Alignment.center,
              child: AspectRatio(
                aspectRatio: 1,
                child: FlareActor(
                  "assets/$name.flr",
                  alignment: Alignment.center,
                  fit: BoxFit.contain,
                  // animation: index == current? "go" : "idle",
                ),
              ),
            )
          )
        ]
      )
    );
  }
}

