import 'package:flutter/material.dart';

import 'auth_gate.dart';
import 'pages/cadastro_page.dart';
import 'pages/home_page.dart';
import 'pages/login_page.dart';
import 'pages/my_notes_page.dart';
import 'pages/nova_avaliacao_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cocktail Handbook',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFDCAE53)),
        useMaterial3: true,
      ),
      routes: {
        '/login': (context) => const LoginPage(),
        '/cadastro': (context) => const CadastroPage(),
        '/home': (context) => const HomePage(),
        '/historico': (context) => const MyNotesPage(),
        '/nova-avaliacao': (context) => const NovaAvaliacaoPage(),
      },
      home: const AuthGate(),
    );
  }
}