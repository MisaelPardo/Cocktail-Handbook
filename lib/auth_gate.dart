import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'pages/home_page.dart';
import 'pages/login_page.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // Enquanto verifica se existe usuário logado
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // Se existe usuário logado, vai para Home
        if (snapshot.hasData) {
          return const HomePage();
        }

        // Se não existe usuário logado, vai para Login
        return const LoginPage();
      },
    );
  }
}
