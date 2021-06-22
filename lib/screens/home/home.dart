import 'package:flutter/material.dart';
import 'package:fan_page/screens/auth/register.dart';

class Home extends StatelessWidget {
  //const ({ Key? key }) : super(key: key);
  Home({this.uid});
  final String? uid;
  final String title = "Home";

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
        builder:(context, snapshot) {
         //if (!snapshot.hasData) {
            return Center (
              child: CircularProgressIndicator (
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              ) 
            ,);
          //} else {
            //return ListView.builder(
              //padding: EdgeInsets.all(10.0),
              //itemBuilder: (context, index) => buildItem(context, snapshot.data.documents[index]),
              //itemCount: snapshot.data.documents.length,
            //);
          //}
        },
        )
    );
  }
}