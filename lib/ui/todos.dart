import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../routes/index.dart';
import '../bloc/blocs.dart';
import '../models/models.dart';

import '../ui/components/components.dart';
import './detail.dart';

class TodoApp extends StatelessWidget {
  final void Function() onSignOut;
  TodoApp({@required this.onSignOut, Key key}) : super(key: key);

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  TodosBloc todosBloc;
  FilteredTodosBloc filteredTodosBloc;

  void toggleCompleteTodo(Todo todo){
    todo.completed = !todo.completed;
    todosBloc.dispatch(UpdateTodo(todo));
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("${todo.title} ${!todo.completed ? '미' : ''}완료됨")));
  }

  void deleteTodo(Todo todo) {
    todosBloc.dispatch(DeleteTodo(todo));
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("${todo.title} dismissed")));
  }

  void _showLogoutDialog(context){
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
                onSignOut();
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

  void _showTodoBottomSheet(Todo todo, context){
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.check_circle),
                title: Text( todo.completed ? '미완료하기' : '완료하기' ),
                onTap: () {
                  Navigator.of(context).pop();
                  toggleCompleteTodo(todo);
                },
              ),
              ListTile(
                leading: Icon(Icons.navigate_next),
                title: Text('수정하기'),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => DetailApp(title: todo.title, todo: todo)));
                },
              ),
              ListTile(
                leading: Icon(Icons.delete),
                title: Text('삭제하기'),
                onTap: () {
                  Navigator.of(context).pop();
                  deleteTodo(todo);
                },
              )
            ],
          ),
        );
      }
    );
  }

  void _showFilterListBottomSheet(context){
    final enabled = (filteredTodosBloc.currentState is FilteredTodosLoaded) ? 
      (todosBloc.currentState as TodosLoaded).todos.length > 1 : 
      false;

    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          child: Wrap(
            children: <Widget>[
              ListTile(
                enabled: enabled,
                title: Text('전체보기'),
                onTap: () {
                  filteredTodosBloc.dispatch(SortingTodos(SortingFilter.basic));
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                enabled: enabled,
                title: Text('미완료만 보기'),
                onTap: () {
                  filteredTodosBloc.dispatch(VisibilityTodos(VisibilityFilter.active));
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                enabled: enabled,
                title: Text('완료만 보기'),
                onTap: () {
                  filteredTodosBloc.dispatch(VisibilityTodos(VisibilityFilter.completed));
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                enabled: enabled,
                //leading: Icon(Icons.filter_hdr),
                title: Text('완료 시간순으로 정렬'),
                onTap: () {
                  filteredTodosBloc.dispatch(SortingTodos(SortingFilter.completeDate));
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                enabled: enabled,
                //leading: Icon(Icons.navigate_next),
                title: Text('미완료/완료로 정렬'),
                onTap: () {
                  filteredTodosBloc.dispatch(SortingTodos(SortingFilter.activeCompleted));
                  Navigator.of(context).pop();
                },
              )
            ],
          ),
        );
      }
    );
  }

  Future<bool> _confirmDismissAction(direction) async {
    return false;
    return direction == DismissDirection.endToStart;
  }

  @override
  Widget build(BuildContext context) {

    todosBloc = BlocProvider.of<TodosBloc>(context);
    
    filteredTodosBloc = FilteredTodosBloc(
      todosBloc: todosBloc
    );

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
            icon: Icon(Icons.filter_list),
            onPressed: () => _showFilterListBottomSheet(context),
          ),
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () => _showLogoutDialog(context),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'add todo',
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, Routes.addTodo);
        },
      ),
      body: BlocBuilder(
        bloc: filteredTodosBloc,
        builder: (BuildContext context, FilteredTodosState state) {
          if(state is FilteredTodosLoaded) {
            final todos = state.filteredTodos;

            return RefreshIndicator(
              key: _refreshIndicatorKey,
              onRefresh: () async {
                _refreshIndicatorKey.currentState.show();
                todosBloc.dispatch(LoadTodos());
                return null;
              },
              child: ListView.builder(
                itemCount: todos.length,
                itemBuilder: (context, index) {
                  final todo = todos[index];
                  return Dismissible(
                    key: Key(index.toString()),
                    confirmDismiss: _confirmDismissAction,
                    direction: DismissDirection.endToStart,
                    background: Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      padding: EdgeInsets.only(left: 20.0),
                      color: Colors.blue,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Icon(Icons.delete, color: Colors.white)
                      ),
                    ),
                    secondaryBackground: Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      padding: EdgeInsets.only(right: 20.0),
                      color: Colors.red,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Icon(Icons.delete, color: Colors.white)
                      ),
                    ),
                    onDismissed: (DismissDirection direction) {
                      if(direction == DismissDirection.endToStart){
                        deleteTodo(todo);
                      }
                    },
                    child: GestureDetector(
                      child: AnimatedOpacity(
                        key: Key(index.toString()),
                        opacity: todo.completed ? 0.4 : 1,
                        duration: Duration(milliseconds: 0),
                        child: TodoRowView(index, todo),
                      ),
                      onTapUp: (_) => _showTodoBottomSheet(todo, context),
                    ),
                  );
                }
              ),
            );
          }

          return Center(child: CircularProgressIndicator());
        }
      ),
    );
  }
}