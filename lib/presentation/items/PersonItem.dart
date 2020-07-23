

import 'package:flutter/material.dart';
import 'package:justice_dz/models/data/Person.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';


class PersonItem extends StatelessWidget {

  Map<int, Color> color =
  {
    50:Color.fromRGBO(12, 92, 76, 0.1),
    100:Color.fromRGBO(12, 92, 76, 0.2),
    200:Color.fromRGBO(12, 92, 76, 0.3),
    300:Color.fromRGBO(12, 92, 76, 0.4),
    400:Color.fromRGBO(12, 92, 76, 0.5),
    500:Color.fromRGBO(12, 92, 76, 0.6),
    600:Color.fromRGBO(12, 92, 76, 0.7),
    700:Color.fromRGBO(12, 92, 76, 0.8),
    800:Color.fromRGBO(12, 92, 76, 0.9),
    900:Color.fromRGBO(12, 92, 76, 1),
  };
  
  @override
  Widget build(BuildContext context) {
    MaterialColor colorCustom = MaterialColor(0xFF0C5C4C, color);
    var person = Provider.of<Person>(context);
    

    return LayoutBuilder(

      builder :(_,constraint)=>Container(
        height: constraint.maxHeight,
        width: constraint.maxWidth,
        

        decoration: BoxDecoration(
          color: colorCustom,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              color: Colors.black38,
              offset: const Offset(5,5)
            ),
            BoxShadow(
              blurRadius: 10,
              color: Colors.white,
              offset: -Offset(5,5)
            ),
          ]
        ),
        
        child: Column(
          children: <Widget>[

            Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[

                Hero(
                  tag: "", 
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5),
                    ),

                    child: Image.asset(
                      "assets/logoJustice.png",
                      height: constraint.maxHeight *0.72,
                      width: double.infinity,
                      fit: BoxFit.scaleDown,
                    ),
                  )
                ),

                Text("Docteur " + person.prenom + " " + person.nom,style: Theme.of(context).textTheme.title.copyWith(
                  color: Colors.white
                ),),

                space(context)

              ],
            ),
            space(context),

            Container(

              height: constraint.maxHeight * 0.2,
              width: constraint.maxWidth,
              
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(5),
                  bottomRight: Radius.circular(5),
                )
              ),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[

                  IconButton(
                    icon: Icon(Icons.explore), 
                    onPressed: (){
                      launch("https://www.google.com/maps/search/?api=1&query=${person.adresse.lat},${person.adresse.long}");
                    }
                  ),
                  IconButton(
                    icon: Icon(Icons.mail), 
                    onPressed: (){
                      launch("mailto:"+person.email+"?subject=Reservation&body=");
                    }
                  ),
                  IconButton(
                    icon: Icon(Icons.phone), 
                    onPressed: (){
                      launch("tel:"+person.numPhone);
                    }
                  ),
                ],
              ),
            ),


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

}


