import 'package:fan_page/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

class SignIn extends StatefulWidget {
  //const ({ Key? key }) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  
  final AuthService _auth = AuthService();

  var child;
 // User user = await _auth.instance.signIn


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[100],
      appBar: AppBar(
        backgroundColor: Colors.pink[400],
        elevation: 0.0,
        title: Text('Sign in to my lame ass app'),
      ),
      body: 
      
      Row( 
        children: <Widget>[
          Container(
            //padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
            child: ElevatedButton(
              child: Text('Register'),
              onPressed: () async {
                dynamic result = await _auth.register();
                if (result == null) {
                  print('error signing in');
                } else {
                  print('signed in');
                  print(result.uid);
                }
              },
            ),
          ),
          Container(
            //padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
            child: ElevatedButton(
              child: Text('Sign in'),
              onPressed: () async {
                //dynamic result = await 
               _auth.signInEmailPass();
               _auth.isSignedIn();
                //if (result == null) {
                //  print('error signing in');
                //} else {
                //  print('signed in');
                //  print(result.uid);
                //}
              },
            ),
          ),
          Container(
            //padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
            child: ElevatedButton(
              child: Text('Sign Out'),
              onPressed: () async {
                //dynamic result = await
                _auth.signEmOut(); 
                _auth.isSignedIn();
                //if (result == null) {
                //  print('error signing in');
                //} else {
                //  print('signed in');
                //  print(result.uid);
                //}
              },
            ),
          ),
        ],
      )
    );
  }
}
