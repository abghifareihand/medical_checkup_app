import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:medical_checkup_app/data/models/user_model.dart';

class AuthRemoteDatasource {
  FirebaseAuth auth = FirebaseAuth.instance;
  final usersCollection = FirebaseFirestore.instance.collection('users');

  // Register
  Future<void> register(
      String name, String email, String password, String role) async {
    UserCredential userCredential = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    UserModel user = UserModel(
      uid: userCredential.user!.uid,
      name: name,
      email: email,
      role: role,
    );
    await usersCollection.doc(user.uid).set(user.toMap());
  }

// Login
  Future<UserModel?> login(String email, String password) async {
    UserCredential userCredential =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    DocumentSnapshot userDoc =
        await usersCollection.doc(userCredential.user!.uid).get();
    if (userDoc.exists) {
      return UserModel.fromMap(userDoc.data() as Map<String, dynamic>);
    }
    return null;
  }
}
