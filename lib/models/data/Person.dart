
import 'package:flutter/foundation.dart';
import 'package:justice_dz/models/data/Categorie.dart';
import 'package:justice_dz/models/data/Wilaya.dart';

class Adresse{
  final double lat;
  final double long;
  final String adresse;
  Adresse({@required this.lat, @required this.long, @required this.adresse});
}

class Person with ChangeNotifier{
  final String id;
  final String nom;
  final String prenom;
  final Adresse adresse;
  final String numPhone;
  final String email;
  final String horaire;

  final Wilaya wilaya;
  final Categorie categorie;
  Person({@required this.id, @required this.nom, @required this.prenom, @required this.email, @required this.numPhone, @required this.adresse, @required this.horaire, @required this.wilaya, @required this.categorie});
}