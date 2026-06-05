// ignore_for_file: subtype_of_sealed_class

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:cocktail_handbook/services/auth_service.dart';

// Definição dos Dublês de Teste (Mocks) para simular o comportamento do Firebase
class MockFirebaseAuth extends Mock implements FirebaseAuth {}
class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}
class MockUserCredential extends Mock implements UserCredential {}
class MockUser extends Mock implements User {}
class MockCollectionReference extends Mock implements CollectionReference<Map<String, dynamic>> {}
class MockDocumentReference extends Mock implements DocumentReference<Map<String, dynamic>> {}

void main() {
  group('Testes de Caixa-Branca - AuthService', () {
    late MockFirebaseAuth mockAuth;
    late MockFirebaseFirestore mockFirestore;
    late AuthService authService;

    late MockUserCredential mockUserCredential;
    late MockUser mockUser;
    late MockCollectionReference mockCollectionReference;
    late MockDocumentReference mockDocumentReference;

    setUp(() {
      mockAuth = MockFirebaseAuth();
      mockFirestore = MockFirebaseFirestore();
      
      // Injeta os simuladores dentro do serviço que queremos testar (Caixa-Branca)
      authService = AuthService(auth: mockAuth, firestore: mockFirestore);

      mockUserCredential = MockUserCredential();
      mockUser = MockUser();
      mockCollectionReference = MockCollectionReference();
      mockDocumentReference = MockDocumentReference();

      // Registro de fallbacks para aceitar qualquer valor de mapa no mocktail
      registerFallbackValue(<String, dynamic>{});
    });

    test('Fluxo 1 (Sucesso): Cadastro de usuário deve salvar informações no Firestore', () async {
      // Configura os comportamentos lógicos esperados das dependências internas
      when(() => mockAuth.createUserWithEmailAndPassword(
            email: 'misael@teste.com',
            password: 'senhaSegura123',
          )).thenAnswer((_) async => mockUserCredential);

      when(() => mockUserCredential.user).thenReturn(mockUser);
      when(() => mockUser.uid).thenReturn('uid-misael-123');

      when(() => mockFirestore.collection('usuarios')).thenReturn(mockCollectionReference);
      when(() => mockCollectionReference.doc('uid-misael-123')).thenReturn(mockDocumentReference);
      when(() => mockDocumentReference.set(any())).thenAnswer((_) async => {});

      // Executa a função do serviço
      final resultado = await authService.cadastrarUsuario(
        nome: 'Misael',
        email: 'misael@teste.com',
        senha: 'senhaSegura123',
      );

      // Asserções estruturais: Verifica se o fluxo lógico chegou até o final com sucesso
      expect(resultado, isNotNull);
      verify(() => mockFirestore.collection('usuarios').doc('uid-misael-123').set(any())).called(1);
    });

    test('Fluxo 2 (Erro / Desvio): Deve lançar FirebaseAuthException quando o usuário retornado for nulo', () async {
      // Caixa-Branca: Força o fluxo interno a passar pelo bloco 'if (usuario == null)' do cadastro
      when(() => mockAuth.createUserWithEmailAndPassword(
            email: 'erro@teste.com',
            password: 'senhaSegura123',
          )).thenAnswer((_) async => mockUserCredential);

      when(() => mockUserCredential.user).thenReturn(null); // Força a ramificação de erro

      // Executa e verifica se a exceção correta é disparada pelo algoritmo
      expect(
        () async => await authService.cadastrarUsuario(
          nome: 'Erro User',
          email: 'erro@teste.com',
          senha: 'senhaSegura123',
        ),
        throwsA(isA<FirebaseAuthException>().having((e) => e.code, 'code', 'user-not-created')),
      );
    });

    test('Fluxo 3 (Sucesso): Login de usuário deve atualizar o timestamp no Firestore', () async {
      // Caixa-Branca: Força o fluxo lógico pelo caminho 'if (usuario != null)' no login
      when(() => mockAuth.signInWithEmailAndPassword(
            email: 'misael@teste.com',
            password: 'senhaSegura123',
          )).thenAnswer((_) async => mockUserCredential);

      when(() => mockUserCredential.user).thenReturn(mockUser);
      when(() => mockUser.uid).thenReturn('uid-misael-123');

      when(() => mockFirestore.collection('usuarios')).thenReturn(mockCollectionReference);
      when(() => mockCollectionReference.doc('uid-misael-123')).thenReturn(mockDocumentReference);
      when(() => mockDocumentReference.update(any())).thenAnswer((_) async => {});

      final resultado = await authService.entrarUsuario(
        email: 'misael@teste.com',
        senha: 'senhaSegura123',
      );

      expect(resultado, isNotNull);
      verify(() => mockFirestore.collection('usuarios').doc('uid-misael-123').update(any())).called(1);
    });
  });
}