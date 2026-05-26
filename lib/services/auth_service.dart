import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserCredential> cadastrarUsuario({
    required String nome,
    required String email,
    required String senha,
  }) async {
    final credencial = await _auth.createUserWithEmailAndPassword(
      email: email.trim(),
      password: senha.trim(),
    );

    final usuario = credencial.user;

    if (usuario == null) {
      // Modificado para lançar um erro padrão do Firebase Auth
      throw FirebaseAuthException(
        code: 'user-not-created',
        message: 'A credencial foi gerada, mas o usuário retornou nulo.',
      );
    }

    await _firestore.collection('usuarios').doc(usuario.uid).set({
      'uid': usuario.uid,
      'nome': nome.trim(),
      'email': email.trim(),
      'criadoEm': FieldValue.serverTimestamp(),
      'ultimoLoginEm': FieldValue.serverTimestamp(),
    });

    return credencial;
  }

  Future<UserCredential> entrarUsuario({
    required String email,
    required String senha,
  }) async {
    final credencial = await _auth.signInWithEmailAndPassword(
      email: email.trim(),
      password: senha.trim(),
    );

    final usuario = credencial.user;

    if (usuario != null) {
      await _firestore.collection('usuarios').doc(usuario.uid).update({
        'ultimoLoginEm': FieldValue.serverTimestamp(),
      });
    }

    return credencial;
  }
}
