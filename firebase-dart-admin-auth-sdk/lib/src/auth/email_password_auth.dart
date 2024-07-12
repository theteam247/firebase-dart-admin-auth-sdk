import 'package:firebase_dart_admin_auth_sdk/src/firebase_auth.dart';
import 'package:firebase_dart_admin_auth_sdk/src/user_credential.dart';
import 'package:firebase_dart_admin_auth_sdk/src/action_code_settings.dart';

class EmailPasswordAuth {
  final FirebaseAuth auth;

  EmailPasswordAuth(this.auth);

  Future<UserCredential> signIn(String email, String password) async {
    final response = await auth.performRequest('signInWithPassword', {
      'email': email,
      'password': password,
      'returnSecureToken': true,
    });

    final userCredential = UserCredential.fromJson(response);
    auth.updateCurrentUser(userCredential.user);
    return userCredential;
  }

  Future<UserCredential> signUp(String email, String password) async {
    final response = await auth.performRequest('signUp', {
      'email': email,
      'password': password,
      'returnSecureToken': true,
    });

    final userCredential = UserCredential.fromJson(response);
    auth.updateCurrentUser(userCredential.user);
    return userCredential;
  }

  Future<void> sendPasswordResetEmail(
      String email, ActionCodeSettings settings) async {
    await auth.performRequest('sendOobCode', {
      'requestType': 'PASSWORD_RESET',
      'email': email,
      ...settings.toMap(),
    });
  }
}
