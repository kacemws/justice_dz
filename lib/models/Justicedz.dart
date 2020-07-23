/*Class that acts as a provider between the bl and the front end, containts all methods and objects.*/

import 'package:flutter/foundation.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import './data/Person.dart';
import './data/Wilaya.dart';


class Justicedz with ChangeNotifier{
  String userId;
  bool loaded = false;

  final Firestore _db = Firestore.instance;

  List<Wilaya> wilayas = [];

  List<Person> peoples = [];


  List<Wilaya> allWilayas(){
    return wilayas;
  }

  List<Person> allPeople(){
    return peoples;
  }


  Person getPersonById(String id){
    return peoples.firstWhere((person)=>person.id == id, orElse: ()=>null);
  }

  Wilaya getWilayaById(String id){
    return wilayas.firstWhere((wilaya)=>wilaya.id == id, orElse:()=> null);
  }
  
  

  Future<void> fetchData() async{

    await this.fetchWilayas();
    print("got wilayas");

    await this.fetchPeople();
    print("got people");

    loaded = true;
    print("done");

    notifyListeners();
    
  }

  Future<void> fetchWilayas() async{
    //TODO
  }

  Future<void> fetchPeople() async{
    var snapshot = await _db.collection("People").getDocuments();
    snapshot.documents.forEach((document) async {
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
        wilaya: null
      );
      print("got : " + aux.id);
      peoples.add(aux);
    });
  }



}