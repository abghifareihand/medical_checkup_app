import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:medical_checkup_app/data/models/user_response.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final usersCollection = FirebaseFirestore.instance.collection('users');
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> register(
      String name, String email, String password, String role) async {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    UserResponse user = UserResponse(
      uid: userCredential.user!.uid,
      name: name,
      email: email,
      role: role,
    );
    await usersCollection.doc(user.uid).set(user.toMap());
  }

  Future<UserResponse?> login(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;

      DocumentSnapshot doc =
          await _firestore.collection('users').doc(user!.uid).get();
      return UserResponse.fromMap(doc.data() as Map<String, dynamic>);
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<void> signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<String?> getUserRole() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        DocumentSnapshot doc =
            await _firestore.collection('users').doc(user.uid).get();
        return doc['role'];
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }
}
