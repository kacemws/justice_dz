
import 'package:flutter/material.dart';
import 'package:justice_dz/models/Justicedz.dart';
import 'package:provider/provider.dart';

class Favourites extends StatelessWidget {
  


  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<Justicedz>(context, listen: false);

    return LayoutBuilder(

      builder: (_,constraints)=>Container(

        width: constraints.maxWidth,
        height: constraints.maxHeight,
        color: Colors.white,

        child: Column(      
          children: <Widget>[

            space(context),
            space(context),//0.05

          ],
        ),
      ),
    );
  }

  Widget space(BuildContext context){
    return SizedBox(
      height: (MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - MediaQuery.of(context).padding.bottom)*0.025
    );
  }

  Widget title(BuildContext context, String text, BoxConstraints constraints){
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: constraints.maxWidth *0.05,
        vertical: constraints.maxHeight *0.01
      ),
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: Theme.of(context).textTheme.display1.copyWith(
          color: Colors.black,
          fontWeight: FontWeight.bold
        ),
      ),
    );
  }

}