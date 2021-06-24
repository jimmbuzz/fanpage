import 'package:fan_page/screens/auth/register.dart';
import 'package:fan_page/screens/auth/sign_in.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_signin_button/flutter_signin_button.dart';

class Authenticate extends StatefulWidget {
  //const ({ Key? key }) : super(key: key);

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register Or Login"),
        backgroundColor: Colors.indigo[400],
      ),
      body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children : <Widget>[
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Text("Fan Page",
                style: TextStyle (
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Comic_Sans',
                  fontSize: 30,
                )  
              ) 
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
                child: ElevatedButton(
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.indigo)),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EmailSignUp()),
                      );
                    },
                    child: Text('Sign Up'),
                  ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: ElevatedButton(
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.indigo)),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignIn()),
                      );
                    },
                    child: Text('Sign in with Google'),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
                child: ElevatedButton(
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.indigo)),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignIn()),
                      );
                    },
                    child: Text('Login With Email'),
                  ),
            ),
          ]),
      )
    );
  }
}