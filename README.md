# 🍸 Cocktail Handbook

O **Cocktail Handbook** é um aplicativo móvel desenvolvido em Flutter que funciona como um catálogo digital e guia prático para preparo de coquetéis. O aplicativo permite explorar receitas por categoria, visualizar ingredientes e modo de preparo, registrar avaliações com estrelas e salvar anotações pessoais sobre cada drink — tudo com persistência em nuvem via Firebase.

---

## 👨‍💻 Desenvolvedores

- Misael Francisco Pardo
- Caio Samuel do Espírito Santo Montes
- Luís Eduardo Aguiar

---

## 🚀 Funcionalidades

- **Autenticação de Usuários** — Cadastro e login com e-mail e senha via Firebase Authentication. O perfil do usuário (nome, e-mail e timestamps) é armazenado no Firestore na coleção `usuarios`.
- **Catálogo de Drinks** — 23 coquetéis organizados em 6 categorias, cada um com imagem, história e modo de preparo.
- **Detalhes do Drink** — Tela dedicada exibindo ingredientes, história e passo a passo de preparo.
- **Avaliações com Estrelas** — Registro de nota (1–5 estrelas) e anotação pessoal por drink, persistidos no Firestore.
- **Minhas Notas** — Listagem de todas as avaliações do usuário logado, com opção de editar ou excluir cada entrada.
- **Roteamento por autenticação** — `AuthGate` redireciona automaticamente para Login ou Home conforme o estado de autenticação.

---

## 🍹 Catálogo de Drinks

| Categoria | Drinks |
|-----------|--------|
| **Clássicos** | Mojito, Caipirinha, Margarita, Negroni, Old Fashioned |
| **Modernos** | Cosmopolitan, Moscow Mule, Espresso Martini, Aperol Spritz, Gin Basil Smash |
| **Tropicais** | Piña Colada, Daiquiri, Mai Tai, Tequila Sunrise, Cuba Libre |
| **Cremosos** | Alexander, Grasshopper, Irish Coffee, White Russian |
| **Aperitivos** | Boulevardier, Garibaldi, Kir |
| **Sem Álcool** | Pink Lemonade |

---

## 🛠️ Tecnologias Utilizadas

| Tecnologia | Versão |
|-----------|--------|
| Flutter SDK | `^3.11.3` |
| Dart | — |
| firebase_core | `^4.7.0` |
| firebase_auth | `^6.4.0` |
| cloud_firestore | `^6.3.0` |
| cupertino_icons | `^1.0.8` |
| flutter_launcher_icons | `^0.13.1` |

---

## 🗂️ Estrutura do Projeto

```
lib/
├── main.dart                     # Ponto de entrada; inicializa o Firebase
├── app.dart                      # MaterialApp e configuração de rotas
├── auth_gate.dart                # Redireciona para Login ou Home via StreamBuilder
├── services/
│   └── auth_service.dart         # Cadastro e login via FirebaseAuth + Firestore
└── pages/
    ├── login_page.dart           # Tela de login
    ├── cadastro_page.dart        # Tela de cadastro de novo usuário
    ├── home_page.dart            # Catálogo de drinks com filtro por categoria
    ├── drink_repository.dart     # Fonte de dados local com os 23 drinks
    ├── drink_detalhes_page.dart  # Detalhes, história e preparo do drink
    ├── nova_avaliacao_page.dart  # Formulário de criação e edição de avaliação
    └── my_notes_page.dart        # Listagem das avaliações do usuário logado
```

---

## 🔥 Estrutura no Firestore

```
usuarios/
└── {uid}/
    ├── nome
    ├── email
    ├── criadoEm
    └── ultimoLoginEm

avaliacoes/
└── {docId}/
    ├── uid
    ├── drinkName
    ├── nota          (int 1–5)
    ├── anotacao      (String)
    └── criadoEm
```

---

## 📦 Pré-requisitos e Instalação

Antes de começar, você precisará ter o **Flutter SDK** (`^3.11.3`) instalado.

### 1. Clonar o repositório

```bash
git clone https://github.com/MisaelPardo/Cocktail-Handbook.git
```

### 2. Acessar a pasta do projeto

```bash
cd Cocktail-Handbook
```

### 3. Instalar as dependências

```bash
flutter pub get
```

### 4. Configurar o Firebase

O projeto utiliza Firebase Authentication e Cloud Firestore. Certifique-se de que o arquivo `google-services.json` (Android) ou `GoogleService-Info.plist` (iOS) esteja configurado corretamente no projeto antes de executar.

### 5. Executar o projeto

```bash
flutter run
```

---

## 📱 Plataformas Suportadas

O projeto foi gerado com suporte para Android, iOS, Web, Linux, macOS e Windows (pastas de configuração presentes no repositório).
