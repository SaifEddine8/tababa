import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {


  Future<String>login({
    required String email,
    required String password
  })async{

    try{
      final credential=await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email, password: password);
        return 'done login';

    }on FirebaseAuthException catch(e)
    {
      if(e.code=='invalid-email')
      {
        return 'invalid email';
      }
      else if(e.code=='invalid-credential')
      {
        return 'invalid credential';
      }
      return e.message??e.code;
    }
  }


  Future<String>signUp({
    required String email,
    required String password,
    required String name,
    required BuildContext context
  })async
  {
    try{
      final credential=await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email, password: password);
        FirebaseFirestore.instance.
        collection('users')
        .doc(credential.user!.uid)
        .set({
          'email':email,
          'name':name
        })
        .then((value)=>ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('user added successfully'))))
        .catchError((error)=>ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Field to add user'))));
    }on FirebaseAuthException catch(e)
    {
      if(e.code=='weak-password')
      {
        return 'the password is too weak';
      }
      if(e.code=='email-already-in-use')
      {
        return 'the account already exists for that email';
      }
    }
    catch(e)
    {
      return e.toString();
    }
    return 'error';
  }


  void signout()async{
    FirebaseAuth.instance.signOut();
  }
}