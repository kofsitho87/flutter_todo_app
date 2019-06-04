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
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  
  FilteredTodosBloc filteredTodosBloc;
  TodosBloc todosBloc;

  @override
  void initState() {
    todosBloc = BlocProvider.of<TodosBloc>(context);
    filteredTodosBloc = FilteredTodosBloc(
      todosBloc: todosBloc
    );
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _goToCreateTodoPage(){
    Navigator.pushNamed(context, Routes.addTodo);
  }

  _goToUpdateTodoPage(Todo todo){
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => DetailApp(title: todo.title, todo: todo)));
  }

  void deleteTodo(Todo todo) {
    //Scaffold.of(context).showSnackBar(SnackBar(content: Text("${todo.title} dismissed")));
    todosBloc.dispatch(DeleteTodo(todo));
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("${todo.title} dismissed")));
  }

  void updateTodo(Todo todo){
    print('updateTodo');
    //bloc.updateTodo(todo);
  }

  void toggleCompleteTodo(Todo todo){
    todo.completed = !todo.completed;
    todosBloc.dispatch(UpdateTodo(todo));
    Navigator.of(context).pop();
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("${todo.title} ${!todo.completed ? '미' : ''}완료됨")));
  }

  void _showDialog(){
    showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text('로그아웃 하시겠습니까?'),
          content: Text('content'),
          actions: <Widget>[
            FlatButton(
              child: Text('확인'),
              onPressed: (){
                widget.onSignOut();
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('닫기'),
              onPressed: (){
                Navigator.of(context).pop();
              },
            )
          ],
        );
      }
    );
  }

  void _showBottomSheet(Todo todo){
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.check_circle),
                title: Text( todo.completed ? '미완료하기' : '완료하기' ),
                onTap: () => toggleCompleteTodo(todo),
              ),
              ListTile(
                leading: Icon(Icons.navigate_next),
                title: Text('수정하기'),
                onTap: () {
                  Navigator.of(context).pop();
                  _goToUpdateTodoPage(todo);
                },
              )
            ],
          ),
        );
      }
    );
  }

  Future<bool> _confirmDismissAction(direction) async {
    print(direction);
    return direction == DismissDirection.endToStart;
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
            confirmDismiss: _confirmDismissAction,
            //direction: DismissDirection.endToStart,
            background: Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              padding: EdgeInsets.only(left: 20.0),
              color: Colors.blue,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Icon(Icons.delete, color: Colors.white) //Text('Delete',textAlign: TextAlign.left,style: TextStyle(color: Colors.white)),
              ),
            ),
            secondaryBackground: Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              padding: EdgeInsets.only(right: 20.0),
              color: Colors.red,
              child: Align(
                alignment: Alignment.centerRight,
                child: Icon(Icons.delete, color: Colors.white) //Text('Delete',textAlign: TextAlign.left,style: TextStyle(color: Colors.white)),
              ),
            ),
            key: Key(index.toString()),
            onDismissed: (DismissDirection direction) {
              final _todo = todos[index];
              if(direction == DismissDirection.endToStart){
                deleteTodo(_todo);
              }
            },
            child: GestureDetector(
              child: AnimatedOpacity(
                opacity: todos[index].completed ? 0.4 : 1,
                duration: Duration(milliseconds: 0),
                child: TodoRowView(index, todos[index]),
              ),
              onTapUp: (_) => _showBottomSheet(todos[index]),
            ),
          );
        }
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        elevation: 0,
        bottomOpacity: 0,
        centerTitle: true,
        title: Text('MyDashborad'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.network_wifi),
            onPressed: _showDialog,
          )
        ],
      ),
      body: BlocBuilder(
        bloc: filteredTodosBloc,
        builder: (BuildContext context, FilteredTodosState state) {

          if(state is FilteredTodosLoaded){
            return _buildTodoList(state.filteredTodos);
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
