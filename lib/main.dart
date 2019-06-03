import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_study_app/ui/home.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';

import './bloc/blocs.dart';
import './resources/repository.dart';
import './resources/file_stroage.dart';


import 'ui/login.dart';
import 'ui/home.dart';

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

    authBloc.dispatch(CheckAuthEvent());

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.blueGrey[800],
        accentColor: Colors.lightGreen,
        primaryTextTheme: TextTheme(
          title: TextStyle(color: Colors.white),
          headline: TextStyle(color: Colors.white),
        )
      ),
      home: Scaffold(
        body: BlocBuilder(
          bloc: authBloc,
          builder: (BuildContext context, AuthState state) {
            if(state is Autenticated) {
              print(state.user);
              return HomeApp(authBloc: authBloc);
            }else if (state is NotAutenticated){
              return LoginApp(authBloc: authBloc);
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        )
      )
    );
  }
}