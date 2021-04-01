import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../../infrastructure/auth/auth_service.dart';

class AuthProvider with ChangeNotifier {
  bool isLoading;

  final IAuthService auth;
  AuthProvider({
    @required this.auth,
    this.isLoading = false,
  });

  void updateWith({bool isLoading}) {
    this.isLoading = isLoading ?? this.isLoading;
    notifyListeners();
  }

  Future<void> submit() async {
    updateWith(isLoading: true);
    try {
      await auth.signInWithFb();
      updateWith(isLoading: false);
    } on PlatformException catch (e) {
      updateWith(isLoading: false);
      print(e.toString());
      rethrow;
    }
  }

  User get currentUser => auth.getCurrentUser();

  Future<void> logout() async {
    try {
      await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  bool get canSubmit => !isLoading;
}
