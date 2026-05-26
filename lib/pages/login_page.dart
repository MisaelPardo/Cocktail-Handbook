import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import 'cadastro_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final senhaController = TextEditingController();
  final AuthService authService = AuthService();

  bool carregando = false;
  String mensagem = '';
  bool ocultarSenha = true;

  Future<void> entrar() async {
    final email = emailController.text.trim();
    final senha = senhaController.text.trim();

    if (email.isEmpty || senha.isEmpty) {
      setState(() => mensagem = 'Preencha o e-mail e a senha.');
      return;
    }

    setState(() {
      carregando = true;
      mensagem = '';
    });

    try {
      await authService.entrarUsuario(email: email, senha: senha);
    } on FirebaseAuthException catch (e) {
      setState(() {
        if (e.code == 'invalid-email') {
          mensagem = 'E-mail com formato inválido.';
        } else if (e.code == 'invalid-credential') {
          mensagem = 'E-mail ou senha incorretos.';
        } else {
          mensagem = 'Erro de autenticação: ${e.message}';
        }
        carregando = false;
      });
    } catch (e) {
      setState(() {
        mensagem = 'Erro inesperado: $e';
        carregando = false;
      });
    }
  }

  void abrirCadastro() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CadastroPage()),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    senhaController.dispose();
    super.dispose();
  }

 @override
  Widget build(BuildContext context) {
    final tecladoAberto = MediaQuery.of(context).viewInsets.bottom > 0;

    return Scaffold(
      backgroundColor: const Color(0xFF031A12),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final double screenHeight = constraints.maxHeight;
            // Deteta se o ecrã está no modo compacto (menor que 620px de altura)
            final bool isCompact = screenHeight < 620;

            // 🚀 A SOLUÇÃO PARA O TAMANHO DO LOGOTIPO:
            final double logoLayoutSize = isCompact ? 80.0 : 130.0;
            final double logoRenderSize = isCompact ? 300.0 : 480.0; 
            final double fallbackIconSize = isCompact ? 56.0 : 80.0;

            // Espaçadores dinâmicos calculados para evitar rolagem
            final double spaceLogoToTitle = isCompact ? 8.0 : 16.0;
            final double spaceTitleToFields = isCompact ? 16.0 : 36.0;
            final double spaceBetweenFields = isCompact ? 8.0 : 14.0;
            final double spaceFieldsToButton = isCompact ? 16.0 : 32.0;
            final double spaceButtonToText = isCompact ? 8.0 : 16.0;
            final double spaceTextToErrors = isCompact ? 6.0 : 12.0;
            final double buttonHeight = isCompact ? 46.0 : 50.0;

            // Permite rolar apenas se o teclado estiver ativo ou se a altura do ecrã for mínima
            final bool permitirScroll = tecladoAberto || screenHeight < 480;

            return SingleChildScrollView(
              physics: permitirScroll 
                  ? const BouncingScrollPhysics() 
                  : const NeverScrollableScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 400),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 24.0, 
                          vertical: isCompact ? 12.0 : 32.0,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // 🍸 LOGOTIPO:
                            Center(
                              child: SizedBox(
                                width: logoLayoutSize,
                                height: logoLayoutSize,
                                child: OverflowBox(
                                  minWidth: logoRenderSize,
                                  maxWidth: logoRenderSize,
                                  minHeight: logoRenderSize,
                                  maxHeight: logoRenderSize,
                                  child: Image.asset(
                                    'assets/icons/app_icon.png',
                                    fit: BoxFit.contain,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Icon(
                                        Icons.local_bar,
                                        size: fallbackIconSize,
                                        color: const Color(0xFFDCAE53),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: spaceLogoToTitle),
                            Text(
                              'Bem-vindo ao\nCocktail Handbook',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: isCompact ? 22 : 28,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'serif',
                              ),
                            ),
                            SizedBox(height: spaceTitleToFields),
                            TextField(
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                hintText: 'E-mail',
                                hintStyle: const TextStyle(color: Colors.white54),
                                prefixIcon: const Icon(
                                  Icons.email_outlined,
                                  color: Colors.white54,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.white24,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.white,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 18,
                                ),
                              ),
                            ),
                            SizedBox(height: spaceBetweenFields),
                            TextField(
                              controller: senhaController,
                              obscureText: ocultarSenha,
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                hintText: 'Senha',
                                hintStyle: const TextStyle(color: Colors.white54),
                                prefixIcon: const Icon(
                                  Icons.lock_outline,
                                  color: Colors.white54,
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    ocultarSenha
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: Colors.white54,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      ocultarSenha = !ocultarSenha;
                                    });
                                  },
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.white24,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.white,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 18,
                                ),
                              ),
                            ),
                            SizedBox(height: spaceFieldsToButton),
                            SizedBox(
                              height: buttonHeight,
                              child: ElevatedButton(
                                onPressed: carregando ? null : entrar,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: const Color(0xFF031A12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: carregando
                                    ? const SizedBox(
                                        height: 24,
                                        width: 24,
                                        child: CircularProgressIndicator(
                                          color: Color(0xFF031A12),
                                          strokeWidth: 2.5,
                                        ),
                                      )
                                    : const Text(
                                        'Entrar',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                              ),
                            ),
                            SizedBox(height: spaceButtonToText),
                            TextButton(
                              onPressed: abrirCadastro,
                              style: TextButton.styleFrom(
                                minimumSize: Size.zero,
                                padding: EdgeInsets.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              child: const Text(
                                'Criar conta',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            if (mensagem.isNotEmpty) ...[
                              SizedBox(height: spaceTextToErrors),
                              Text(
                                mensagem,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.redAccent,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}