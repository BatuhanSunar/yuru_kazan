import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> signIn(String email, String sifre) async {
    var user =
        await _auth.signInWithEmailAndPassword(email: email, password: sifre);

    return user.user;
  }

  signOut() async {
    return await _auth.signOut();
  }

  Future<User?> createUser(
      String ad, String soyad, String email, String sifre) async {
    var user = await _auth.createUserWithEmailAndPassword(
        email: email, password: sifre);

    await _firestore
        .collection("Person")
        .doc(user.user?.uid)
        .set({'ad': ad, 'soyad': soyad, 'email': email, 'password': sifre});

    return user.user;
  }
}
