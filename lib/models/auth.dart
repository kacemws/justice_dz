import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import 'HttpException.dart';


class Auth with ChangeNotifier{



  
  Future<void> _authenticate( String email, String password, String urlSegment) async {

    
    try {

      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
           
    } catch (error) {
      print(error);
      throw HttpException(error.toString());
    }
  }
  
  Future<void> login(String email, String password) async {
    return _authenticate(email, password, 'signInWithPassword');
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }

  

  
}