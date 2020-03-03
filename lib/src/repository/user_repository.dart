import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserRepository {

  UserRepository(
      {FirebaseAuth firebaseAuth, GoogleSignIn googleSignin, FacebookLogin facebookLogin})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignin ?? GoogleSignIn(),
        _facebookLogin = facebookLogin ?? FacebookLogin();

  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final FacebookLogin _facebookLogin;

  Future<FirebaseUser> signInWithGoogle() async {
    final googleUser = await _googleSignIn.signIn();
    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final user = (await _firebaseAuth.signInWithCredential(credential)).user;
    return user;
  }

  Future<FirebaseUser> signInWithFacebook() async {
    final result = await _facebookLogin.logIn(['email']);
    final credential = FacebookAuthProvider.getCredential(
      accessToken: result.accessToken.token,
    );
    try {
      final user = (await _firebaseAuth.signInWithCredential(credential)).user;
      return user;
    } on PlatformException catch (e) {
      if (e.code != 'ERROR_ACCOUNT_EXISTS_WITH_DIFFERENT_CREDENTIAL') {
        rethrow;
      }
      final httpClient = HttpClient();
      final graphRequest = await httpClient.getUrl(Uri.parse(
          "https://graph.facebook.com/v2.12/me?fields=email&access_token=${result
              .accessToken.token}"));
      final graphResponse = await graphRequest.close();
      final graphResponseJSON = json.decode(await graphResponse
          .transform(utf8.decoder)
          .single);
      final email = graphResponseJSON["email"];
      final signInMethods = await FirebaseAuth.instance.fetchSignInMethodsForEmail(email: email);
      final user = await signInWithGoogle();
      if (user.email == email) {
        await user.linkWithCredential(credential);
      }
    }
  }

  Future<FirebaseUser> signInWithCredentials(String email,
      String password) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return _firebaseAuth.currentUser();
  }

  Future<FirebaseUser> signUp(
      {String email, String password, String phone}) async {
    final user = (await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    )).user;
    return user;
  }

  Future<void> signOut() async {
    return Future.wait([
      _firebaseAuth.signOut(),
      _googleSignIn.signOut(),
      _facebookLogin.logOut(),
    ]);
  }

  Future<bool> isSignedIn() async {
    final currentUser = await _firebaseAuth.currentUser();
    return currentUser != null;
  }

  Future<String> getUser() async {
    return (await _firebaseAuth.currentUser()).email;
  }
}