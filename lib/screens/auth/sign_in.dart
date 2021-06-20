import 'package:fan_page/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

class SignIn extends StatefulWidget {
  //const ({ Key? key }) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final AuthService _auth = AuthService();
  bool isLoading = false;
  //var child;
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
      Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(children: <Widget> [
            Padding(
              padding: EdgeInsets.all(20),
              child: TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: "Enter Email Address",
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                validator: (value) {
                  if(value!.isEmpty) {
                    return 'Enter Email Address';
                  } else if (!value.contains('@')) {
                    return 'Enter Email Address';
                  }
                  return null;
                },
              )
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: TextFormField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: "Enter Password",
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                validator: (value) {
                  if(value!.isEmpty) {
                    return 'Enter Password';
                  } else if (value.length < 6) {
                    return 'Password must be 6 characters or more!';
                  }
                  return null;
                },
              )
            ),
            Padding (
              padding: EdgeInsets.all(20.0),
              child: isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.lime)),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        isLoading = true;
                      });
                      _auth.signInEmailPass();
                    }
                  },
                  child: Text('Submit'),
                )
            )
          ]
          )
        )
      ),
      //Row( 
      //  children: <Widget>[
        //  Container(
          //  //padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
//            child: ElevatedButton(
  //            child: Text('Register'),
    //          onPressed: () async {
      //          dynamic result = await _auth.register();
        //        if (result == null) {
          //        print('error signing in');
            //    } else {
              //    print('signed in');
                //  print(result.uid);
              //  }
            //  },
          //  ),
        //  ),
      // Container(
    //        //padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
  //          child: ElevatedButton(
//              child: Text('Sign in'),
  //            onPressed: () async {
    //            //dynamic result = await 
      //         _auth.signInEmailPass();
        //       _auth.isSignedIn();
                //if (result == null) {
                //  print('error signing in');
                //} else {
                //  print('signed in');
                //  print(result.uid);
                //}
          //    },
//            ),
//          ),
 //         Container(
   //         //padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
     //       child: ElevatedButton(
       //       child: Text('Sign Out'),
         //     onPressed: () async {
           //     //dynamic result = await
             //   _auth.signEmOut(); 
               // _auth.isSignedIn();
                //if (result == null) {
                //  print('error signing in');
                //} else {
                //  print('signed in');
                //  print(result.uid);
                //}
          //    },
        //    ),
      //    ),
    //    ],
  //    )
    );
  }
}
