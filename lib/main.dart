import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';

import './bloc/blocs.dart';
import './resources/repository.dart';
import './resources/file_stroage.dart';


import 'ui/login.dart';
import 'ui/todos.dart';
import 'ui/detail.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(Main());
}

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authBloc = AuthBloc(
      repository: Repository(
        fileStorage: const FileStorage(
          '__flutter_bloc_app__',
          getApplicationDocumentsDirectory,
        )
      )
    );

    // final authBloc = BlocProvider.of<AuthBloc>(context);
    authBloc.dispatch(CheckAuthEvent());

    return MaterialApp(
      initialRoute: 'Login',
      routes: {
        '/Login': (context) => LoginApp(),
        '/todos': (context) => TodoApp(),
        //'/detail': (context) => DetailApp(),
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        //primarySwatch: ColorWhite,
        //brightness: Brightness.dark,
        primaryColor: Colors.blueGrey[800],
        accentColor: Colors.lightGreen,
        // textTheme: TextTheme(
        //   headline: TextStyle(color: Colors.white),
        //   title: TextStyle(color: Colors.white),
        // ),
        primaryTextTheme: TextTheme(
          title: TextStyle(color: Colors.white),
          headline: TextStyle(color: Colors.white),
        )
      ),
      //darkTheme: ThemeData.dark(),
      home: Scaffold(
        body: BlocBuilder(
          bloc: authBloc,
          builder: (BuildContext context, AuthState state) {
            if(state is Autenticated) {
              print(state.user);
              return TodoApp();
            }else if (state is NotAutenticated){
              return LoginApp();
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}