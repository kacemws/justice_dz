

import 'package:flutter/material.dart';
import 'package:justice_dz/models/data/Categorie.dart';
import 'package:provider/provider.dart';



class CatItem extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    var cat = Provider.of<Categorie>(context);
    

    return LayoutBuilder(

      builder :(_,constraint)=>GestureDetector(
        onTap: (){
          //TODO
        },
        child: Container(
          height: constraint.maxHeight,
          width: constraint.maxWidth,
          

          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.5),
            borderRadius: BorderRadius.circular(10),
          ),
          
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Image.asset(
                "assets/logoJustice.png",
                height: constraint.maxHeight *0.4,
                fit: BoxFit.scaleDown,
              ),
              Text(
                cat.nom,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.title.copyWith(
                  color: Theme.of(context).primaryColor
                ),
              )
            ],
          ),

        ),
      ),
    );
  }

}


