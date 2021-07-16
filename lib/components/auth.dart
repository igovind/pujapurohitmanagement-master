import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Users {
  Users({required this.uid,this.photoUrl,this.displayName});
  final String uid;
  final String? displayName;
  final String? photoUrl;
}

abstract class AuthBase {
  Stream<Users?> get onAuthChanged;
  Future<Users?> createUserWithEmailAndPassword(String email,String password);
  Future<Users?> signInWithEmailAndPassword(String? email,String? password);
  Future<Users?> currentUser();
  Future<void> signOut();
  Future<String> updateUser(String name);

}

class Auth implements AuthBase {
  final _firebaseAuth = FirebaseAuth.instance;
  Users? _userFromFirebase(User? user) {
    if (user == null) {
      return null;
    }
    return Users(uid: user.uid,photoUrl: user.photoURL,displayName: user.displayName);
  }
  @override
  Stream<Users?> get onAuthChanged {
    return _firebaseAuth.authStateChanges().map(_userFromFirebase);
  }

  @override
  Future<Users?> currentUser() async {
    final user = await _firebaseAuth.currentUser;
    return _userFromFirebase(user);
  }

  @override
  Future<String> updateUser(String name) async {
    var user = await _firebaseAuth.currentUser!;
    await user.updateProfile(displayName: name);
    await user.reload();
    return user.uid;
  }
  @override
  Future<Users?> createUserWithEmailAndPassword(String email,String password) async{
    final authResult=await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    return _userFromFirebase(authResult.user);
  }
  @override
  Future<Users?> signInWithEmailAndPassword(String? email,String? password) async{
    final authResult=await _firebaseAuth.signInWithEmailAndPassword(email: email!, password: password!);
    return _userFromFirebase(authResult.user);
  }
  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
