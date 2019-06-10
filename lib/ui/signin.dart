import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_study_app/bloc/signin_bloc/signin_bloc.dart';

import 'package:modal_progress_hud/modal_progress_hud.dart';
import '../bloc/login_form_bloc/bloc.dart';

//import '../bloc/auth_bloc/bloc.dart';
import '../bloc/blocs.dart';

import '../routes/index.dart';

import '../resources/auth_repository.dart';
import '../resources/file_stroage.dart';
import 'package:path_provider/path_provider.dart';

// class SigninApp extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() => _SigninApp();
// }



class SigninApp extends StatelessWidget {
  //final LoginFormBloc _loginFormBloc = LoginFormBloc();
  final emailController = TextEditingController(text: 's@s.com');
  final pwController = TextEditingController(text: '123456');

  AuthBloc authBloc;
  SigninBloc signinBloc;
  BuildContext context;

  // @override
  // void initState(){
  //   emailController.addListener(_onEmailChanged);
  // }

  // @override
  // void dispose() {
  //   super.dispose();
  // }

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
      //focusNode: focus,
      //textInputAction: TextInputAction.next,
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
            ),
            SizedBox(height: 20),
            MaterialButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              elevation: 0.4,
              minWidth: double.infinity,
              padding: EdgeInsets.all(16),
              color: Colors.white,
              //onPressed: state.isFormValid ? siginInAction : () => {},
              onPressed: siginInAction,
              child: Text('로그인', 
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
              onPressed: () {
                Navigator.pushNamed(context, Routes.signup);
              },
              child: Text('회원가입', 
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

  void siginInAction(){
    //authBloc.dispatch(LoginEvent(emailController.text, pwController.text));
    signinBloc.dispatch( AttemptSigninEvent(emailController.text, pwController.text) );
  }

  void _onEmailChanged(){
    //_loginFormBloc.dispatch(EmailChanged(email: emailController.text));
  }

  Widget get bodyView {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _logoView,
            SizedBox(height: 50),
            _loginFormView(),
          ],
        ),
      ),
    );
  }

  Widget get loadingView{
    return Positioned.fill(
      child: Container(
        color: Colors.transparent,
        child: Align(
          alignment: Alignment.center,
          child: CircularProgressIndicator(),
        )
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //signinBloc = 

    return Scaffold(
      backgroundColor: Color.fromRGBO(49, 58, 67, 1),
      body: Center(
        child: BlocBuilder(
          bloc: signinBloc,
          builder: (BuildContext context, SigninState state) {  
            this.context = context;

            if( state is LoadingSignin ){
              return Stack(
                children: <Widget>[
                  bodyView,
                  loadingView
                ],
              );
            }
            return bodyView;
          }
        )
      ),
    );
  }
}
