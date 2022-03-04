import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_Fanbase_app/user.dart';

class userlist extends StatefulWidget {
  const userlist({Key? Key}) : super(key: Key);

  State<userlist> createState() => _UserListState();
}

class _UserListState extends State<userlist> {
  FireBaseFireStore _db = FireBaseFirestore.instance;

  CollectionReference users = FirebaseFirestore.instance.collection("Users");
}
