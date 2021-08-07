
import 'package:flutter/foundation.dart';
import 'package:justice_dz/models/data/Wilaya.dart';

class Commune{
  final String id;
  final String nom;
  final Wilaya wilaya;
  final String nomAr;
  Commune({@required this.id, @required this.nom, @required this.wilaya, @required this.nomAr});
}