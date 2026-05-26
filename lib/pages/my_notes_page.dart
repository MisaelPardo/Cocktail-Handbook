import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'drink_detalhes_page.dart';
import 'drink_repository.dart';
import 'nova_avaliacao_page.dart';

class MyNotesPage extends StatefulWidget {
  const MyNotesPage({super.key});

  @override
  State<MyNotesPage> createState() => _MyNotesPageState();
}

class _MyNotesPageState extends State<MyNotesPage> {
  final User? usuario = FirebaseAuth.instance.currentUser;

  // Retorna uma descrição amigável de acordo com a nota em estrelas
  String _obterSignificadoNota(int nota) {
    switch (nota) {
      case 1:
        return 'Muito Ruim';
      case 2:
        return 'Ruim';
      case 3:
        return 'Regular';
      case 4:
        return 'Bom';
      case 5:
        return 'Excelente';
      default:
        return '';
    }
  }

  // Navega para a tela de edição injetando os valores iniciais da avaliação selecionada.
  // Ao passar o parametro "drinkName", o formulário (NovaAvaliacaoPage) bloqueia a alteração
  // do campo visualmente, e a presença de "idDocumentoEdicao" blinda o update no Firestore.
  void _navegarParaEdicao(DocumentSnapshot doc) {
    final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NovaAvaliacaoPage(
          drinkName: data['drinkName'],
          idDocumentoEdicao: doc.id,
          textoAnotacaoInicial: data['textoAnotacao'],
          notaInicial: data['nota'],
        ),
      ),
    );
  }

  // Apresenta uma caixa de diálogo para confirmação segura antes de excluir o registro
  void _mostrarConfirmacaoExclusao(String docId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF151515),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text(
            'Confirmar Exclusão',
            style: TextStyle(
              color: Color(0xFFDCAE53),
              fontFamily: 'serif',
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Text(
            'Tem certeza que deseja excluir esta avaliação?',
            style: TextStyle(color: Colors.white70),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar', style: TextStyle(color: Colors.white54)),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Fecha o modal de confirmação
                _excluirAvaliacao(docId); // Executa a deleção no Firestore
              },
              child: const Text(
                'Excluir',
                style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
  }

  // Deleta o documento correspondente da coleção "avaliacoes" do Cloud Firestore
  Future<void> _excluirAvaliacao(String docId) async {
    try {
      await FirebaseFirestore.instance.collection('avaliacoes').doc(docId).delete();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Avaliação excluída com sucesso.'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao excluir: $e'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF031A12),
      appBar: AppBar(
        title: const Text(
          'Minhas Avaliações',
          style: TextStyle(color: Colors.white, fontFamily: 'serif'),
        ),
        backgroundColor: const Color(0xFF031A12),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Histórico de Avaliações',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'serif',
                ),
              ),
            ),
          ),

          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('avaliacoes')
                  .where('userId', isEqualTo: usuario?.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Erro interno. Verifique as regras e conexões: ${snapshot.error}', 
                        style: const TextStyle(color: Colors.redAccent),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(color: Color(0xFFDCAE53)),
                  );
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Text(
                      'Nenhuma avaliação encontrada.',
                      style: TextStyle(color: Colors.white54),
                    ),
                  );
                }

                // Cria uma cópia da lista de documentos e ordena com segurança
                final listaOrdenada = snapshot.data!.docs.toList();
                listaOrdenada.sort((a, b) {
                  try {
                    final dataA = a.data() as Map<String, dynamic>;
                    final dataB = b.data() as Map<String, dynamic>;
                    
                    final timeA = dataA.containsKey('criadoEm') ? dataA['criadoEm'] as Timestamp? : null;
                    final timeB = dataB.containsKey('criadoEm') ? dataB['criadoEm'] as Timestamp? : null;
                    
                    if (timeA == null && timeB == null) return 0;
                    if (timeA == null) return -1;
                    if (timeB == null) return 1;
                    
                    return timeB.compareTo(timeA); // Ordena de forma decrescente (mais recente primeiro)
                  } catch (_) {
                    return 0;
                  }
                });

                return ListView.builder(
                  itemCount: listaOrdenada.length,
                  itemBuilder: (context, index) {
                    final DocumentSnapshot doc = listaOrdenada[index];
                    final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
                    final int nota = data['nota'] ?? 0;
                    final String drinkName = data['drinkName'] ?? 'Desconhecido';

                    return Card(
                      color: const Color(0xFF151515),
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: ListTile(
                        title: GestureDetector(
                          onTap: () {
                            // Busca a receita localmente para abrir a página de detalhes
                            final drink = DrinkRepository.drinksTodos.firstWhere(
                              (d) => d['nome'] == drinkName,
                              orElse: () => <String, String>{},
                            );

                            if (drink.isNotEmpty) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => DrinkDetalhesPage(drink: drink),
                                ),
                              );
                            }
                          },
                          child: Text(
                            drinkName,
                            style: const TextStyle(
                              color: Color(0xFFDCAE53),
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                              decorationColor: Color(0xFFDCAE53),
                            ),
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 4),
                            Text(
                              data['textoAnotacao'] ?? '',
                              style: const TextStyle(color: Colors.white70),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Row(
                                  children: List.generate(
                                    5,
                                    (i) => Icon(
                                      i < nota ? Icons.star : Icons.star_border,
                                      color: const Color(0xFFDCAE53),
                                      size: 16,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  _obterSignificadoNota(nota),
                                  style: const TextStyle(color: Colors.white54, fontSize: 12),
                                ),
                              ],
                            ),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.white54, size: 20),
                              onPressed: () => _navegarParaEdicao(doc),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete_outline, color: Colors.redAccent, size: 20),
                              onPressed: () => _mostrarConfirmacaoExclusao(doc.id),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}