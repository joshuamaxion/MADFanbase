import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter'

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class Signup extends StatelessWidget{
 Signup({Key? Key}) : super(key: key);
 final FirebaseAuth _auth = FirebaseAuth.instance;
 final FirebaseFirestore db = FirebaseFirestore.instance;
final  _formKey = GlobalKey<FormState>();
var _email = TextEditingController();
var _password = TextEditingController();
var _Username = TextEditingController();
@override
Widget build(BuildContext context){
    return Center(
        child: Form(
          key: _formKey,
            child: Column(
                children:[
                    TextFormField(controller: _Username,
                validator:(String? value){

                }),
                    TextFormField(controller: _email),
                    TextFormField(controller: _password,
                    obscureText: true,
                    validator:(String? value){
                      if( value == null){
                        return "You must have a password";
                    }else if (value.length < 8){
                    return "Your Password needs 8 letters or more";
                    }
                    },
                    ),
                    ElevatedButton(onPressed: (){if(_formKey.currentState!.validate()){
                        _register();
                    }

                      },
                        child: const Text("Register")),
                    ElevatedButton(onPressed: (){}, child: const Text("Login"))),
                    TextButton(onPressed: (){}, child: const Text("Forgot Password?"))
                ]

            )
        )
    );
}
void _register() async{
_auth.signInWithEmailAndPassword(email: _email.text, password: _password.text)
}
    }