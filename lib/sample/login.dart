import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import './sign_in.dart';

class SampleLogin extends StatelessWidget {
  Function pageMove;

  Widget get _logoView {
    return Column(
      children: <Widget>[
        Icon(Icons.dashboard, size: 80, color: Colors.lightGreen),
        SizedBox(height: 10,),
        Text('My Dashborad', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white)),
      ],
    );
  }

  Widget _buttonsView(context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: <Widget>[
          MaterialButton(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            elevation: 0.4,
            minWidth: double.infinity,
            padding: EdgeInsets.all(16),
            //height: 50,
            color: Colors.white,
            onPressed: () => Navigator.of(context).pushNamed('/signin'),
            child: Text('Sign in', 
              style: TextStyle(
                fontSize: 20
              )
            ),
          ),
          SizedBox(height: 15),
          MaterialButton(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            elevation: 0.1,
            minWidth: double.infinity,
            padding: EdgeInsets.all(16),
            //height: 50,
            color: Colors.lightGreen,
            onPressed: () => {},
            child: Text('Sign up', 
              style: TextStyle(
                fontSize: 20,
                color: Colors.white
              )
            ),
          ),
        ],
      ),
    );
  }

  Widget _textFormField(int type) {
    final focus = FocusNode();
    var _labelText = type == 1 ? 'Email' : 'Password';
    var _icon = type == 1 ? Icons.email : Icons.security;

    return TextFormField(
      focusNode: focus,
      textInputAction: TextInputAction.next,
      style: TextStyle(color: Colors.white),
      keyboardAppearance: Brightness.dark,
      keyboardType: TextInputType.emailAddress,
      // onFieldSubmitted: (v) {
      //   //FocusScope.of(context).requestFocus(focus);
      // },
      decoration: InputDecoration(
        //enabledBorder: const OutlineInputBorder(
          //borderSide: const BorderSide(color: Colors.grey, width: 0.0),
        //),
        border: InputBorder.none,
        icon: Icon(_icon, color: Colors.white),
        suffixStyle: TextStyle(color: Colors.white),
        labelStyle: TextStyle(color: Colors.white),
        //border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        labelText: _labelText,
      ),
    );
  }

  Widget _loginFormView(){
    return Form(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 10.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 0.5),
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
              child: _textFormField(1),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              padding: EdgeInsets.only(left: 10.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 0.5),
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
              child: _textFormField(2),
            )
          ],
        ),
      ),
    );
  }

  Widget _screen(context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 50),
            _logoView,
            SizedBox(height: 100),
            _loginFormView(),
            SizedBox(height: 20),
            _buttonsView(context),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Map<int, Color> color = {
      50:Color.fromRGBO(136,14,79, .1),
      100:Color.fromRGBO(136,14,79, .2),
      200:Color.fromRGBO(136,14,79, .3),
      300:Color.fromRGBO(136,14,79, .4),
      400:Color.fromRGBO(136,14,79, .5),
      500:Color.fromRGBO(136,14,79, .6),
      600:Color.fromRGBO(136,14,79, .7),
      700:Color.fromRGBO(136,14,79, .8),
      800:Color.fromRGBO(136,14,79, .9),
      900:Color.fromRGBO(136,14,79, 1),
    };

    return MaterialApp(
      routes: <String, WidgetBuilder> {
        '/signin': (BuildContext context) => SampleSignIn()
      },
      theme: ThemeData(
        //primarySwatch: MaterialColor(0xFF880E4F, color),
      ),
      darkTheme: ThemeData.dark(),
      home: Scaffold(
        backgroundColor: Color.fromRGBO(49, 58, 67, 1),
        body: _screen(context),
      ),
    );
  }
}