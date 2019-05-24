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
        return Form(
          //color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                //SizedBox(height: 10.0),
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  autovalidate: true,
                  validator: (_){
                    return state.isEmailValid ? null : '올바른 이메일을 입력해주세요';
                  },
                  decoration: InputDecoration(
                    icon: Icon(Icons.email),
                    labelText: 'email',
                    hintText: "Email",
                    //border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))
                  ),
                ),
                SizedBox(height: 25.0),
                TextFormField(
                  controller: pwController,
                  obscureText: true,
                  autovalidate: true,
                  validator: (_){
                    return state.isPasswordValid ? null : '올바른 비밀번호를 입력해주세요';
                  },
                  decoration: InputDecoration(
                    icon: Icon(Icons.lock),
                    labelText: 'Password',
                    hintText: "Password",
                  )
                ),
                SizedBox(
                  height: 35.0,
                ),
                Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(30.0),
                  color: Colors.red,
                  child: MaterialButton(
                    minWidth: MediaQuery.of(context).size.width,
                    onPressed: state.isFormValid ? siginInAction : null,
                    child: Text("Login",
                        textAlign: TextAlign.center,
                        style: style.copyWith(
                          color: Colors.white, fontWeight: FontWeight.bold)
                        ),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                //signUpButon,
              ],
            ),
          ),
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ModalProgressHUD(
          child: blocBuilder(),
          inAsyncCall: isLoading
        )
      ),
    );
  }
}
