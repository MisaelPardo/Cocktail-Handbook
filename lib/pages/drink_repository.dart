class DrinkRepository {
  // DADOS - CLÁSSICOS
  static const List<Map<String, String>> drinksClassicos = [
    {
      'nome': 'Mojito',
      'categoria': 'Clássico',
      'imagem': 'assets/images/mojito.png',
      'historia': 'O Mojito é um coquetel associado a Cuba e à tradição caribenha, preparado com rum branco, limão, hortelã, açúcar e água com gás. Sua origem exata não é totalmente documentada, mas há versões que relacionam sua história a bebidas antigas usadas de forma medicinal. Com o tempo, tornou-se um dos drinks cubanos mais conhecidos internacionalmente.',
      'preparo': '1. Macere levemente folhas de hortelã com suco de meio limão e 1 colher de açúcar.\n2. Adicione gelo picado até o topo do copo highball.\n3. Despeje 50ml de Rum Branco.\n4. Complete com água com gás e misture suavemente.',
    },
    {
      'nome': 'Caipirinha',
      'categoria': 'Clássico',
      'imagem': 'assets/images/caipirinha.png',
      'historia': 'A Caipirinha é um dos principais símbolos da coquetelaria brasileira, feita com cachaça, limão, açúcar e gelo. Uma das versões mais conhecidas sobre sua origem relaciona a bebida ao interior de São Paulo, no início do século XX, a partir de uma mistura popular com limão, mel e alho usada como remédio caseiro.',
      'preparo': '1. Corte 1 limão tahiti em fatias ou cubos (retire o miolo branco para não amargar).\n2. Macere o limão com 2 colheres de açúcar em um copo baixo.\n3. Adicione gelo.\n4. Complete com 60ml de cachaça de boa qualidade e mexa bem.',
    },
    {
      'nome': 'Margarita',
      'categoria': 'Clássico',
      'imagem': 'assets/images/margarita.png',
      'historia': 'A Margarita é um coquetel clássico associado ao México, feito com tequila, licor de laranja e suco de limão. Sua origem não é totalmente comprovada, pois existem várias versões sobre sua criação nas décadas de 1930 e 1940. Por isso, é mais seguro tratá-la como um drink de origem disputada, mas fortemente ligado à tradição mexicana.',
      'preparo': '1. Umedeça a borda da taça com limão e passe no sal.\n2. Em uma coqueteleira com gelo, bata 50ml de Tequila, 25ml de licor de laranja (Cointreau) e 25ml de suco de limão fresco.\n3. Coe duplamente para a taça crustada.',
    },
    {
      'nome': 'Negroni',
      'categoria': 'Clássico',
      'imagem': 'assets/images/negroni.png',
      'historia': 'O Negroni é tradicionalmente associado a Florença, na Itália, por volta de 1919. Segundo a versão mais difundida, o Conde Camillo Negroni pediu ao bartender Fosco Scarselli uma versão mais forte do Americano, substituindo a água com gás por gin. A combinação de gin, Campari e vermute doce tornou-se um clássico da coquetelaria.',
      'preparo': '1. Em um copo baixo (Old Fashioned) com gelo, adicione 30ml de Gin, 30ml de Campari e 30ml de Vermute Doce.\n2. Mexa suavemente com uma colher bailarina.\n3. Finalize decorando com uma casca de laranja.',
    },
    {
      'nome': 'Old Fashioned',
      'categoria': 'Clássico',
      'imagem': 'assets/images/old_fashioned.png',
      'historia': 'O Old Fashioned é considerado um dos coquetéis mais antigos ainda consumidos. Seu nome se consolidou no final do século XIX, quando clientes passaram a pedir bebidas preparadas no estilo antigo, com destilado, açúcar, bitters e água. A receita representa uma forma clássica e simples de preparo com whiskey.',
      'preparo': '1. Em um copo baixo, coloque um cubo de açúcar e adicione 2 a 3 lances de Angostura Bitters e um lance de água.\n2. Macere até dissolver o açúcar.\n3. Adicione gelo e 60ml de Bourbon ou Rye Whiskey.\n4. Mexa bem e decore com casca de laranja.',
    },
  ];

  // DADOS - MODERNOS
  static const List<Map<String, String>> drinksModernos = [
    {
      'nome': 'Cosmopolitan',
      'categoria': 'Moderno',
      'imagem': 'assets/images/cosmopolitan.png',
      'historia': 'O Cosmopolitan é um coquetel moderno feito com vodka citron, licor de laranja, suco de limão e cranberry. Ficou muito conhecido nos anos 1990 por sua presença na cultura pop, especialmente na série Sex and the City. Uma versão bastante citada atribui sua padronização moderna ao bartender Toby Cecchini, em Nova York, no fim dos anos 1980.',
      'preparo': '1. Em uma coqueteleira com gelo, misture 40ml de Vodka Citron, 15ml de Cointreau, 15ml de suco de limão e 30ml de suco de cranberry.\n2. Bata vigorosamente.\n3. Coe para uma taça Martini resfriada.',
    },
    {
      'nome': 'Moscow Mule',
      'categoria': 'Moderno',
      'imagem': 'assets/images/moscow_mule.png',
      'historia': 'O Moscow Mule surgiu nos Estados Unidos no início da década de 1940, apesar do nome fazer referência a Moscou. A bebida ficou associada à popularização da vodka e da ginger beer no mercado americano. A caneca de cobre tornou-se uma marca visual do drink, reforçando sua identidade e a ideia de uma bebida bem gelada.',
      'preparo': '1. Em uma caneca de cobre com gelo, adicione 50ml de Vodka e 15ml de suco de limão.\n2. Complete com Ginger Beer.\n3. Mexa levemente e decore com uma fatia de limão (No Brasil, popularizou-se com a espuma de gengibre no topo).',
    },
    {
      'nome': 'Espresso Martini',
      'categoria': 'Moderno',
      'imagem': 'assets/images/espresso_martini.png',
      'historia': 'O Espresso Martini é geralmente atribuído ao bartender Dick Bradsell, em Londres, nos anos 1980. A história mais conhecida diz que ele criou a bebida após receber o pedido de uma cliente que queria algo que a acordasse e, ao mesmo tempo, fosse alcoólico. O drink combina vodka, café espresso e licor de café.',
      'preparo': '1. Em uma coqueteleira com bastante gelo, coloque 50ml de Vodka, 20ml de licor de café (Kahlúa) e 30ml de café espresso quente recém extraído.\n2. Bata vigorosamente para criar a crema.\n3. Coe duplamente para uma taça Martini. Decore com 3 grãos de café.',
    },
    {
      'nome': 'Aperol Spritz',
      'categoria': 'Moderno',
      'imagem': 'assets/images/aperol_spritz.png',
      'historia': 'O Aperol Spritz tem relação com a tradição italiana do Spritz, associada ao costume de diluir vinho com água com gás no norte da Itália. O Aperol foi criado em 1919, em Pádua, e sua combinação com prosecco e água com gás ajudou a transformar o drink em um dos aperitivos italianos mais conhecidos internacionalmente.',
      'preparo': '1. Encha uma taça de vinho grande com gelo.\n2. Adicione 90ml de Prosecco.\n3. Adicione 60ml de Aperol.\n4. Adicione 30ml de água com gás.\n5. Mexa levemente para não perder o gás e decore com uma fatia de laranja.',
    },
    {
      'nome': 'Gin Basil Smash',
      'categoria': 'Moderno',
      'imagem': 'assets/images/gin_basil_smash.png',
      'historia': 'O Gin Basil Smash foi criado em 2008 por Jörg Meyer no bar Le Lion, em Hamburgo, Alemanha. É um exemplo da coquetelaria moderna europeia, destacando o uso intenso de ervas frescas para dar cor, aroma e sabor ao drink, principalmente por meio do manjericão.',
      'preparo': '1. Em uma coqueteleira, macere vigorosamente um bom punhado de folhas de manjericão fresco com 20ml de suco de limão siciliano.\n2. Adicione 60ml de Gin e 20ml de xarope de açúcar, mais gelo.\n3. Bata vigorosamente.\n4. Coe duplamente para um copo baixo com gelo novo.',
    },
  ];

  // DADOS - TROPICAIS
  static const List<Map<String, String>> drinksTropicais = [
    {
      'nome': 'Piña Colada',
      'categoria': 'Tropical',
      'imagem': 'assets/images/pina_colada.png',
      'historia': 'A Piña Colada é um coquetel tropical associado a Porto Rico, preparado com rum, abacaxi e creme de coco. Tornou-se conhecida pelo sabor doce, cremoso e refrescante, sendo muito ligada a ambientes de praia e à coquetelaria caribenha.',
      'preparo': '1. Em um liquidificador com gelo, adicione 50ml de rum branco, 30ml de creme de coco e 50ml de suco de abacaxi.\n2. Bata até obter uma consistência cremosa.\n3. Sirva em copo alto e decore com fatia ou espeto de abacaxi.',
    },
    {
      'nome': 'Daiquiri',
      'categoria': 'Tropical',
      'imagem': 'assets/images/daiquiri.png',
      'historia': 'O Daiquiri é um coquetel clássico de origem cubana, feito tradicionalmente com rum, suco de limão e açúcar. Embora tenha uma receita simples, tornou-se uma base importante para vários drinks tropicais e variações frutadas.',
      'preparo': '1. Em uma coqueteleira com gelo, adicione 60ml de rum branco, 20ml de suco de limão e 15ml de xarope de açúcar.\n2. Bata vigorosamente.\n3. Coe duplamente para uma taça resfriada.',
    },
    {
      'nome': 'Mai Tai',
      'categoria': 'Tropical',
      'imagem': 'assets/images/mai_tai.png',
      'historia': 'O Mai Tai é um coquetel tropical ligado à cultura tiki, preparado com rum, cítricos e ingredientes aromáticos. Sua origem é disputada entre diferentes bares e bartenders, por isso é mais correto apresentá-lo como um drink de origem controversa, mas fortemente associado à coquetelaria polinésia-americana.',
      'preparo': '1. Na coqueteleira com gelo, misture 30ml de rum claro, 30ml de rum escuro, 15ml de licor de laranja (Curaçao), 15ml de xarope de amêndoa (Orgeat) e 15ml de suco de limão.\n2. Bata bem.\n3. Coe para um copo baixo com gelo britado e decore com hortelã.',
    },
    {
      'nome': 'Tequila Sunrise',
      'categoria': 'Tropical',
      'imagem': 'assets/images/tequila_sunrise.png',
      'historia': 'O Tequila Sunrise é conhecido pelo efeito visual em degradê, que lembra o nascer do sol. Feito com tequila, suco de laranja e grenadine, tornou-se popular principalmente pela aparência colorida e pelo perfil tropical e refrescante.',
      'preparo': '1. Em um copo alto com gelo, adicione 45ml de tequila e 90ml de suco de laranja. Mexa.\n2. Despeje 15ml de grenadine (xarope de romã) lentamente pela borda para afundar.\n3. Não mexa para preservar o degradê.',
    },
    {
      'nome': 'Cuba Libre',
      'categoria': 'Tropical',
      'imagem': 'assets/images/cuba_libre.png',
      'historia': 'O Cuba Libre é um drink associado a Cuba, feito com rum, refrigerante de cola e limão. Sua história costuma ser relacionada ao início do século XX e ao contato entre a cultura cubana e produtos norte-americanos, embora os detalhes exatos da origem variem conforme a fonte.',
      'preparo': '1. Encha um copo alto com gelo.\n2. Esprema o suco de meio limão.\n3. Adicione 50ml de rum branco.\n4. Complete com refrigerante de cola e misture suavemente.',
    },
  ];

  // DADOS - CREMOSOS
  static const List<Map<String, String>> drinksCremosos = [
    {
      'nome': 'Alexander',
      'categoria': 'Cremoso',
      'imagem': 'assets/images/alexander.png',
      'historia': 'O Alexander é um coquetel clássico cremoso, tradicionalmente feito com gin, creme de cacau e creme de leite. Com o tempo, surgiram variações usando outros destilados, especialmente o brandy, que deu origem ao Brandy Alexander.',
      'preparo': '1. Em uma coqueteleira com gelo, adicione 30ml de gin, 30ml de licor de cacau branco e 30ml de creme de leite fresco.\n2. Bata vigorosamente.\n3. Coe para uma taça resfriada e polvilhe noz-moscada.',
    },
    {
      'nome': 'Grasshopper',
      'categoria': 'Cremoso',
      'imagem': 'assets/images/grasshopper.png',
      'historia': 'O Grasshopper é um coquetel cremoso conhecido pela cor verde vibrante, geralmente associada ao uso de licor de menta. É tradicionalmente servido como drink doce e de sobremesa, com textura suave e aparência marcante.',
      'preparo': '1. Na coqueteleira com gelo, misture 30ml de licor de menta verde, 30ml de licor de cacau branco e 30ml de creme de leite fresco.\n2. Bata intensamente.\n3. Coe para uma taça Martini resfriada.',
    },
    {
      'nome': 'Irish Coffee',
      'categoria': 'Cremoso',
      'imagem': 'assets/images/irish_coffee.png',
      'historia': 'O Irish Coffee combina café quente, whiskey irlandês, açúcar e creme. É tradicionalmente associado à Irlanda e tornou-se conhecido como uma bebida quente, alcoólica e reconfortante, servida principalmente após refeições ou em dias frios.',
      'preparo': '1. Em uma taça de vidro pré-aquecida, adicione 40ml de whiskey irlandês e 1 colher de açúcar mascavo.\n2. Despeje 90ml de café quente e mexa até dissolver.\n3. Faça uma camada suave de creme de leite batido no topo.',
    },
    {
      'nome': 'White Russian',
      'categoria': 'Cremoso',
      'imagem': 'assets/images/white_russian.png',
      'historia': 'O White Russian é uma variação do Black Russian, adicionando creme ou leite à combinação de vodka e licor de café. Ficou conhecido pelo perfil doce, cremoso e suave, sendo frequentemente associado a drinks de sobremesa.',
      'preparo': '1. Em um copo baixo com gelo, despeje 50ml de vodka e 20ml de licor de café.\n2. Despeje 30ml de creme de leite fresco suavemente por cima para criar uma camada, ou mexa para uniformizar.',
    },
  ];

  // DADOS - APERITIVOS / AMARGOS
  static const List<Map<String, String>> drinksAperitivos = [
    {
      'nome': 'Boulevardier',
      'categoria': 'Aperitivo',
      'imagem': 'assets/images/boulevardier.png',
      'historia': 'O Boulevardier é um coquetel de perfil amargo e encorpado, feito com whiskey, Campari e vermute doce. É frequentemente comparado ao Negroni, mas substitui o gin por whiskey, criando uma bebida mais intensa e robusta.',
      'preparo': '1. Em um mixing glass com gelo, adicione 45ml de Bourbon ou Rye whiskey, 30ml de Campari e 30ml de Vermute Doce.\n2. Mexa bem para gelar e diluir levemente.\n3. Coe para um copo baixo com gelo novo e decore com casca de laranja.',
    },
    {
      'nome': 'Garibaldi',
      'categoria': 'Aperitivo',
      'imagem': 'assets/images/garibaldi.png',
      'historia': 'O Garibaldi é um aperitivo italiano feito geralmente com Campari e suco de laranja. O nome faz referência a Giuseppe Garibaldi, figura histórica ligada à unificação italiana, e o drink se destaca pelo contraste entre o amargor do Campari e a doçura cítrica da laranja.',
      'preparo': '1. Em um copo alto com gelo, despeje 40ml de Campari.\n2. Adicione 120ml de suco de laranja (de preferência aerado ou batido previamente no liquidificador para criar espuma).\n3. Decore com uma fatia de laranja.',
    },
    {
      'nome': 'Kir',
      'categoria': 'Aperitivo',
      'imagem': 'assets/images/kir.png',
      'historia': 'O Kir é um aperitivo francês preparado com vinho branco e crème de cassis. É associado à tradição francesa de aperitivos leves e elegantes, sendo conhecido por sua coloração delicada e sabor frutado.',
      'preparo': '1. Em uma taça de vinho branco pré-resfriada, adicione 10ml de Crème de Cassis.\n2. Complete delicadamente com 90ml de vinho branco seco e bem gelado.',
    },
  ];

  // DADOS - SEM ÁLCOOL
  static const List<Map<String, String>> drinksSemAlcool = [
    {
      'nome': 'Pink Lemonade',
      'categoria': 'Sem Álcool',
      'imagem': 'assets/images/pink_lemonade.png',
      'historia': 'A Pink Lemonade é uma bebida não alcoólica de perfil refrescante, feita com base cítrica e coloração rosada ou avermelhada. Não possui uma origem única documentada como os coquetéis clássicos, mas é bastante usada como bebida artesanal, mocktail ou opção visualmente atrativa em cardápios.',
      'preparo': '1. Em uma jarra, misture 100ml de suco de limão tahiti ou siciliano com 50ml de xarope de cranberry ou framboesa.\n2. Adicione água gelada (ou água com gás) a gosto e adoce se necessário.\n3. Sirva em copos altos com bastante gelo e fatias de limão.',
    },
  ];

  // LISTA GLOBAL CONSOLIDADA
  static List<Map<String, String>> get drinksTodos => [
        ...drinksClassicos,
        ...drinksModernos,
        ...drinksTropicais,
        ...drinksCremosos,
        ...drinksAperitivos,
        ...drinksSemAlcool,
      ];

  // REFERÊNCIA DE IMAGENS PARA A PLAYLIST
  static const Map<String, String> catalogoReferencia = {
    'Mojito': 'assets/images/mojito.png',
    'Caipirinha': 'assets/images/caipirinha.png',
    'Margarita': 'assets/images/margarita.png',
    'Negroni': 'assets/images/negroni.png',
    'Old Fashioned': 'assets/images/old_fashioned.png',
    'Cosmopolitan': 'assets/images/cosmopolitan.png',
    'Moscow Mule': 'assets/images/moscow_mule.png',
    'Espresso Martini': 'assets/images/espresso_martini.png',
    'Aperol Spritz': 'assets/images/aperol_spritz.png',
    'Gin Basil Smash': 'assets/images/gin_basil_smash.png',
    'Piña Colada': 'assets/images/pina_colada.png',
    'Daiquiri': 'assets/images/daiquiri.png',
    'Mai Tai': 'assets/images/mai_tai.png',
    'Tequila Sunrise': 'assets/images/tequila_sunrise.png',
    'Cuba Libre': 'assets/images/cuba_libre.png',
    'Alexander': 'assets/images/alexander.png',
    'Grasshopper': 'assets/images/grasshopper.png',
    'Irish Coffee': 'assets/images/irish_coffee.png',
    'White Russian': 'assets/images/white_russian.png',
    'Boulevardier': 'assets/images/boulevardier.png',
    'Garibaldi': 'assets/images/garibaldi.png',
    'Kir': 'assets/images/kir.png',
    'Pink Lemonade': 'assets/images/pink_lemonade.png',
  };
}