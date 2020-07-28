
import 'package:flutter/material.dart';
import 'package:justice_dz/models/Justicedz.dart';
import 'package:justice_dz/models/data/Person.dart';
import 'package:justice_dz/presentation/items/PersonItem.dart';
import 'package:provider/provider.dart';

class Favourites extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    
    var provider = Provider.of<Justicedz>(context, listen: false);
    var people = provider.favorites;

    return LayoutBuilder(

      builder: (_,constraints)=>Container(

        width: constraints.maxWidth,
        height: constraints.maxHeight,
        color: Colors.grey[200],

        child: Column(      
          children: <Widget>[

            space(context), //2.5%
            people.length != 0? listOfPeople(context, constraints, people) : Expanded(child:Center(
              child: Text("Aucun element trouvé...", style: Theme.of(context).textTheme.subtitle1,),
            ))
           

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
      // color: Colors.amber,
      height: constraints.maxHeight * 0.105,

      margin: EdgeInsets.symmetric(
        horizontal: constraints.maxWidth *0.05,
        vertical: constraints.maxHeight *0.01
      ),

      alignment: Alignment.topLeft,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          text,
          style: Theme.of(context).textTheme.subtitle1.copyWith(
            color: Colors.black,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }

  Widget listOfPeople(BuildContext context, BoxConstraints constraints, List<Person> people){

    return Container(

      height: constraints.maxHeight *0.84,
      width: double.infinity,
      color: Colors.grey[200],
      child:  ListView.builder(

        physics: BouncingScrollPhysics(),

        itemCount: people.length,
        itemBuilder: (_,index)=>Container(
          color: Colors.grey[200],
          height: constraints.maxHeight *0.4,
          width: double.infinity,

          margin: EdgeInsets.symmetric(
            horizontal: constraints.maxWidth *0.05,
            vertical: constraints.maxHeight *0.0125
          ),

          child: ChangeNotifierProvider.value(
            value: people[index],
            child: PersonItem()
          ),
        )
      ),
    );
  }

}