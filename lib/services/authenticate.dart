import 'package:amen/blocs/bloc_router.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

class DbFire {
  FirebaseAuth _auth = FirebaseAuth.instance;
  dynamic errorCode = '';
  dynamic errorMessage = '';

  Future signUp(String emailController, String passwordController,
      String nameController, BuildContext context) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
              email: emailController, password: passwordController);
      User? user = userCredential.user;
      User? currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser != null) {
        FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

        CollectionReference users = firebaseFirestore.collection(
            'users/id_${currentUser.uid}/${nameController.toString()}');
        Map<String, dynamic> userdata = {
          'name': nameController,
          'email': emailController,
        };
        users.add(userdata);
        print('geschaft');
        user!.updateProfile(displayName: nameController);
      } else {
        throw PlatformException(
            code: errorCode, message: errorMessage as String);
      }
      return user;
    } on FirebaseAuthException catch (e) {
      print(e.code);
    }
  }

  Future signIn(String emailController, String passwordController,
      BuildContext context) async {
    try {
      UserCredential usercredential = await _auth.signInWithEmailAndPassword(
          email: emailController, password: passwordController);
      User? user = usercredential.user;
      User? currentUser = _auth.currentUser;

      if (currentUser != null) {
        print('geschaft');
        Navigator.pushReplacement(context, BlocRouter().halloPage(user));
      } else {
        throw PlatformException(code: errorCode, message: errorMessage);
      }

      return user;
    } on FirebaseAuthException catch (e) {
      print(e.code);

      Fluttertoast.showToast(
          msg: ' Error: ${e.code}',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.white,
          textColor: Colors.amber,
          fontSize: 16.0);
    }
  }

  Future signOut() async {
    await _auth.signOut();
  }
}
