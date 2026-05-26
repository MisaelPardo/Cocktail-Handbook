import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'drink_repository.dart';

class NovaAvaliacaoPage extends StatefulWidget {
  final String? drinkName;
  final String? idDocumentoEdicao;
  final String? textoAnotacaoInicial;
  final int? notaInicial;

  const NovaAvaliacaoPage({
    super.key,
    this.drinkName,
    this.idDocumentoEdicao,
    this.textoAnotacaoInicial,
    this.notaInicial,
  });

  @override
  State<NovaAvaliacaoPage> createState() => _NovaAvaliacaoPageState();
}

class _NovaAvaliacaoPageState extends State<NovaAvaliacaoPage> {
  final User? usuario = FirebaseAuth.instance.currentUser;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _anotacaoController;

  String? _drinkSelecionado;
  int _notaSelecionada = 5;
  bool _salvando = false;

  @override
  void initState() {
    super.initState();
    _anotacaoController = TextEditingController(text: widget.textoAnotacaoInicial);
    
    // Define o drink inicial se for enviado por parâmetro
    if (widget.drinkName != null &&
        DrinkRepository.drinksTodos.any((d) => d['nome'] == widget.drinkName)) {
      _drinkSelecionado = widget.drinkName;
    }
    
    // Define a nota inicial se estiver em modo de edição
    if (widget.notaInicial != null) {
      _notaSelecionada = widget.notaInicial!;
    }
  }

  @override
  void dispose() {
    _anotacaoController.dispose();
    super.dispose();
  }

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

  Future<void> _salvarAvaliacao() async {
    if (usuario == null || !_formKey.currentState!.validate()) return;

    setState(() => _salvando = true);

    try {
      final CollectionReference collection = FirebaseFirestore.instance.collection('avaliacoes');
      final bool isEdicao = widget.idDocumentoEdicao != null;

      if (!isEdicao) {
        // FLUXO DE CRIAÇÃO: inclui todos os dados originais
        if (_drinkSelecionado == null) return;

        final Map<String, dynamic> dadosNovos = {
          'userId': usuario!.uid,
          'drinkName': _drinkSelecionado,
          'textoAnotacao': _anotacaoController.text.trim(),
          'nota': _notaSelecionada,
          'criadoEm': FieldValue.serverTimestamp(),
        };
        await collection.add(dadosNovos);
      } else {
        // FLUXO DE EDIÇÃO: atualiza estritamente apenas comentário, nota e timestamp de modificação
        final Map<String, dynamic> dadosEdicao = {
          'textoAnotacao': _anotacaoController.text.trim(),
          'nota': _notaSelecionada,
          'atualizadoEm': FieldValue.serverTimestamp(),
        };
        await collection.doc(widget.idDocumentoEdicao).update(dadosEdicao);
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Avaliação salva com sucesso!'),
            backgroundColor: Color(0xFFDCAE53),
          ),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao salvar: $e'), backgroundColor: Colors.redAccent),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _salvando = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isEdicao = widget.idDocumentoEdicao != null;
    
    // Regra de Negócio: Trava a seleção se for originado de um drink específico ou se for edição
    final bool deveTravarDrink = widget.drinkName != null || isEdicao;

    return Scaffold(
      backgroundColor: const Color(0xFF031A12),
      appBar: AppBar(
        title: Text(
          isEdicao ? 'Editar Avaliação' : 'Nova Avaliação',
          style: const TextStyle(color: Colors.white, fontFamily: 'serif'),
        ),
        backgroundColor: const Color(0xFF031A12),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF151515),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isEdicao ? 'Edite os dados abaixo' : 'Registe a sua prática',
                        style: const TextStyle(
                          color: Color(0xFFDCAE53),
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                      // Se o drink estiver travado, exibe um campo de texto legível e bloqueado.
                      if (deveTravarDrink)
                        TextFormField(
                          initialValue: _drinkSelecionado,
                          readOnly: true,
                          style: const TextStyle(
                            color: Color(0xFFDCAE53),
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          decoration: const InputDecoration(
                            labelText: 'Drink Selecionado (Fixo)',
                            labelStyle: TextStyle(color: Colors.white54),
                            filled: true,
                            fillColor: Color(0xFF151515),
                            prefixIcon: Icon(Icons.lock_outline, color: Color(0xFFDCAE53), size: 20),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white24),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFDCAE53)),
                            ),
                          ),
                        )
                      else
                        DropdownButtonFormField<String>(
                          initialValue: _drinkSelecionado,
                          decoration: const InputDecoration(
                            labelText: 'Selecione o Drink',
                            labelStyle: TextStyle(color: Colors.white54),
                            filled: true,
                            fillColor: Color(0xFF151515),
                            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white24)),
                            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFDCAE53))),
                            disabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white12)),
                          ),
                          dropdownColor: const Color(0xFF222222),
                          style: const TextStyle(color: Colors.white),
                          items: DrinkRepository.drinksTodos.map((drink) {
                            return DropdownMenuItem<String>(
                              value: drink['nome'],
                              child: Text(drink['nome']!),
                            );
                          }).toList(),
                          onChanged: (val) {
                            setState(() {
                              _drinkSelecionado = val;
                            });
                          },
                          validator: (value) => value == null ? 'Por favor, selecione um drink.' : null,
                        ),
                      const SizedBox(height: 16),

                      TextFormField(
                        controller: _anotacaoController,
                        decoration: const InputDecoration(
                          labelText: 'Comentário / Opinião',
                          labelStyle: TextStyle(color: Colors.white54),
                          filled: true,
                          fillColor: Color(0xFF151515),
                          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white24)),
                          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFDCAE53))),
                        ),
                        style: const TextStyle(color: Colors.white),
                        maxLines: 3,
                        validator: (value) => value == null || value.trim().isEmpty ? 'Insira o seu comentário.' : null,
                      ),
                      const SizedBox(height: 24),

                      DropdownButtonFormField<int>(
                        initialValue: _notaSelecionada,
                        decoration: const InputDecoration(
                          labelText: 'Avaliação (1 a 5 Estrelas)',
                          labelStyle: TextStyle(color: Colors.white54),
                          filled: true,
                          fillColor: Color(0xFF151515),
                          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white24)),
                          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFDCAE53))),
                        ),
                        dropdownColor: const Color(0xFF222222),
                        style: const TextStyle(color: Colors.white),
                        items: [1, 2, 3, 4, 5].map((n) {
                          return DropdownMenuItem<int>(
                            value: n,
                            child: Text('$n Estrelas - ${_obterSignificadoNota(n)}'),
                          );
                        }).toList(),
                        onChanged: (val) {
                          if (val != null) {
                            setState(() {
                              _notaSelecionada = val;
                            });
                          }
                        },
                      ),
                      const SizedBox(height: 32),

                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: Colors.white24),
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(vertical: 14),
                              ),
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Cancelar'),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFDCAE53),
                                foregroundColor: Colors.black,
                                padding: const EdgeInsets.symmetric(vertical: 14),
                              ),
                              onPressed: _salvando ? null : _salvarAvaliacao,
                              child: _salvando
                                  ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(color: Colors.black, strokeWidth: 2),
                                    )
                                  : Text(
                                      isEdicao ? 'Atualizar' : 'Salvar',
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}