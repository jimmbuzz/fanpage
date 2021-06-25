import 'package:fan_page/screens/auth/register.dart';
import 'package:fan_page/screens/auth/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:fan_page/screens/home/home.dart';

//import 'package:flutter_signin_button/flutter_signin_button.dart';

class Authenticate extends StatefulWidget {
  //const ({ Key? key }) : super(key: key);

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  @override

  late User _user;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  CollectionReference _firestore = FirebaseFirestore.instance.collection('users'); 
  //FirebaseFirestore db = FirebaseFirestore.instance;

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
                  //fontFamily: 'Comic_Sans',
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
                      signInWithGoogle();
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
  //Future<UserCredential> 
  void signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    
    //print ("Debug"+credential.asMap().toString());
    //credential.accessToken;
    // Once signed in, return the UserCredential
    //UserCredential userCred = await FirebaseAuth.instance.signInWithCredential(credential);
    //print (userCred.additionalUserInfo);
    _auth.signInWithCredential(credential).then((result) {



      //DocumentReference docRef = db.collection("users").doc(_auth.currentUser!.uid);
      FutureBuilder<DocumentSnapshot> (
        future: _firestore.doc(_auth.currentUser!.uid).get(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }
          if (snapshot.hasData && !snapshot.data!.exists) {
            print("No user data");
            _firestore.doc(_auth.currentUser!.uid).set({
              'uid' : _auth.currentUser!.uid,
              'email' : _auth.currentUser!.email,
              'firstname' : _auth.currentUser!.displayName,
              'isAdmin': false, 
              'regDateTime' : DateTime.now(),
            });
            return Text("No user data");
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return Text("Data!");
          }
          return Text("loading");
        },
      ); 


      print("Debug: "+_auth.currentUser!.email.toString());
      Navigator.pushReplacement (
          context,
          MaterialPageRoute(builder: (context) => Home(uid: result.user!.uid)),
        );
    });//.then((res) {
      
   //});
    //UserCredential result = _auth.currentUser;
    
    //if (_firestore.doc(_auth.currentUser!.uid).exists())
    //DocumentReference userDocRef = _firestore.doc(_auth.currentUser!.uid);
   // userDocRef.get().then((docData) => {
   //   if (docData.exists) {
  //  //     print("This user already has data")
  //     } else {
  //       print("This user needs data")
  //     }
  //   }).catchError((err) => {
  //     print(err)
  //   });
  //   Navigator.pushReplacement (
  //         context,
  //         MaterialPageRoute(builder: (context) => Home(uid: result.user!.uid)),
  //   );
    //const doc = await userDocRef.get() 
    //.then(doc => {

   //}
   // );
    
  }
}