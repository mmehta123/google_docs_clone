import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_docs_clone/colors.dart';
import 'package:google_docs_clone/repository/auth_repo.dart';
import 'package:google_docs_clone/screens/home_screen.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  void signInWithGoogle(WidgetRef ref, BuildContext context) async {
    final sMessager = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);
    final errorModel = await ref.read(authRepoProvider).signInWithGoogle();
    if (errorModel.error == null) {
      ref.read(userProvider.notifier).update((state) => errorModel.data);
      navigator.push(
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    } else {
      sMessager.showSnackBar(SnackBar(content: Text(errorModel.error!)));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        body: Center(
      child: ElevatedButton.icon(
        onPressed: () {
          signInWithGoogle(ref, context);
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
