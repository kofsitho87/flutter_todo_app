import 'package:flutter/material.dart';
import '../ui/colors.dart';
import '../ui/components/components.dart';

class SampleTodo extends StatelessWidget {

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
    
    final listView = ListView.builder(
      itemCount: 3,
      itemBuilder: (context, index){
        var color = Color1;
        var colorDepp = Color1Deep;
        if(index == 1 ) {
          color = Color2;
          colorDepp = Color2Deep;
        }
        else if(index == 2){
          color = Color3;
          colorDepp = Color3Deep;
        }
        final width = MediaQuery.of(context).size.width - 20 - 60;

        if(index == 0){
          //return Text('secton title');
        }

        return Dismissible(
          //direction: DismissDirection.endToStart,
          background: Container(
            padding: EdgeInsets.only(left: 20.0),
            color: Colors.blue,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Complete',
                textAlign: TextAlign.right,
                style: TextStyle(color: Colors.white),
              ),
            )
          ),
          secondaryBackground: Container(
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
            //final _todo = snapshot.data[index];
            //deleteTodo(_todo);
          },
          child: TodoRowView(index, color, colorDepp, width),
        );


        //return TodoRowView(index, color, colorDepp, width);
      },
    );
    final home = Scaffold(
      appBar: AppBar(
        elevation: 0,
        bottomOpacity: 0,
        centerTitle: true,
        title: Text('MyTodo'),
        backgroundColor: Colors.transparent,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.add), onPressed: () {
            print('aaa');
          }),
        ],
        //brightness: Brightness.dark,
      ),
      backgroundColor: Colors.blueGrey,
      body: listView,
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