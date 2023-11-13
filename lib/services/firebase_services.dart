import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseServices {
  //Admin login
  static Future<DocumentSnapshot> adminLogin(id) async {
    var result =
        await FirebaseFirestore.instance.collection("admin").doc(id).get();
    return result;
  }

  //Create Account
  static Future<String?> createAccount(String email, String password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        return "email already in use";
      }
      if (e.code == "weak-password") {
        return "password is too weak";
      }
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

//Sign Out
  static Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

//SignIn Account
  static Future<String?> signInAccount(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == "weak-password") {
        return "password is too weak";
      }
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }
}
