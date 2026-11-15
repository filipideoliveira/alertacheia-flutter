import 'categoria.dart';

class Abrigo {
  const Abrigo({
    required this.nome,
    required this.bairro,
    required this.regiao,
    required this.capacidade,
    required this.ocupacao,
    required this.categorias,
    required this.imagemUrl,
    this.destaque = false,
  });

  final String nome;
  final String bairro;
  final String regiao;
  final int capacidade;
  final int ocupacao;
  final List<Categoria> categorias;
  final String imagemUrl;
  final bool destaque;

  int get vagasLivres => (capacidade - ocupacao).clamp(0, capacidade);

  bool get lotado => vagasLivres == 0;

  // Vermelho na tela quando falta vaga: lotado ou quase lotado.
  bool get vagaCritica => vagasLivres <= 10;

  Abrigo copyWith({bool? destaque}) {
    return Abrigo(
      nome: nome,
      bairro: bairro,
      regiao: regiao,
      capacidade: capacidade,
      ocupacao: ocupacao,
      categorias: categorias,
      imagemUrl: imagemUrl,
      destaque: destaque ?? this.destaque,
    );
  }
}
