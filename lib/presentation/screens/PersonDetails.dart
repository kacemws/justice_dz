
import 'package:flutter/material.dart';
import 'package:justice_dz/models/Justicedz.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class PersonDetails extends StatelessWidget {

  static final String route = "/person-details";

  @override
  Widget build(BuildContext context) {

    var personId = ModalRoute.of(context).settings.arguments as String;
    var provider = Provider.of<Justicedz>(context);

    var person = provider.getPersonById(personId);
    var isFavorite = provider.favorites.contains(person);

    var _appBar = AppBar(
      title: Text("Justice DZ"),
      centerTitle: true,
      elevation: 3,
      actions: <Widget>[
        IconButton(
          icon: Icon(isFavorite? Icons.favorite : Icons.favorite_border), 
          onPressed: () async{
            await provider.addToFavs(personId);
          }
        )
      ],
    );

    var _height = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.vertical - _appBar.preferredSize.height;
    var _width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: _appBar,

      backgroundColor: Colors.grey[100],

      body: SingleChildScrollView(
        child: Container(
          height: _height,
          width: _width,
          child: Column(

            children: <Widget>[

              Hero(
                tag: person.id,
                child: Image.asset(
                  "assets/logoJustice.png",
                  height: _height *0.3,
                  width: double.infinity,
                  fit: BoxFit.scaleDown,
                ),
              ),
              title("Docteur " + person.nom + " " + person.prenom, _height, _width, context, Alignment.center,false),
              space(_height * 0.05),

              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[

                  title("Adresse : ", _height, _width, context, Alignment.centerLeft,false),

                  Container(
                    // width: _width *0.65,
                    child: title(person.adresse.adresse, _height, _width, context, Alignment.centerLeft,true)
                  ),

                  Expanded(child: SizedBox()),

                  IconButton(
                    icon: Icon(Icons.explore), 
                    onPressed: (){
                      launch("https://www.google.com/maps/search/?api=1&query=${person.adresse.lat},${person.adresse.long}");
                    }
                  ),

                ],
              ),

              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[

                  title("N°Telephone : ", _height, _width, context, Alignment.centerLeft,false),

                  Container(
                    // width: _width *0.65,
                    child: title(person.numPhone, _height, _width, context, Alignment.centerLeft,true)
                  ),

                  Expanded(child: SizedBox()),

                  IconButton(
                    icon: Icon(Icons.phone), 
                    onPressed: (){
                      launch("tel:"+person.numPhone);
                    }
                  ),

                ],
              ),

              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[

                  title("E-mail : ", _height, _width, context, Alignment.centerLeft,false),

                  Container(
                    // width: _width *0.65,
                    child: title(person.email, _height, _width, context, Alignment.centerLeft,true)
                  ),

                  Expanded(child: SizedBox()),

                  IconButton(
                    icon: Icon(Icons.mail), 
                    onPressed: (){
                      launch("mailto:"+person.email+"?subject=Reservation&body=");
                    }
                  ),

                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[

                  title("Horaire d'ouverture : ", _height, _width, context, Alignment.centerLeft,false),

                  Container(
                    // width: _width *0.65,
                    child: title(person.horaire, _height, _width, context, Alignment.centerLeft,true)
                  ),
                ],
              ),

              Expanded(child: SizedBox()),
              followButton(_height, _width, context, person.email),
              space(_height * 0.025)

            ],

          ),
        ),
      ),
    );

  }

  Widget title(String text, double height, double width, BuildContext context, AlignmentGeometry alignment, bool info){
    return Container(

      width: info? width*0.4 : null,

      height: height *0.07,

      margin: EdgeInsets.symmetric(
        horizontal: info? 0 : width *0.05,
        vertical: height *0.005
      ),

      alignment: alignment,
      child: FittedBox(
        fit:BoxFit.scaleDown,
        child: Text(
          text,
          style: Theme.of(context).textTheme.headline6.copyWith(
            fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }

  Widget space(double height){
    return SizedBox(
      height: height,
    );
  }

  Widget followButton(double _height, double _width, BuildContext context, String email){
    return GestureDetector(
      
      onTap: (){
        launch("mailto:"+email+"?subject=Reservation&body=");
      },

      child: Container(

        height: _height * 0.1,

        margin: EdgeInsets.symmetric(
          horizontal: _width *0.05,
          vertical: _height * 0.0125
        ),

        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(10),
          boxShadow: [

            BoxShadow(
              blurRadius: 5,
              color: Colors.black38,
              offset: Offset(2.5, 2.5)
            ),
            BoxShadow(
              blurRadius: 5,
              color: Colors.white60,
              offset: -Offset(2.5, 2.5)
            ),
          ]
        ),

        child: Center(child: Text( "Reserver", style: Theme.of(context).textTheme.headline6,)),

      ),
    );
  }

}