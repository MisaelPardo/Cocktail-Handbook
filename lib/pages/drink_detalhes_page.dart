import 'package:flutter/material.dart';
import 'nova_avaliacao_page.dart';

class DrinkDetalhesPage extends StatelessWidget {
  final Map<String, String> drink;

  const DrinkDetalhesPage({super.key, required this.drink});

  IconData _obterIconeCategoria(String categoria) {
    switch (categoria) {
      case 'Clássico':
        return Icons.stars;
      case 'Moderno':
        return Icons.bolt;
      case 'Tropical':
        return Icons.wb_sunny;
      case 'Cremoso':
        return Icons.icecream;
      case 'Aperitivo':
        return Icons.wine_bar;
      case 'Sem Álcool':
        return Icons.no_drinks;
      default:
        return Icons.local_bar;
    }
  }

  @override
  Widget build(BuildContext context) {
    final categoria = drink['categoria'] ?? '';
    final iconData = _obterIconeCategoria(categoria);

    return Scaffold(
      backgroundColor: const Color(0xFF031A12),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 500.0,
                pinned: true,
                backgroundColor: const Color(0xFF031A12),
                iconTheme: const IconThemeData(color: Colors.white),
                flexibleSpace: FlexibleSpaceBar(
                  titlePadding: const EdgeInsets.only(left: 56, bottom: 16, right: 16),
                  title: Text(
                    drink['nome'] ?? 'Desconhecido',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'serif',
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        drink['imagem'] ?? '',
                        fit: BoxFit.cover,
                        alignment: Alignment.center,
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: Colors.black45,
                          child: const Center(
                            child: Icon(Icons.broken_image, color: Colors.white38, size: 50),
                          ),
                        ),
                      ),
                      const DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.black54,
                              Colors.transparent,
                              Colors.transparent,
                              Color(0xFF031A12),
                            ],
                            stops: [0.0, 0.2, 0.6, 1.0],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            iconData,
                            color: const Color(0xFFDCAE53),
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            categoria,
                            style: const TextStyle(
                              color: Color(0xFFDCAE53),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                      const Text(
                        'História',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'serif',
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        drink['historia'] ?? 'História não disponível.',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 15,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 32),
                      const Text(
                        'Preparo',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'serif',
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        drink['preparo'] ?? 'Método de preparo não disponível.',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 15,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 32),
                      
                      // Redirecionamento configurado para página de formulário
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFDCAE53),
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          icon: const Icon(Icons.edit_note),
                          label: const Text(
                            'Registrar Prática',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NovaAvaliacaoPage(drinkName: drink['nome'] ?? ''),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}