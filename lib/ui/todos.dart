import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

//import '../bloc/todo_bloc.dart';
import '../blocs/todos_bloc.dart';
import '../models/Todo.dart';

class TodoApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TodoList();
}

class TodoList extends State<TodoApp> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  DocumentReference documentReference;


  TodosBloc bloc = TodosBloc();

  bool isLoading = true;
  String todo;
  bool _autoValidate = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    bloc.fetchTodos();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    bloc.dispose();
    super.dispose();
  }

  void addTodo() {
    bloc.addTodo(todo);
    Navigator.of(context, rootNavigator: true).pop();

    // Map<String, dynamic> data = {
    //   "title": todo,
    //   'completed': false,
    //   'timestamp': DateTime.now()
    // };
    // final DocumentReference doc =  documentReference.collection('Todos').document();
    // doc
    //   .setData(data)
    //   .whenComplete(() {
    //     print('Document Added');
    //     this.todos.add( Todo(doc.documentID, todo) );
    //     setState(() {
    //       todos = this.todos;
    //     });

    //     Navigator.of(context, rootNavigator: true).pop();
    //   }).catchError((e) {
    //     print(e);
    //   });
  }

  void deleteTodo(Todo todo) {
    print('deleteTodo');
    bloc.deleteTodo(todo);
    //Scaffold.of(context).showSnackBar(SnackBar(content: Text("${todo.title} dismissed")));
    // documentReference
    //     .collection('Todos')
    //     .document(todo.id)
    //     .delete()
    //     .whenComplete(() {
    //       print('deleted');
    //       print(todo);
    //       if (todos.contains(todo)) {
    //         setState(() {
    //           todos.remove(todo);
    //         });
    //       }
    //       //Scaffold.of(context).showSnackBar(SnackBar(content: Text("${todo.title} dismissed")));
    //     }
    // );
  }

  void updateTodo(Todo todo){
    print('updateTodo');
    bloc.updateTodo(todo);
  }

  Widget TodoFormUI() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(8.0),
          child: TextFormField(
            decoration: const InputDecoration(labelText: 'Todo'),
            keyboardType: TextInputType.text,
            validator: (String arg) {
              if (arg.length < 3)
                return 'Todo must be more than 2 charater';
              else
                return null;
            },
            onSaved: (String val) {
              todo = val;
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: RaisedButton(
            child: Text("Submitß"),
            onPressed: _validateInputs,
          ),
        )
      ],
    );
  }

  void _validateInputs() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      addTodo();
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }

  void _showDialog() {
    print('showDialog');
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("할일을 입력해주세요"),
          content: Form(
              key: _formKey,
              autovalidate: _autoValidate,
              child: TodoFormUI()),
        );
      }
    );
  }

  void _settingModalBottomSheet(Todo todo) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: Wrap(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.delete),
                  title: Text('삭제'),
                  onTap: () {
                    //Navigator.pushReplacementNamed(context, '/detail')
                    deleteTodo(todo);
                    Navigator.of(context, rootNavigator: true).pop();
                  }
                ),
                ListTile(
                  leading: Icon(Icons.person_pin),
                  title: Text('Video'),
                  onTap: () => {},
                ),
              ],
            ),
          );
        });
  }

  Widget _buildRow(Todo todo) {
    return ListTile(
      //leading: Icon(Icons.work, size: 40.0, color: Colors.red),
      leading: new Checkbox(
        value: todo.completed, 
        onChanged: (completed) {
          todo.completed = completed;
          updateTodo(todo);
        },
      ),
      title: Text(todo.title),
      subtitle: Text('subtitle'),
      trailing: Icon(Icons.keyboard_arrow_right),
      onTap: () {
        _settingModalBottomSheet(todo);
      },
      //enabled: false,
      //selected: true,
      //dense: true, //small text
    );
  }

  Widget _buildTodoList(AsyncSnapshot<List<Todo>> snapshot) {
    //print(snapshot.data);
    return new ListView.builder(
        //padding: const EdgeInsets.all(20),
        itemCount: snapshot.data.length,
        itemBuilder: (context, index) {
          return Dismissible(
            direction: DismissDirection.endToStart,
            background: Container(
              padding: EdgeInsets.only(right: 20.0),
              color: Colors.red,
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'Delete',
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            key: Key(snapshot.data[index].title + Random().nextInt(10000).toString()),
            onDismissed: (DismissDirection direction) {
              final _todo = snapshot.data[index];
              deleteTodo(_todo);
            },
            child: Column(
              children: <Widget>[_buildRow(snapshot.data[index]), Divider()],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new TextFormField(
          decoration: new InputDecoration(labelText: "Todo"),
          validator: (val) => todo = val,
          //onSaved: (val) => _email = val,
        ),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.add),
            onPressed: _showDialog,
          )
        ],
      ),
      body: StreamBuilder(
        stream: bloc.allTodos,
        builder: (context, AsyncSnapshot<List<Todo>> snapshot) {
          print("snapshot => ");
          print(snapshot.hasData);
          if(snapshot.hasData){
            return _buildTodoList(snapshot);
          }else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'add todo',
        child: Icon(Icons.add),
        onPressed: _showDialog,
      ),
        //ModalProgressHUD(child: _buildTodoList(), inAsyncCall: isLoading)
    );
  }
}
