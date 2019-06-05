import 'package:flutter/material.dart';
import '../bloc/auth_bloc/bloc.dart';

class SignupApp extends StatefulWidget {
  final AuthBloc authBloc;

  SignupApp({@required this.authBloc});

  @override
  State<StatefulWidget> createState() => SignupPageState();
}

class SignupPageState extends State<SignupApp> {
  final emailController = TextEditingController(text: 's@s.com');
  final userNameController = TextEditingController(text: 'user name');
  final pwController = TextEditingController(text: '123456');
  final rePwController = TextEditingController(text: '123456');

  Widget get _emailFormRowView {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.only(left: 10.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 0.5),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      child: TextFormField(
        controller: emailController,
        textInputAction: TextInputAction.next,
        style: TextStyle(color: Colors.white),
        keyboardAppearance: Brightness.dark,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          border: InputBorder.none,
          icon: Icon(Icons.email, color: Colors.white),
          suffixStyle: TextStyle(color: Colors.white),
          labelStyle: TextStyle(color: Colors.white),
          labelText: '이메일',
        ),
      ),
    );
  }

  Widget get _userNameFormRowView {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.only(left: 10.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 0.5),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      child: TextFormField(
        controller: userNameController,
        textInputAction: TextInputAction.next,
        style: TextStyle(color: Colors.white),
        keyboardAppearance: Brightness.dark,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          border: InputBorder.none,
          icon: Icon(Icons.person, color: Colors.white),
          suffixStyle: TextStyle(color: Colors.white),
          labelStyle: TextStyle(color: Colors.white),
          labelText: '유저네임',
        ),
      ),
    );
  }

  Widget get _passwordFormRowView {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.only(left: 10.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 0.5),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      child: TextFormField(
        controller: pwController,
        textInputAction: TextInputAction.next,
        style: TextStyle(color: Colors.white),
        keyboardAppearance: Brightness.dark,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          border: InputBorder.none,
          icon: Icon(Icons.security, color: Colors.white),
          suffixStyle: TextStyle(color: Colors.white),
          labelStyle: TextStyle(color: Colors.white),
          labelText: '비밀번호',
        ),
      ),
    );
  }

  Widget get _rePasswordFormRowView {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.only(left: 10.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 0.5),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      child: TextFormField(
        controller: rePwController,
        textInputAction: TextInputAction.next,
        style: TextStyle(color: Colors.white),
        keyboardAppearance: Brightness.dark,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          border: InputBorder.none,
          icon: Icon(Icons.security, color: Colors.white),
          suffixStyle: TextStyle(color: Colors.white),
          labelStyle: TextStyle(color: Colors.white),
          labelText: '비밀번호 확인',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.blueGrey[800],
        accentColor: Colors.lightGreen,
        primaryTextTheme: TextTheme(
          title: TextStyle(color: Colors.white),
          headline: TextStyle(color: Colors.white),
        ),
      ),
      home: Scaffold(
        backgroundColor: Color.fromRGBO(49, 58, 67, 1),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            child: Column(
              children: <Widget>[
                SizedBox(height: 100),
                _emailFormRowView,
                _userNameFormRowView,
                _passwordFormRowView,
                _rePasswordFormRowView,
                SizedBox(height: 20),
                MaterialButton(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  elevation: 0.1,
                  minWidth: double.infinity,
                  padding: EdgeInsets.all(16),
                  color: Colors.lightGreen,
                  child: Text('회원가입', style: TextStyle(color: Colors.white)),
                  onPressed: () {
                    //widget.authBloc.dispatch(Sign);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}