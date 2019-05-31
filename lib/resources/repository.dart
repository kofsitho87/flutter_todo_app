import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:meta/meta.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../resources/file_stroage.dart';

//import 'package:flutter_study_app/resources/auth_api_provider.dart';

import 'todo_api_provider.dart';
import '../models/models.dart';

class Repository {
  final FileStorage fileStorage;
  FirebaseAuth _auth = FirebaseAuth.instance;

  Repository({@required this.fileStorage});

  //final authApiProvidr = AuthApiProvider();


  //Future<User> loadUser() => authApiProvidr.loadUser();
  //Future<User> login() => authApiProvidr.login();

  Future<User> loadUser() async {
    try {
      return await fileStorage.loadUser();
    } catch (e) {
      throw e;
    }
  }

  Future<User> login() async {
    print("api call start and return user model");
    try {
      FirebaseUser user = await _auth.currentUser();
      if( user == null ){
        user = await _auth.signInWithEmailAndPassword(email: 's@s.com', password: '123456');  
      }
      final userModel = User(user.uid, user.displayName);
      var a= this.saveUser(userModel);
      a.then((file) {
        print(file.toString());
      });
      return userModel;
    } catch (e) {
      throw e;
    }
  }

  Future<File> saveUser(User user) async {
    try {
      return await fileStorage.saveUser(user);
    } catch (e) {
      throw e;
    }
  }
}