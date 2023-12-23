import 'package:firebase_auth/firebase_auth.dart';

class AuthManager {
  final _auth = FirebaseAuth.instance;

  User? getCurrentUser() {
    return _auth.currentUser;
  }

  Future<bool> signIn() async {
    try {
      final response = await _auth.signInAnonymously();
      return response.user != null;
    } catch(e) {
      print(e);
      return false;
    }
  }
}