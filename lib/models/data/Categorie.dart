
import 'package:flutter/foundation.dart';

class Categorie with ChangeNotifier{
  final String id;
  final String nom;
  final String nomAr;
  Categorie({@required this.id, @required this.nom, @required this.nomAr});
}