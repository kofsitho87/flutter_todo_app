import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/login_form_bloc/bloc.dart';
import '../bloc/auth_bloc/bloc.dart';

class LoginApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginPageState();
}



class LoginPageState extends State<LoginApp> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final LoginFormBloc _loginFormBloc = LoginFormBloc();
  final emailController = TextEditingController(text: 's@s.com');
  final pwController = TextEditingController(text: '123456');

  bool isLoading = false;

  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  @override
  void initState(){
    emailController.addListener(_onEmailChanged);
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget get _logoView {
    return Column(
      children: <Widget>[
        Icon(Icons.dashboard, size: 80, color: Colors.lightGreen),
        SizedBox(height: 10,),
        Text('My Dashborad', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white)),
      ],
    );
  }

  Widget _textFormField(int type) {
    final focus = FocusNode();
    var _labelText = type == 1 ? 'Email' : 'Password';
    var _icon = type == 1 ? Icons.email : Icons.security;

    return TextFormField(
      controller: type == 1 ? emailController : pwController,
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

  Widget _loginFormView(LoginFormState state){
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
            ),
            SizedBox(height: 20),
            MaterialButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              elevation: 0.4,
              minWidth: double.infinity,
              padding: EdgeInsets.all(16),
              //height: 50,
              color: Colors.white,
              //onPressed: () => Navigator.of(context).pushNamed('/signin'),
              onPressed: state.isFormValid ? siginInAction : null,
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
      ),
    );
  }

  Future<FirebaseUser> _handleSignIn(email, password) async {
    try {
      print(email);
      return await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on PlatformException catch(e){
      //print(e);
      return null;
    }
    //return _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<FirebaseUser> _handleSignUp(email, password) async {
    return _auth.createUserWithEmailAndPassword(email: email, password: password);
    
  }

  void signUpAction(){
    setState(() {
      isLoading = true;
    });
    _handleSignUp(emailController.text, pwController.text)
      .then((FirebaseUser user) {
        print(user);
        siginInAction();
      })
      .catchError((e) => print(e));
  }

  void siginInAction(){
    setState(() {
      isLoading = true;
    });
    _handleSignIn(emailController.text, pwController.text)
      .then((FirebaseUser user) {
        // setState(() {
        //   isLoading = false;
        // });
        print(user.email);
        goToMainPage();
      })
      .catchError((e) {
        print(e);
      });  
  }

  void _onEmailChanged(){
    //_myFormBloc.dispatch(EmailChanged(email: _emailController.text));
    _loginFormBloc.dispatch(EmailChanged(email: emailController.text));
  }

  goToMainPage(){
    Navigator.pushReplacementNamed(context, '/todos');
  }

  Widget blocBuilder(){
    return BlocBuilder(
      bloc: _loginFormBloc,
      builder: (BuildContext context, LoginFormState state) {
        return SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _logoView,
                SizedBox(height: 50),
                _loginFormView(state),
              ],
            ),
          ),
        );
        // return Form(
        //   child: Padding(
        //     padding: const EdgeInsets.all(36.0),
        //     child: Column(
        //       crossAxisAlignment: CrossAxisAlignment.center,
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: <Widget>[
        //         //SizedBox(height: 10.0),
        //         TextFormField(
        //           controller: emailController,
        //           keyboardType: TextInputType.emailAddress,
        //           autovalidate: true,
        //           validator: (_){
        //             return state.isEmailValid ? null : '올바른 이메일을 입력해주세요';
        //           },
        //           decoration: InputDecoration(
        //             icon: Icon(Icons.email),
        //             labelText: 'email',
        //             hintText: "Email",
        //             //border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))
        //           ),
        //         ),
        //         SizedBox(height: 25.0),
        //         TextFormField(
        //           controller: pwController,
        //           obscureText: true,
        //           autovalidate: true,
        //           validator: (_){
        //             return state.isPasswordValid ? null : '올바른 비밀번호를 입력해주세요';
        //           },
        //           decoration: InputDecoration(
        //             icon: Icon(Icons.lock),
        //             labelText: 'Password',
        //             hintText: "Password",
        //           )
        //         ),
        //         SizedBox(
        //           height: 35.0,
        //         ),
        //         Material(
        //           elevation: 5.0,
        //           borderRadius: BorderRadius.circular(30.0),
        //           color: Colors.red,
        //           child: MaterialButton(
        //             minWidth: MediaQuery.of(context).size.width,
        //             onPressed: state.isFormValid ? siginInAction : null,
        //             child: Text("Login",
        //                 textAlign: TextAlign.center,
        //                 style: style.copyWith(
        //                   color: Colors.white, fontWeight: FontWeight.bold)
        //                 ),
        //           ),
        //         ),
        //         SizedBox(
        //           height: 15.0,
        //         ),
        //       ],
        //     ),
        //   ),
        // );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(49, 58, 67, 1),
      //backgroundColor: Colors.blueGrey[800],
      body: Center(
        child: ModalProgressHUD(
          child: blocBuilder(),
          inAsyncCall: isLoading
        )
      ),
    );
  }
}
