import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fan_page/screens/auth/register.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fan_page/screens/auth/authenticate.dart';
import 'package:fan_page/models/user.dart';

class Home extends StatelessWidget {
  //const ({ Key? key }) : super(key: key);
  Home({this.uid});
  final String? uid;

  @override
  Widget build(BuildContext context) {
    FirebaseAuth _auth = FirebaseAuth.instance;
    print("Debug0"+uid.toString());
    FirebaseFirestore.instance
    .collection('users')
    .doc(_auth.currentUser!.uid)
    .get()
    .then((DocumentSnapshot documentSnapshot) {
        final bool isAdmin = documentSnapshot.get('isAdmin');
        print("Debug1:"+isAdmin.toString());
    });
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Home"),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.exit_to_app,
              color: Colors.amber,
            ),
            onPressed: () {
              _auth.signOut().then((res) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => Authenticate()),
                  (Route<dynamic> route) => false);
              });
            },
          )
        ]
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("lib/images/IMG_8053.JPG"),
          )
        ),
        child: Stack(
          children: [
            adminMessages(),
          ],
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _displayTextInputDialog(context);
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }
  Widget adminMessages() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore
        .instance
        .collection('messages')
        .orderBy('timeStamp', descending: true)
        //.limit(20)
        .snapshots(),
        builder: (context, snapshot) {
          if(!snapshot.hasData) {
            return Center (
              child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.blue)));
          } else {
            return ListView.builder(
              padding: EdgeInsets.all(10.0),
              itemBuilder: (context, index){
                DocumentSnapshot data = snapshot.data!.docs[index];
                print ("Debug2: "+data.get('message').toString());
                return MessageBox(message: data.get('message'));
              },
              itemCount: snapshot.data!.docs.length,
              reverse: true,
            );
          }
        },
    );
  }
  
}

TextEditingController _textFieldController = TextEditingController();

Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Message Your Fans'),
          content: TextField(
            controller: _textFieldController,
            decoration: InputDecoration(hintText: "Enter a message..."),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('CLOSE'),
              onPressed: () {
                Navigator.pop(context);
                _textFieldController.clear();
              },
            ),
            TextButton(
              child: Text('POST'),
              onPressed: () {
                FirebaseFirestore
                .instance
                .collection('messages')
                .doc().set({
                  'message' : _textFieldController.text,
                  'timeStamp' : DateTime.now(),
                });
                print(_textFieldController.text);
                Navigator.pop(context);
                _textFieldController.clear();
              },
            ),
          ],
        );
      },
    );
  }
//@override
class MessageBox extends StatelessWidget {
  final String message;// = "placeholder";

  MessageBox({required this.message});

  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 8,
        bottom: 8,
      ),
      alignment: Alignment.center,
      child: Text(message,
            textAlign: TextAlign.start,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontFamily: 'OverpassRegular',
              fontWeight: FontWeight.w300
            )
      ),
    );
  }
}

















//class AdminButton extends StatelessWidget {
//  static const routeName = 'auth-button-view';
 // @override
//  Widget build(BuildContext context) {
 //   return FutureBuilder(
  //    future: (context, listen: false).isAdmin(),
  //    builder: (context, snapshot) => snapshot.hasData 
  //    ? snapshot.data
   //     ? Text("Admin!")
    //    : Text("Not Admin")
//      : Text("Loading"),
 //   );
  //}
//}
//class AuthTabBarScreen extends StatelessWidget {
 // static const routeName = 'auth-tab-bar-view';
  //@override
  //Widget build(BuildContext context) {
   // return FutureBuilder(
    //  future: Provider.of<Auth>(context, listen: false).isAdmin(),
 //     builder: (context, snapshot) => snapshot.hasData
 //         ? snapshot.data // if isAdmin() is true
 //             ? AdminTabBarScreen() // return Admin
 //             : UserTabBarScreen() // else if false, return UserTab
  //        : Loading(), // while you're waiting for the data, show some kind of loading indicator
  //  );
 // }
//}
//Future<bool> isAdmin(String? userID) async {
    //bool fuckinAdmin = false;
    //FirebaseFirestore.instance
    //.collection('users')
    //.doc(userID)
    //.get()
    //.then((DocumentSnapshot documentSnapshot) {
    //  if(documentSnapshot.exists) {
    //    //bool isAdmin = documentSnapshot.get('isAdmin');
    //    
    //    fuckinAdmin = documentSnapshot.get('isAdmin');
    //    print("Debug4:"+fuckinAdmin.toString());
    //    return fuckinAdmin;
    //    
      // //else {
        //final bool isAdmin = false;
        
       // print("Debug1: document does not exist");
      //  return false;
     // }
    //});
    //print("Debug: THIS SHOULD NOT PRINT");
    //return fuckinAdmin;
    
    
    //final currentUserUid = _auth.currentUser!.uid;
    //What I'm trying to do here is get my isAdmin field which is created when a user is created
    //final DocumentSnapshot db = await 
    //      databaseReference.collection('users').doc(currentUserUid).get();
    //return db.data().containsKey('isAdmin');
   // FirebaseAuth _auth = FirebaseAuth.instance;
   // final currentUserUid = _auth.currentUser!.uid;
   // print ("Debug 5: " + currentUserUid);
   // final DocumentSnapshot documentSnapshot = FirebaseFirestore.instance.collection('users').doc(currentUserUid) as DocumentSnapshot<Object?>;
   // print(documentSnapshot.toString());
  //  return false;
//}

    //final bool isAdmin = documentSnapshot.get('isAdmin');
    //DocumentReference userRef = _firestoreUser.doc(_auth.currentUser!.uid);
    //DataSnapshot userData = userRef.get().addSnapshotListener();
    //Api
    //DocumentSnapshot userDoc = future.get();
    //DocumentReference _firestoreMessages = FirebaseFirestore.instance.collection('messages').snapshots();

 //   userRef.get().addOnComplete(new OnCompleteListener <DocumentSnapshot>() {
 //     @Override
 //     public void onComplete(@NonNull Task<DocumentSnapshot> task) {
 //       if(task.isSuccessful()) {
 //         DocumentSnapshot userDoc = task.getResult();
   //       if (userDoc.exists()) {
    //            Log.d(TAG, "DocumentSnapshot data: " + userDoc.getData());
    //        } else {
    //            Log.d(TAG, "No such document");
    //        }
    //    } else {
    //        Log.d(TAG, "get failed with ", task.getException());
    //    }
    //  }
    //});
    