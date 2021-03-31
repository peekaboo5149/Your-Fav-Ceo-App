import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

abstract class IAuthService {
  Stream<User> getCurrentUserState();
  User getCurrentUser();
  Future<User> signInWithFb();
  Future<void> signOut();
}

class AuthService extends IAuthService {
  final _auth = FirebaseAuth.instance;
  final _fbLogin = FacebookLogin();

  @override
  Future<User> signInWithFb() async {
    final result = await _fbLogin.logIn(
      ['email', 'public_profile'],
    );
    if (result.accessToken != null) {
      try {
        final UserCredential userCreds =
            await _auth.signInWithCredential(FacebookAuthProvider.credential(
          result.accessToken.token,
        ));
        return userCreds.user;
      } catch (e) {
        if (e.code != 'ERROR_ACCOUNT_EXISTS_WITH_DIFFERENT_CREDENTIAL') throw e;
        final httpClient = HttpClient();
        final graphRequest = await httpClient.getUrl(Uri.parse(
            "https://graph.facebook.com/v2.12/me?fields=email&access_token=${result.accessToken.token}"));
        final graphResponse = await graphRequest.close();
        final graphResponseJSON =
            json.decode((await graphResponse.transform(utf8.decoder).single));
        final email = graphResponseJSON["email"];
        final signInMethods = await _auth.fetchSignInMethodsForEmail(email);
        print(signInMethods);
        bool isProviderGoogle = signInMethods.contains('google.com');
        if (isProviderGoogle)
          throw PlatformException(
              code: 'ERROR_ALREADY_HAS_ACCOUNT',
              details: {
                'email': email,
                'creds': FacebookAuthProvider.credential(
                  result.accessToken.token,
                )
              },
              message: 'Try signing in with Google');
        else
          throw PlatformException(
              code: 'ERROR_ALREADY_HAS_ACCOUNT',
              details: {
                'email': email,
                'creds': FacebookAuthProvider.credential(
                  result.accessToken.token,
                )
              },
              message: 'Try signing in with Email & Password');
      }
    } else {
      throw PlatformException(
          code: 'ERROR_ABORTED_BY_USER', message: 'Sign in aborted by user');
    }
  }

  @override
  Future<void> signOut() async {
    await _fbLogin.logOut();
    await _auth.signOut();
  }

  @override
  User getCurrentUser() {
    return _auth.currentUser;
  }

  @override
  Stream<User> getCurrentUserState() {
    return _auth.authStateChanges();
  }
}
