import 'package:rxdart/rxdart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/Todo.dart';
import '../resources/repository.dart';


class TodosBloc {
  //final _repository = Repository();
  //final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser _user;
  DocumentReference _documentReference;
  List<Todo> _todos = [];

  final todosFetcher = PublishSubject<List<Todo>>();

  Observable<List<Todo>> get allTodos => todosFetcher.stream;

  //TodosBloc({this.uid}){}

  fetchTodos() async {
    //await Future.delayed(Duration(seconds: 2));
    if(this._user == null) {
      this._user = await FirebaseAuth.instance.currentUser();
    }
    
    _documentReference = Firestore.instance.collection("USERS").document(_user.uid);
    QuerySnapshot querySnapshot = await _documentReference.collection('Todos').getDocuments();
    _todos = querySnapshot.documents.map((snapshot) => Todo(snapshot.documentID, snapshot['title'])).toList();
    todosFetcher.sink.add(_todos);
  }

  addTodo(String title) async {
    Map<String, dynamic> data = {
      "title": title,
      'completed': false,
      'timestamp': DateTime.now()
    };
    final DocumentReference doc =  _documentReference.collection('Todos').document();
    doc
    .setData(data)
    .whenComplete(() {
      print('Document Added');
      this._todos.add( Todo(doc.documentID, title) );
      todosFetcher.sink.add(this._todos);
    }).catchError((e) {
      print(e);
    });
  }

  deleteTodo(Todo todo) async {
    _documentReference
        .collection('Todos')
        .document(todo.id)
        .delete()
        .whenComplete(() {
          print('deleted');
          print(todo);
          if (this._todos.contains(todo)) {
            this._todos.remove(todo); 
            todosFetcher.sink.add(this._todos);
          }
        }
    );
  }

  updateTodo(Todo todo) async {
    print(todo);

    if (this._todos.contains(todo)) {
      Map<String, dynamic> data = {
        "title": todo.title,
        'completed': todo.completed,
        'timestamp': DateTime.now()
      };
      _documentReference
        .collection('Todos')
        .document(todo.id)
        .updateData(data)
        .whenComplete(() {
          final _index = this._todos.indexOf(todo);
          this._todos[_index] = todo;
          todosFetcher.sink.add(this._todos);
        });
    }
  }

  dispose() {
    todosFetcher.close();
  }
}


