/*Class that acts as a provider between the bl and the front end, containts all methods and objects.*/

import 'package:flutter/foundation.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:justice_dz/models/data/Categorie.dart';

import './data/Person.dart';
import './data/Wilaya.dart';


class Justicedz with ChangeNotifier{
  String userId;
  bool loaded = false;

  final Firestore _db = Firestore.instance;

  List<Wilaya> wilayas = [
    Wilaya(id: "all", nom: "Tous")
  ];

  List<Categorie> categories = [
    Categorie(id: "all", nom: "Tous")
  ];

  Wilaya selectedWilaya;
  Categorie selectedCategorie;

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
  
  List<Person> customList(){

    List<Person> aux = [];

    print("doing a check");
    if(selectedCategorie == getCategorieById("all") && selectedWilaya == getWilayaById("all")){
      return allPeople();
    }
    print("not all selected");

    if(selectedCategorie == getCategorieById("all")){

      peoples.forEach((person){
        if(person.wilaya == selectedWilaya) aux.add(person);
      });
      print("all cats selected");
    }else if(selectedWilaya == getWilayaById("all")){

      peoples.forEach((person){
        if(person.categorie == selectedCategorie) aux.add(person);
      });
      print("all wilayas selected");
    }else{

      peoples.forEach((person){
        if(person.wilaya == selectedWilaya && person.categorie == selectedCategorie) aux.add(person);
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
  
  

  Future<void> fetchData() async{

    await this.fetchWilayas();
    print("got wilayas");

    await this.fetchCategories();
    print("got categories");

    await this.fetchPeople();
    print("got people");

    loaded = true;
    print("done");

    notifyListeners();
    
  }

  Future<void> fetchWilayas() async{
    var snapshot = await _db.collection("Wilaya").getDocuments();

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

  Future<void> fetchCategories() async{
    var snapshot = await _db.collection("Categories").getDocuments();

    snapshot.documents.forEach((document){

      var data = document.data;

      var aux = Categorie(
        id: document.documentID, 
        nom: data["nom"], 
      );

      print("got : " + aux.id);

      categories.add(aux);
      
    });
  }

  Future<void> fetchPeople() async{

    var snapshot = await _db.collection("People").getDocuments();

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
        categorie: getCategorieById(data["categorie"])
      );

      print("got : " + aux.id);

      peoples.add(aux);

    });
  }



}