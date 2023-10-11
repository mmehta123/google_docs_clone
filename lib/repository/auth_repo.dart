import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_docs_clone/constants.dart';
import 'package:google_docs_clone/models/error_model.dart';
import 'package:google_docs_clone/models/user_model.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';

final authRepoProvider =
    Provider((ref) => AuthRepo(googleSignIn: GoogleSignIn(), client: Client()));

final userProvider = StateProvider<User?>((ref) => null);

class AuthRepo {
  final GoogleSignIn _googleSignIn;
  final Client _client;
  AuthRepo({required GoogleSignIn googleSignIn, required Client client})
      : _googleSignIn = googleSignIn,
        _client = client;

  Future<ErrorModel> signInWithGoogle() async {
    ErrorModel error = ErrorModel(error: "something went wrong ", data: null);
    try {
      final user = await _googleSignIn.signIn();
      if (user != null) {
        final userAcc = User(
          name: user.displayName ?? '',
          email: user.email,
          profilePic: user.photoUrl ?? "",
          uid: "",
          token: "",
        );
        final response = await _client.post(Uri.parse("$host/api/signup"),
            body: userAcc.toJson(),
            headers: {"Content-Type": "application/json; charset=UTF-8"});
        switch (response.statusCode) {
          case 200:
            final fetchedUser = jsonDecode(response.body)['user'];
            final newUser = userAcc.copyWith(
              email: fetchedUser['email'],
              name: fetchedUser['name'],
              profilePic: fetchedUser['profilePic'],
              uid: fetchedUser['_id'],
            );
            error = ErrorModel(error: null, data: newUser);
            break;
          case 400:
            final fetchedError = jsonDecode(response.body)['error'];
            error = ErrorModel(error: fetchedError, data: null);
        }
      }
    } catch (e) {
      error = ErrorModel(error: e.toString(), data: null);
    }
    return error;
  }
}
