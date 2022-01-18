import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobile_outcastbarber/models/userData.dart';
import 'package:shared_preferences/shared_preferences.dart';

//data are stored in local storage named "user"
class UserProfile {
  final CollectionReference _usersCollectionReference =
      FirebaseFirestore.instance.collection('users');

  //check user data in local storage
  Future<bool> checkUser() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('user') == null) {
      return false;
    }
    return true;
  }

  //when they create new user
  Future createUser(String uid, UserData data) async {
    try {
      //save user data to firestore
      await _usersCollectionReference.doc(uid).set(data.toJson());

      //save user data to local storage
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('user', jsonEncode(data.toJson()));
    } catch (e) {}
  }

  //when they login 
  Future getUser(String uid) async {
    try {
      var data = await _usersCollectionReference.doc(uid).get();
      //Save user data to local storage
      SharedPreferences prefs = await SharedPreferences.getInstance();    
      await prefs.setString('user', jsonEncode(data.data()));
      prefs.getString('user');
    } catch (e) {}
  }

  //when they trigger button in profile setting
  Future updateUser(String uid) async {}

  //delete
  Future deleteUser() async {
    //detele user data from local storage
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //delete all save data in phone storage
    await prefs.clear();
  }
}
