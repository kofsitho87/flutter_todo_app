import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../resources/todos_repository.dart';
import '../bloc/blocs.dart';
import '../models/Todo.dart';

import '../routes/index.dart';
import './todos.dart';
import './detail.dart';
import '../ui/components/components.dart';


class HomeApp extends StatefulWidget {
  final AuthBloc authBloc;

  HomeApp({@required this.authBloc});

  @override
  State<StatefulWidget> createState() => _HomeApp();
}

class _HomeApp extends State<HomeApp> {
  
  @override
  Widget build(BuildContext context) {
    TodosBloc todosBloc = TodosBloc(todosRepository: TodosRepository());

    todosBloc.dispatch(LoadTodos());

    return BlocProvider(
      bloc: todosBloc,
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.blueGrey[800],
          accentColor: Colors.lightGreen,
          primaryTextTheme: TextTheme(
            title: TextStyle(color: Colors.white),
            headline: TextStyle(color: Colors.white),
          )
        ),
        routes: {
          Routes.todos: (context) {
            return TodoApp();
          },
          Routes.addTodo: (context) {
            return DetailApp(title: 'Add Todo');
          }
        },
      ),
    );
  }
}