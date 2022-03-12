import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'User.dart';

class userlist extends StatefulWidget {
  const userlist({Key? Key}) : super(key: Key);

  State<userlist> createState() => _UserListState();
}

class _UserListState extends State<userlist> {
  FireBaseFireStore _db = FireBaseFirestore.instance;

  CollectionReference users = FirebaseFirestore.instance.collection("Users");
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream:users.snapshots(),
        builder:(BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if(snapshot.hasError){
            return const Text("Something went wrong querying users");
          }
          if (snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator());
          }
          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot doc) {
              User user = 
              User.fromJson(doc.id,doc.data()) as Map<String,dynamic>);
              return ListTile(
                title: Text(user.displayName),
                subtitle:Text(user.role),

              )
            }
          )
        }
      )
    )
    
  }
}
