
import 'package:flutter/material.dart';
import 'package:justice_dz/models/Justicedz.dart';
import 'package:justice_dz/models/Texts.dart';
import 'package:justice_dz/models/data/Person.dart';
import 'package:provider/provider.dart';

import 'PersonDetails.dart';

class HomePage extends StatelessWidget {
  


  @override
  Widget build(BuildContext context) {
    
    var provider = Provider.of<Justicedz>(context, listen: false);
    var textProvider = Provider.of<Texts>(context);
    var people = provider.customList();

    return LayoutBuilder(

      builder: (_,constraints)=>Container(

        width: constraints.maxWidth,
        height: constraints.maxHeight,
        // color: Colors.grey[200],

        child: Column(      
          children: people.length != 0? [
            title(context,textProvider.resultats(people.length), constraints),//12.5%
            listOfPeople(context, constraints, people, textProvider)
          ] : [
            Expanded(child:Center(
                child: Text("Aucun element trouvé...", style: Theme.of(context).textTheme.headline6,),
              )
            )
          ]
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
      color: Theme.of(context).primaryColor.withOpacity(0.5),
      height: constraints.maxHeight * 0.105,

      margin: EdgeInsets.only(
        bottom: constraints.maxHeight *0.01
      ),

      alignment: Alignment.center,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          text,
          style: Theme.of(context).textTheme.subtitle2.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }

  Widget listOfPeople(BuildContext context, BoxConstraints constraints, List<Person> people, Texts provider){

    return Container(

      height: constraints.maxHeight *0.84,
      width: constraints.maxWidth,
      
      margin: EdgeInsets.symmetric(
        vertical: constraints.maxHeight *0.01,
        horizontal: constraints.maxWidth*0.025
      ),

      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.6),
        borderRadius: BorderRadius.circular(10)
      ),

      child:  ListView.builder(

        physics: BouncingScrollPhysics(),

        itemCount: people.length,
        itemBuilder: (_,index)=>Container(

          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(5)
          ),
          height: constraints.maxHeight *0.15,
          width: double.infinity,

          margin: EdgeInsets.symmetric(
            horizontal: constraints.maxWidth *0.05,
            vertical: constraints.maxHeight *0.0125
          ),

          alignment: Alignment.center,

          child: ListTile(
            enabled: true,
            leading: Image.asset("assets/logoJustice.png", fit: BoxFit.scaleDown,),
            title: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                provider.nomPrenom(people[index].nom, people[index].prenom, people[index].nomAr, people[index].prenomAr), 
                style: Theme.of(context).textTheme.headline6.copyWith(
                  color: Colors.white
                ),
                textAlign: provider.isFrench? TextAlign.left : TextAlign.right,
              ),
            ),
            onTap: (){
              Navigator.of(context).pushNamed(
                PersonDetails.route,
                arguments: people[index].id
              );
            },
          ),


        )
      ),
    );
  }

}