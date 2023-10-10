import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_docs_clone/colors.dart';
import 'package:google_docs_clone/repository/auth_repo.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  void signInWithGoogle(WidgetRef ref) {
    ref.read(authRepoProvider).signInWithGoogle();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        body: Center(
      child: ElevatedButton.icon(
        onPressed: () {
          signInWithGoogle(ref);
          print("hello");
        },
        icon: Image.asset(
          "assets/images/g-logo-2.png",
          height: 20,
        ),
        label: const Text("Sign In With Google"),
        style: ElevatedButton.styleFrom(
            minimumSize: const Size(150, 50), backgroundColor: whiteColor),
      ),
    ));
  }
}
