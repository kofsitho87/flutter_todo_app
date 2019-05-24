import 'package:cloud_firestore/cloud_firestore.dart';

class TodosModel {
  int _page;
  int _total_results;
  List<Todo> _items = [];

  List<Todo> get results => _items;

  TodosModel.fromJson(List<DocumentSnapshot> list) {
    List<Todo> _todos = list.map((snapshot) => Todo(snapshot.documentID, snapshot['title'])).toList();
    _items = _items..addAll(_todos);
    //_items = parsedJson.map((row) => Todo(row['uid'], row['title'])).toList();
  }

  TodosModel.add(){
    print("items");
    _items.add(Todo('uid', 'todo test'));
  }
}


class Todo {
  String id;
  String title;
  bool completed = false;

  Todo(this.id, this.title);
}