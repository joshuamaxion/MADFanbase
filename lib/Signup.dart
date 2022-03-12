import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Signup extends StatelessWidget {
  Signup({Key? Key}) : super(key: Key);
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();
  var _email = TextEditingController();
  var _password = TextEditingController();
  var _Username = TextEditingController();
  var _display = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Form(
                key: _formKey,
                child: Column(children: [
                  TextFormField(
                      controller: _Username, validator: (String? value) {}),
                  TextFormField(controller: _email),
                  TextFormField(
                    controller: _password,
                    obscureText: true,
                    validator: (String? value) {
                      if (value == null) {
                        return "You must have a password";
                      } else if (value.length < 8) {
                        return "Your Password needs 8 letters or more";
                      }
                    },
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _register(context);
                        }
                      },
                      child: const Text("Register")),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
                      },
                      child: const Text("Login")),
                  TextButton(
                      onPressed: () {}, child: const Text("Forgot Password?"))
                ]))));
  }

  void _register(BuildContext context) async {
    try {
      UserCredential Usercred = await _auth.createUserWithEmailAndPassword(
          email: _email.text, password: _password.text);
      ScaffoldMessenger.of(context).clearSnackBars();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("We can't find a user for this email")));
      } else if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Please make a stronger password")));
      }
      return;
    }
    try {
      await db
          .collection("users")
          .doc(_auth.currentUser!.uid)
          .set({"display_name": _display.text, "email": _email.text});
    } on FirebaseException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message ?? "Weird Error")));
    }
  }

  void _login(BuildContext context) async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: _email.text, password: _password.text);
      ScaffoldMessenger.of(context).clearSnackBars();
    } on FirebaseException catch (e) {
      if (e.code == 'User not found' || e.code == 'wrong-password') {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Incorrect Credentials")));
      }
      return;
    }
    try {
      await db
          .collection("users")
          .doc(_auth.currentUser!.uid)
          .set({"display_name": _display.text, "email": _email.text});
    } on FirebaseException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message ?? "Unkown Error has Occured ")));
    }
  }
}

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
