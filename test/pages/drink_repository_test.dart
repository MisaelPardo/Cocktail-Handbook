import 'package:flutter_test/flutter_test.dart';
import 'package:cocktail_handbook/pages/drink_repository.dart';

void main() {
group('Testes de Caixa-Branca - DrinkRepository', () {
test('Fluxo de Dados: Deve consolidar todos os caminhos de listas sem perda de itens', () {
// Caixa-branca: Valida o caminho lógico de concatenação do getter 'drinksTodos'
final totalEsperado = DrinkRepository.drinksClassicos.length +
DrinkRepository.drinksModernos.length +
DrinkRepository.drinksTropicais.length +
DrinkRepository.drinksCremosos.length +
DrinkRepository.drinksAperitivos.length +
DrinkRepository.drinksSemAlcool.length;

  expect(DrinkRepository.drinksTodos.length, totalEsperado);
});

test('Integridade de Fluxo: Cada drink clássico mapeado deve conter a categoria "Clássico"', () {
  // Caixa-branca: Verifica se o array estrutural interno não possui inconsistências lógicas de categoria
  for (var drink in DrinkRepository.drinksClassicos) {
    expect(drink['categoria'], 'Clássico');
  }
});

test('Mapeamento Estrutural: Toda chave do catálogo de referência deve coincidir com a imagem do drink', () {
  // Caixa-branca: Garante que as imagens declaradas no catálogo batem exatamente com as listas de dados
  for (var drink in DrinkRepository.drinksTodos) {
    final nome = drink['nome'];
    expect(DrinkRepository.catalogoReferencia.containsKey(nome), isTrue, 
        reason: 'O drink $nome não está presente no catálogo de referência.');
    expect(DrinkRepository.catalogoReferencia[nome], drink['imagem'],
        reason: 'O caminho da imagem do drink $nome está divergente no catálogo.');
  }
});


});

group('Estratégia de Regressão - DrinkRepository', () {
test('[REGRESSÃO] Evitar quebra de tela: Todos os atributos de todos os drinks cadastrados devem estar preenchidos', () {
// Caso de Regressão: Se no passado alguma tela de detalhe quebrou por falta de campo (Ex: 'historia' ou 'preparo' nulos),
// este teste serve como trava de segurança definitiva contra novas reincidências de falha.
for (var drink in DrinkRepository.drinksTodos) {
final nome = drink['nome'] ?? 'Sem Nome';

    expect(drink['nome'], isNotNull, reason: 'Erro no drink "$nome": O nome não pode ser nulo.');
    expect(drink['nome']!.isNotEmpty, isTrue, reason: 'Erro no drink "$nome": O nome não pode ser vazio.');

    expect(drink['categoria'], isNotNull, reason: 'Erro no drink "$nome": A categoria não pode ser nula.');
    expect(drink['categoria']!.isNotEmpty, isTrue, reason: 'Erro no drink "$nome": A categoria não pode ser vazia.');

    expect(drink['imagem'], isNotNull, reason: 'Erro no drink "$nome": O caminho da imagem não pode ser nulo.');
    expect(drink['imagem']!.isNotEmpty, isTrue, reason: 'Erro no drink "$nome": O caminho da imagem não pode ser vazio.');

    expect(drink['historia'], isNotNull, reason: 'Erro no drink "$nome": A história não pode ser nula.');
    expect(drink['historia']!.isNotEmpty, isTrue, reason: 'Erro no drink "$nome": A história não pode ser vazia.');

    expect(drink['preparo'], isNotNull, reason: 'Erro no drink "$nome": O modo de preparo não pode ser nulo.');
    expect(drink['preparo']!.isNotEmpty, isTrue, reason: 'Erro no drink "$nome": O modo de preparo não pode ser vazio.');
  }
});


});
}