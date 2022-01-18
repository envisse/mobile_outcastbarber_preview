//USING GOOGLE FIREBASE AUTHENTICATION
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile_outcastbarber/models/userData.dart';
import 'package:mobile_outcastbarber/routes/args/verification_args.dart';
import 'package:mobile_outcastbarber/services/repository/firebase/userProfile.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;
  AuthenticationService(this._firebaseAuth);
  UserProfile userProfile = UserProfile();

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  //Sign out (Logout)
  Future<bool> signout(BuildContext context) async {
    try {
      await userProfile.deleteUser();
      await _firebaseAuth.signOut();
      return true;
    } on FirebaseAuthException {
      return false;
    }
  }

  //Sign in (Login)
  Future<bool> signin(String email, String password) async {
    try {
      var datauser = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      await UserProfile().getUser(datauser.user!.uid);
      return true;
    } on FirebaseAuthException {
      return false;
    }
  }

  //Sign Up (Register)
  Future<bool> signup(
      VerificationArgs verificationArgs, BuildContext context) async {
    try {
      var authresult = await _firebaseAuth.createUserWithEmailAndPassword(
          email: verificationArgs.email, password: verificationArgs.password);
      //Store Userdata to firestore
      var userdata = UserData(
          uid: authresult.user!.uid,
          email: verificationArgs.email,
          username: verificationArgs.username);
      await userProfile.createUser(authresult.user!.uid, userdata);
      return true;
    } on FirebaseAuthException {
      return false;
    }
  }
}
