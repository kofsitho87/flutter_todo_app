import 'dart:async';
import 'dart:core';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/Todo.dart';

class TodosRepository {
  FirebaseUser _user;
  DocumentReference _documentReference;

  
  Future<List<Todo>> loadTodos() async {
    if(this._user == null) {
      this._user = await FirebaseAuth.instance.currentUser();
    }

    _documentReference = Firestore.instance.collection("USERS").document(_user.uid);
    QuerySnapshot querySnapshot = await _documentReference.collection('Todos').getDocuments();
    final _todos = querySnapshot.documents.map((snapshot) => Todo(snapshot['title'], snapshot['category'], id: snapshot.documentID)).toList();
    print("todos => ");
    print(_todos);
    return _todos;
  }

  Future<bool> addTodo(todo) async {
    if(this._user == null) {
      this._user = await FirebaseAuth.instance.currentUser();
    }
    final DocumentReference doc =  Firestore.instance.collection("USERS").document(_user.uid).collection('Todos').document();
    var result = false;
    await doc
    .setData(todo)
    .whenComplete(() {
      print('Document Added');
      result = true;
    }).catchError((e) {
      print(e);
    });

    return result;
  }
  
  Future saveTodos(List<Todo> todos) {
    // Map<String, dynamic> data = {
    //   "title": title,
    //   'completed': false,
    //   'category': category,
    //   'completeDate': completeDate,
    //   'timestamp': DateTime.now()
    // };
    // if(this._user == null) {
    //   this._user = await FirebaseAuth.instance.currentUser();
    // }
    // final DocumentReference doc =  Firestore.instance.collection("USERS").document(_user.uid).collection('Todos').document();
    // await doc
    // .setData(data)
    // .whenComplete(() {
    //   print('Document Added');
      
    // }).catchError((e) {
    //   print(e);
      
    // });
    
    // return Future.wait<dynamic>([
    //   fileStorage.saveTodos(todos),
    //   webClient.postTodos(todos),
    // ]);
  }
}