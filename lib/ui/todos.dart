import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../routes/index.dart';
import '../bloc/blocs.dart';
import '../models/Todo.dart';

import '../ui/components/components.dart';
import './detail.dart';

class TodoApp extends StatefulWidget {
  final void Function() onSignOut;

  TodoApp({@required this.onSignOut});

  @override
  State<StatefulWidget> createState() => TodoList();
}

class TodoList extends State<TodoApp> {
  

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  final _formKey = GlobalKey<FormState>();
  TodosBloc todosBloc;
  //bool isLoading = true;
  //String todo;
  //bool _autoValidate = false;
  //FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    todosBloc = BlocProvider.of<TodosBloc>(context);
    super.initState();
  }

  @override
  void dispose() {
    //bloc.dispose();
    super.dispose();
  }

  _goToCreateTodoPage(){
    //Navigator.pushReplacementNamed(context, '/detail');
    Navigator.pushNamed(context, Routes.addTodo);
    //Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => DetailApp(title: 'Todo 생성')));
  }

  void deleteTodo(Todo todo) {
    todosBloc.dispatch(DeleteTodo(todo));
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
    //bloc.updateTodo(todo);
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
        //_settingModalBottomSheet(todo);
      },
    );
  }

  Widget _buildTodoList(List<Todo> todos) {
    return RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: () async {
        _refreshIndicatorKey.currentState.show();
        //todosBloc.dispatch(LoadTodos());
        return null;
      },
      child: ListView.builder(
        itemCount: todos.length,
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
            key: Key(index.toString()),
            onDismissed: (DismissDirection direction) {
              final _todo = todos[index];
              deleteTodo(_todo);
            },
            child: TodoRowView(index, todos[index]),
          );
        }
      ),
    );;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        elevation: 0,
        bottomOpacity: 0,
        centerTitle: true,
        title: Text('MyDashborad'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.all_out),
            onPressed: () {},
          )
        ],
      ),
      body: BlocBuilder(
        bloc: todosBloc,
        builder: (BuildContext context, TodosState state) {

          if(state is TodosLoaded){
            return _buildTodoList(state.todos);
          }else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          // return ModalProgressHUD(
          //   child: child,
          //   inAsyncCall: state == TodosLoading
          // );
        }
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'add todo',
        child: Icon(Icons.add),
        onPressed: _goToCreateTodoPage,
      ),
    );
  }
}
