import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final nomeController = TextEditingController();
  final emailController = TextEditingController();
  final senhaController = TextEditingController();
  final AuthService authService = AuthService();

  bool carregando = false;
  List<String> mensagensErro = [];
  bool ocultarSenha = true;

  Future<void> cadastrar() async {
    final nome = nomeController.text.trim();
    final email = emailController.text.trim();
    final senha = senhaController.text.trim();

    List<String> errosAtuais = [];

    // Validação de Nome
    if (nome.isEmpty) {
      errosAtuais.add('Preencha o campo nome.');
    } else {
      final nomeRegex = RegExp(r'^[a-zA-ZÀ-ÿ\s]+$');
      if (!nomeRegex.hasMatch(nome)) {
        errosAtuais.add('O Nome deve conter apenas letras.');
      }
    }

    // Validação de E-mail
    if (email.isEmpty) {
      errosAtuais.add('Preencha o campo e-mail.');
    } else if (!email.toLowerCase().endsWith('@gmail.com')) {
      errosAtuais.add('O E-mail deve terminar com @gmail.com.');
    }

    // Validação de Senha
    if (senha.isEmpty) {
      errosAtuais.add('Preencha o campo senha.');
    } else if (senha.length < 6) {
      errosAtuais.add('A Senha deve ter pelo menos 6 caracteres.');
    }

    if (errosAtuais.isNotEmpty) {
      setState(() {
        mensagensErro = errosAtuais;
      });
      return;
    }

    setState(() {
      carregando = true;
      mensagensErro.clear();
    });

    try {
      await authService.cadastrarUsuario(
        nome: nome,
        email: email,
        senha: senha,
      );
      if (mounted) {
        Navigator.pop(context);
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        if (e.code == 'email-already-in-use') {
          mensagensErro = ['Este e-mail já está cadastrado.'];
        } else if (e.code == 'invalid-email') {
          mensagensErro = ['E-mail com formato inválido.'];
        } else {
          mensagensErro = ['Erro ao cadastrar: ${e.message}'];
        }
        carregando = false;
      });
    } catch (e) {
      setState(() {
        mensagensErro = ['Erro inesperado: $e'];
        carregando = false;
      });
    }
  }

  @override
  void dispose() {
    nomeController.dispose();
    emailController.dispose();
    senhaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tecladoAberto = MediaQuery.of(context).viewInsets.bottom > 0;

    return Scaffold(
      extendBodyBehindAppBar: true, // Garante ganho de espaço vertical sob a AppBar transparente
      backgroundColor: const Color(0xFF031A12),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
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
            final double spaceTitleToSubtitle = isCompact ? 2.0 : 6.0;
            final double spaceSubtitleToFields = isCompact ? 14.0 : 32.0;
            final double spaceBetweenFields = isCompact ? 8.0 : 14.0;
            final double spaceFieldsToButton = isCompact ? 16.0 : 32.0;
            final double spaceButtonToErrors = isCompact ? 8.0 : 12.0;
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
                          crossAxisAlignment: CrossAxisAlignment.center,
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
                              'Criar Conta',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: isCompact ? 22 : 28,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'serif',
                              ),
                            ),
                            SizedBox(height: spaceTitleToSubtitle),
                            Text(
                              'Junte-se à arte da coquetelaria',
                              style: TextStyle(
                                color: Colors.white70, 
                                fontSize: isCompact ? 13.0 : 15.0,
                              ),
                            ),
                            SizedBox(height: spaceSubtitleToFields),
                            TextField(
                              controller: nomeController,
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                labelText: 'Nome',
                                labelStyle: const TextStyle(color: Colors.white70),
                                prefixIcon: const Icon(
                                  Icons.person_outline,
                                  color: Colors.white70,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white.withValues(alpha: 0.3),
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                            SizedBox(height: spaceBetweenFields),
                            TextField(
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                labelText: 'E-mail',
                                labelStyle: const TextStyle(color: Colors.white70),
                                prefixIcon: const Icon(
                                  Icons.email_outlined,
                                  color: Colors.white70,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white.withValues(alpha: 0.3),
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                            SizedBox(height: spaceBetweenFields),
                            TextField(
                              controller: senhaController,
                              obscureText: ocultarSenha,
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                labelText: 'Senha',
                                labelStyle: const TextStyle(color: Colors.white70),
                                prefixIcon: const Icon(
                                  Icons.lock_outline,
                                  color: Colors.white70,
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    ocultarSenha ? Icons.visibility_off : Icons.visibility,
                                    color: Colors.white70,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      ocultarSenha = !ocultarSenha;
                                    });
                                  },
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white.withValues(alpha: 0.3),
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                            SizedBox(height: spaceFieldsToButton),
                            SizedBox(
                              width: double.infinity,
                              height: buttonHeight,
                              child: ElevatedButton(
                                onPressed: carregando ? null : cadastrar,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: const Color(0xFF031A12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: carregando
                                    ? const SizedBox(
                                        height: 22,
                                        width: 22,
                                        child: CircularProgressIndicator(
                                          color: Color(0xFF031A12),
                                          strokeWidth: 2.5,
                                        ),
                                      )
                                    : const Text(
                                        'Cadastrar',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                              ),
                            ),
                            if (mensagensErro.isNotEmpty) ...[
                              SizedBox(height: spaceButtonToErrors),
                              ...mensagensErro.map(
                                (erro) => Padding(
                                  padding: const EdgeInsets.only(bottom: 2.0),
                                  child: Text(
                                    erro,
                                    style: const TextStyle(
                                      color: Colors.redAccent,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
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