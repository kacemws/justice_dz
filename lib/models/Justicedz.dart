/*Class that acts as a provider between the bl and the front end, containts all methods and objects.*/

import 'package:flutter/foundation.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import './data/Categorie.dart';
import './data/Person.dart';
import './data/Wilaya.dart';
import 'data/Commune.dart';


class Justicedz with ChangeNotifier{
  String userId;
  bool loaded = false;

  final Firestore _db = Firestore.instance;

  SharedPreferences prefs ;

  List<Wilaya> wilayas = [
    Wilaya(id: "all", nom: "Toute l'Algérie")
  ];

  List<Categorie> categories = [
    Categorie(id : "all", nom: "Tous"),
    Categorie(id : "c1", nom:"Expert"),
    Categorie(id : "c2", nom: "Avocat"),
    Categorie(id : "c3", nom:"Notaire"),
    Categorie(id: "c4", nom: "Huissier de justice"),
    Categorie(id : "c5", nom:"Municipale"),
  ];

  Wilaya selectedWilaya;
  Categorie selectedCategorie;
  Commune selectedCommune;

  String keywords = "";

  List<Person> peoples = [];


  List<Wilaya> allWilayas(){
    return wilayas;
  }

  List<Categorie> allCategories(){
    return categories;
  }

  List<Person> allPeople(){
    print(peoples.length);
    return peoples;
  }

  List<Person> favorites = [];
  
  List<Person> customList(){

    List<Person> aux = [];

    if(keywords != ""){
      peoples.forEach((person){
        if(("maitre " + person.nom.toLowerCase()+ " "+ person.prenom.toLowerCase()).contains(keywords.toLowerCase())) aux.add(person);
      });
      return aux;
    }


    print("doing a check");
    print(selectedCategorie.id);
    print(selectedWilaya.id);

    if(selectedCategorie == getCategorieById("all") && selectedWilaya == getWilayaById("all")){
      return allPeople();
    }

    print("not all selected");

    if(selectedCategorie == getCategorieById("all")){

      peoples.forEach((person){
        if(person.wilaya == selectedWilaya){
          if(selectedCommune.nom == "Tous" || person.commune == selectedCommune)
            aux.add(person);
        }
      });
      print("all cats selected");
    }else if(selectedWilaya == getWilayaById("all")){

      peoples.forEach((person){
        if(person.categorie == selectedCategorie) aux.add(person);
      });
      print("all wilayas selected");
    }else{

      peoples.forEach((person){
        if(person.wilaya == selectedWilaya && person.categorie == selectedCategorie){
          if(selectedCommune.nom == "Tous" || person.commune == selectedCommune)
            aux.add(person);
        }
      });
      print("customs selected");
    }
    print("returning");
    return aux;

  }

  Person getPersonById(String id){
    return peoples.firstWhere((person)=>person.id == id, orElse: ()=>null);
  }

  Wilaya getWilayaById(String id){
    return wilayas.firstWhere((wilaya)=>wilaya.id == id, orElse:()=> null);
  }

  Categorie getCategorieById(String id){
    return categories.firstWhere((categorie)=>categorie.id == id, orElse:()=> null);
  }

  Commune getCommuneByIdAndWilaya(String wilaya, id){
    if(getWilayaById(wilaya) == null) return null;
    return getWilayaById(wilaya).communes.firstWhere((commune)=>commune.id == id, orElse:()=> null);
  }

  Future<void> fetchData() async{
    prefs = await SharedPreferences.getInstance();
    loaded = false;
    notifyListeners();

    await this.fetchWilayas();
    print("got wilayas");

    await this.fetchCommunes();
    print("got Communes");

    await this.fetchPeople();
    print("got people");
    this.fetchFavs();
    loaded = true;
    print("done");

    notifyListeners();
    
  }

  Future<void> fetchWilayas() async{
    var snapshot = await _db.collection("Wilaya").getDocuments();
    wilayas.clear();

    wilayas.add(
      Wilaya(id: "all", nom: "Tous")
    );

    snapshot.documents.forEach((document){

      var data = document.data;

      var aux = Wilaya(
        id: document.documentID, 
        nom: data["nom"], 
      );

      print("got : " + aux.id);

      wilayas.add(aux);
      
    });
  }

  Future<void> fetchCommunes() async{
    var snapshot = await _db.collection("Communes").getDocuments();

    wilayas.forEach((wilaya){
      wilaya.communes = [];
      wilaya.communes.add(
        Commune(
          id: wilaya.id+"_all", 
          nom: "Tous", 
          wilaya: wilaya
        )
      );
    });

    snapshot.documents.forEach((document){

      var data = document.data;

      var aux = Commune(
        id: document.documentID, 
        nom: data["nom"], 
        wilaya: getWilayaById(data["wilaya"])
      );

      print("got : " + aux.id);

      aux.wilaya.communes.add(aux);
      
    });
  }

  Future<void> fetchPeople() async{

    var snapshot = await _db.collection("People").getDocuments();
    peoples.clear();
    snapshot.documents.forEach((document){

      var data = document.data;

      var adresse = Adresse(
        lat: data["adresse"]["lat"], 
        long: data["adresse"]["long"], 
        adresse: data["adresse"]["adresse"]
      );

      var aux = Person(
        id: document.documentID, 
        nom: data["nom"], 
        prenom: data["prenom"], 
        email: data["email"], 
        numPhone: data["numPhone"], 
        adresse: adresse, 
        horaire: data["horaire"], 
        wilaya: getWilayaById(data["wilaya"]),
        commune: getCommuneByIdAndWilaya(data["wilaya"],data["commune"]),
        categorie: getCategorieById(data["categorie"])
      );

      print("got : " + aux.id);

      peoples.add(aux);

    });
  }

  void fetchFavs(){
    var favs = prefs.getStringList("favorites") ?? [];
    favorites.clear();
    favs.forEach((fav){
      favorites.add(getPersonById(fav));
    });
  }

  Future<void> addToFavs(String id) async{
    var person = getPersonById(id);

    if(favorites.contains(person)){

      favorites.remove(person);
    }else{
      favorites.add(person);
    }
    List<String> ids = [];

    favorites.forEach((fav){
      ids.add(fav.id);
    });

    await prefs.setStringList("favorites", ids);
    notifyListeners();
  }

  Future<void> sendSupport({Map<String,String> infos}) async{
    final url = 'https://us-central1-justice-dz.cloudfunctions.net/sendSupport?name='+infos["name"]+'&email='+infos["email"]+'&object='+infos["object"]+'&message='+infos["message"];
    try{
      final resp = await http.post(
        url
      );
      print(resp.body);
    }catch (error){
      print(error);
    }
  }

  Future<void> sendSignup({Map<String,String> values}) async{
    final url = 'https://us-central1-justice-dz.cloudfunctions.net/sendSignup?'+
    "nom=" + values["nom"]+
    "&prenom=" + values["prenom"]+
    "&tel=" + values["tel"]+
    "&adresse=" + values["adresse"]+
    "&email=" + values["email"]+
    "&specialite=" + values["spécialité"]+
    "&horaire=" + values["horaire"]+
    "&details=" + values["details"]+
    "&wilaya=" + values["wilaya"]+
    "&commune=" + values["commune"];

    try{
      final resp = await http.post(
        url
      );
      print(resp.body);
    }catch (error){
      print(error);
    }
  }

  Future<void> updateUser(Person updated) async{
    await _db.collection("People").document(updated.id).updateData({
      "nom" : updated.nom,
      "prenom" : updated.prenom,
      "numPhone" : updated.numPhone,
      "horaire" : updated.horaire,
      "adresse" : {
        "adresse" : updated.adresse.adresse,
        "lat" : updated.adresse.lat,
        "long" : updated.adresse.long
      }
    });
    peoples[peoples.indexOf(getPersonById(updated.id))] = updated;

  }



}