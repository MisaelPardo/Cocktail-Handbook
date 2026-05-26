import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'drink_detalhes_page.dart';
import 'my_notes_page.dart';
import 'drink_repository.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<DocumentSnapshot<Map<String, dynamic>>> _futureUsuario;
  bool _isSearching = false;
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final usuario = FirebaseAuth.instance.currentUser;
    if (usuario != null) {
      _futureUsuario = FirebaseFirestore.instance.collection('usuarios').doc(usuario.uid).get();
    } else {
      _futureUsuario = Future.error('Utilizador não autenticado');
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Map<String, String>> _filtrarDrinks(List<Map<String, String>> lista) {
    if (_searchQuery.isEmpty) return lista;
    return lista.where((drink) {
      return drink['nome']!.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF031A12),
      body: SafeArea(
        child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          future: _futureUsuario,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator(color: Color(0xFFDCAE53)));
            }

            final dadosUsuario = snapshot.data?.data();
            final nome = dadosUsuario?['nome'] ?? 'Convidado';

            return DefaultTabController(
              length: 7,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 24, 16, 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Olá, $nome.',
                                style: const TextStyle(color: Colors.white70, fontSize: 16),
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                'O que vamos preparar\nhoje?',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'serif',
                                  height: 1.2,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(_isSearching ? Icons.close : Icons.search, color: Colors.white),
                              onPressed: () {
                                setState(() {
                                  _isSearching = !_isSearching;
                                  if (!_isSearching) {
                                    _searchQuery = '';
                                    _searchController.clear();
                                  }
                                });
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.rate_review, color: Colors.white),
                              tooltip: 'Minhas Avaliações',
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const MyNotesPage()),
                                );
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.logout, color: Colors.white),
                              onPressed: () => FirebaseAuth.instance.signOut(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  if (_isSearching)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
                      child: TextField(
                        controller: _searchController,
                        autofocus: true,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Pesquisar drink...',
                          hintStyle: const TextStyle(color: Colors.white54),
                          filled: true,
                          fillColor: const Color(0xFF151515),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _searchQuery = value;
                          });
                        },
                      ),
                    ),

                  TabBar(
                    isScrollable: true,
                    tabAlignment: TabAlignment.center,
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: const Color(0xFFDCAE53), width: 1.5),
                    ),
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelColor: const Color(0xFFDCAE53),
                    unselectedLabelColor: Colors.white54,
                    dividerColor: Colors.transparent,
                    labelPadding: const EdgeInsets.symmetric(horizontal: 24),
                    tabs: const [
                      Tab(text: 'Todos'),
                      Tab(text: 'Clássicos'),
                      Tab(text: 'Modernos'),
                      Tab(text: 'Tropicais'),
                      Tab(text: 'Cremosos'),
                      Tab(text: 'Aperitivos'),
                      Tab(text: 'Sem Álcool'),
                    ],
                  ),

                  Expanded(
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 1200),
                        child: TabBarView(
                          children: [
                            _buildGrid(_filtrarDrinks(DrinkRepository.drinksTodos)),
                            _buildGrid(_filtrarDrinks(DrinkRepository.drinksClassicos)),
                            _buildGrid(_filtrarDrinks(DrinkRepository.drinksModernos)),
                            _buildGrid(_filtrarDrinks(DrinkRepository.drinksTropicais)),
                            _buildGrid(_filtrarDrinks(DrinkRepository.drinksCremosos)),
                            _buildGrid(_filtrarDrinks(DrinkRepository.drinksAperitivos)),
                            _buildGrid(_filtrarDrinks(DrinkRepository.drinksSemAlcool)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildGrid(List<Map<String, String>> drinks) {
    if (drinks.isEmpty) {
      return const Center(
        child: Text(
          'Nenhum drink encontrado.',
          style: TextStyle(color: Colors.white54, fontSize: 16),
        ),
      );
    }

    final usuario = FirebaseAuth.instance.currentUser;

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 250,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.75,
      ),
      itemCount: drinks.length,
      itemBuilder: (context, index) {
        final drink = drinks[index];
        final categoria = drink['categoria'] ?? '';
        
        IconData iconData = Icons.local_bar;
        if (categoria == 'Clássico') iconData = Icons.stars;
        if (categoria == 'Moderno') iconData = Icons.bolt;
        if (categoria == 'Tropical') iconData = Icons.wb_sunny;
        if (categoria == 'Cremoso') iconData = Icons.icecream;
        if (categoria == 'Aperitivo') iconData = Icons.wine_bar;
        if (categoria == 'Sem Álcool') iconData = Icons.no_drinks;

        return InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DrinkDetalhesPage(drink: drink),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFF151515),
              borderRadius: BorderRadius.circular(16),
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        drink['imagem']!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.black45,
                            child: const Center(
                              child: Icon(Icons.broken_image, color: Colors.white38),
                            ),
                          );
                        },
                      ),
                      if (usuario != null)
                        Positioned.fill(
                          child: StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('avaliacoes')
                                .where('userId', isEqualTo: usuario.uid)
                                .where('drinkName', isEqualTo: drink['nome'])
                                .snapshots(),
                            builder: (context, snapshot) {
                              final isSaved = snapshot.hasData && snapshot.data!.docs.isNotEmpty;
                              
                              if (!isSaved) return const SizedBox.shrink();

                              final nota = snapshot.data!.docs.first['nota'];
                              final int notaValue = (nota is num) ? nota.toInt() : 5;

                              return Stack(
                                children: [
                                  // INDICADOR DE PRÁTICA (SELO DE ESTRELAS DINÂMICO)
                                  Positioned(
                                    top: 8,
                                    left: 8,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFDCAE53).withValues(alpha: 0.95),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: List.generate(
                                          notaValue,
                                          (i) => const Padding(
                                            padding: EdgeInsets.symmetric(horizontal: 0.5),
                                            child: Icon(
                                              Icons.star,
                                              color: Colors.black,
                                              size: 12,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        drink['nome']!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(iconData, color: const Color(0xFFDCAE53), size: 14),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              categoria,
                              style: const TextStyle(
                                color: Color(0xFFDCAE53),
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}