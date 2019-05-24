// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// import 'bloc.dart';

// class LoginApp_ extends StatelessWidget {
//   String email;
//   String password;

//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final GoogleSignIn googleSignIn = new GoogleSignIn();

//   Future<FirebaseUser> _signIn() async {
//     // GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
//     // GoogleSignInAuthentication gSA = await googleSignInAccount.authentication;
//     FirebaseUser user =
//         await _auth.signInWithEmailAndPassword(email: "", password: "");
//     //FirebaseUser user = await _auth.signInWithGoogle(idToken: gSA.idToken, accessToken: gSA.accessToken);

//     print("User Name : ${user.displayName}");
//     return user;
//   }

//   changeThePage(BuildContext context) {
//     //Navigator.of(context).push(MaterialPageRoute(builder: (context) => PageTwo()));
//     Navigator.pushReplacementNamed(context, '/todos');
//   }

//   loginAction() {
//     _signIn()
//         .then((FirebaseUser user) => print(user))
//         .catchError((e) => print(e));
//   }

//   @override
//   Widget build(BuildContext context) {
//     final bloc = Bloc();

//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Bloc Pattern"),
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           height: MediaQuery.of(context).size.height,
//           padding: EdgeInsets.all(16),
//           child: Column(
//             mainAxisSize: MainAxisSize.max,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               StreamBuilder<String>(
//                 stream: bloc.email,
//                 builder: (context, snapshot) => TextField(
//                       onChanged: bloc.emailChanged,
//                       keyboardType: TextInputType.emailAddress,
//                       decoration: InputDecoration(
//                           border: OutlineInputBorder(),
//                           hintText: "Enter email",
//                           labelText: "Email",
//                           errorText: snapshot.error),
//                     ),
//               ),
//               SizedBox(
//                 height: 20.0,
//               ),
//               StreamBuilder<String>(
//                 stream: bloc.password,
//                 builder: (context, snapshot) => TextField(
//                       onChanged: bloc.passwordChanged,
//                       keyboardType: TextInputType.text,
//                       obscureText: true,
//                       decoration: InputDecoration(
//                           border: OutlineInputBorder(),
//                           hintText: "Enter password",
//                           labelText: "Password",
//                           errorText: snapshot.error),
//                     ),
//               ),
//               SizedBox(
//                 height: 20.0,
//               ),
//               StreamBuilder<bool>(
//                 stream: bloc.submitCheck,
//                 builder: (context, snapshot) => RaisedButton(
//                       color: Colors.tealAccent,
//                       onPressed: snapshot.hasData ? () => loginAction() : null,
//                       child: Text("Submit"),
//                     ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
