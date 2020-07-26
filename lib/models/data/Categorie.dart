
import 'package:flutter/foundation.dart';

class Categorie with ChangeNotifier{
  final String id;
  final String nom;

  Categorie({@required this.id, @required this.nom});
}