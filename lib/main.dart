import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:simple_permissions/simple_permissions.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bloc/bloc.dart';
import './bloc/blocs.dart';
import './bloc/auth_bloc/bloc.dart';
import './resources/repository.dart';
import './resources/file_stroage.dart';

import 'ui/todos.dart';
import 'ui/detail.dart';
import 'ui/login.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(MyApp());
}
  

class MyApp extends StatelessWidget {

  _requestWritePermission() async {
    PermissionStatus permissionStatus = await SimplePermissions.requestPermission(Permission.WriteExternalStorage);
    print(permissionStatus);
    if (permissionStatus == PermissionStatus.authorized) {
      
    }
  }

  @override
  void initState() {
    //super.initState();
    print('initState');
    //_requestWritePermission();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    _requestWritePermission();

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
      // initialRoute: 'Login',
      // routes: {
      //   'Login': (context) => LoginApp(),
      //   '/todos': (context) => TodoApp(),
      //   '/detail': (context) => DetailApp(),
      // },
      // title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.red,
      ),
      home: Scaffold(
        body: BlocBuilder(
          bloc: authBloc,
          builder: (BuildContext context, AuthState state) {
            print(state);
            if(state is Autenticated) {
              print("user is =>");
              print(state.user);
              return Center(
                child: Text('Autenticated user is => ${state.user.name}'),
              );
            }else if (state is NotAutenticated){
              return Center(
                child: RaisedButton(
                  child: Text('NotAutenticated And Login'),
                  onPressed: (){
                    authBloc.dispatch(LoginEvent());
                  },
                ),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        )
      ),
    );
  }
}

