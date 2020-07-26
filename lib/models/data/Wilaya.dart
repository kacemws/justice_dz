
import 'package:flutter/foundation.dart';
import 'package:justice_dz/models/data/Commune.dart';

class Wilaya{
  final String id;
  final String nom;
  List<Commune> communes;

  Wilaya({@required this.id, @required this.nom}){
    this.communes = [];
  }
  
}