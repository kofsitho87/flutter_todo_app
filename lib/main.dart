import 'package:flutter/material.dart';
import './ui/colors.dart';
//import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:bloc/bloc.dart';
// import './bloc/blocs.dart';
// import './bloc/auth_bloc/bloc.dart';
// import './resources/repository.dart';
// import './resources/file_stroage.dart';

// import 'ui/login.dart';
// import 'ui/main.dart';

void main() {
  //BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(MyApp());
}
  

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    // final authBloc = AuthBloc(
    //   repository: Repository(
    //     fileStorage: const FileStorage(
    //       '__flutter_bloc_app__',
    //       getApplicationDocumentsDirectory,
    //     )
    //   )
    // );

    //authBloc.dispatch(CheckAuthEvent());

    // final home = Scaffold(
    //     body: BlocBuilder(
    //       bloc: authBloc,
    //       builder: (BuildContext context, AuthState state) {
    //         if(state is Autenticated) {
    //           return MainApp();
    //         }else if (state is NotAutenticated){
    //           return LoginApp();
    //         }else if (state is Autenticating){
    //           return Center(
    //             child: CircularProgressIndicator(),
    //           );
    //         }
    //       }
    //     )
    //   ),
    // );

    final home = Scaffold(
      backgroundColor: Colors.blueGrey,
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index){
          var color = Color1;
          if(index == 1 ) color = Color2;
          else if(index == 2) color = Color3;


          return Padding(
            padding: EdgeInsets.all(10.0),
            child: Container(
              //transform: Matrix4.rotationZ(0.1),
              //height: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  bottomLeft: Radius.circular(8.0),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                //verticalDirection: VerticalDirection.up,
                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    //height: 100,
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8.0),
                        bottomLeft: Radius.circular(8.0),
                      ),
                    ),
                    child: CircleAvatar(
                      backgroundColor: Color.for,
                      child: Icon(Icons.work, color: Colors.white),
                    ),
                  ),
                  Container(
                    //alignment: Alignment.topLeft,
                    padding: EdgeInsets.only(
                      top: 10,
                      left: 10
                    ),
                    child: Column(
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          //textDirection: TextDirection.rtl,
                          children: <Widget>[
                            Text("title 123", textAlign: TextAlign.left,),
                            Text('sub title asdkasjdkj')
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );

    return MaterialApp(
      // initialRoute: 'Login',
      // routes: {
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
      home: home
    );
  }
}

