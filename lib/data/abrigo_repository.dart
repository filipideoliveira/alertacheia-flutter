import '../models/abrigo.dart';
import '../models/categoria.dart';

// Os dados ficam em memória. Toda regra de filtro e destaque mora aqui,
// nunca dentro dos widgets.
class AbrigoRepository {
  AbrigoRepository() {
    final comDestaque = _dados
        .map((abrigo) => abrigo.copyWith(destaque: _estaNaRotaSegura(abrigo)))
        .toList();
    // Mais vagas primeiro; no empate, mantém a ordem original.
    _abrigos = [...comDestaque]
      ..sort((a, b) {
        final porVagas = b.vagasLivres.compareTo(a.vagasLivres);
        return porVagas != 0
            ? porVagas
            : comDestaque.indexOf(a).compareTo(comDestaque.indexOf(b));
      });
  }

  // Regiões com alerta de enchente agora, as mesmas da consulta do banco.
  static const _regioesEmAlerta = ['Centro', 'Zona Leste'];

  // Bairros com rua alagada no caminho até o abrigo.
  static const _bairrosComRuaAlagada = ['República', 'São Miguel Paulista'];

  late final List<Abrigo> _abrigos;

  List<String> regioesEmAlerta() => _regioesEmAlerta;

  List<Abrigo> listar() => List.unmodifiable(_abrigos);

  // Rota segura: tem vaga, fica numa região em alerta e não tem rua alagada.
  List<Abrigo> destaques() => _abrigos.where((a) => a.destaque).toList();

  // null significa "Todas".
  List<Abrigo> filtrar(Categoria? categoria) {
    if (categoria == null) return listar();
    return _abrigos.where((a) => a.categorias.contains(categoria)).toList();
  }

  static bool _estaNaRotaSegura(Abrigo abrigo) {
    return !abrigo.lotado &&
        _regioesEmAlerta.contains(abrigo.regiao) &&
        !_bairrosComRuaAlagada.contains(abrigo.bairro);
  }

  static String _foto(String id) =>
      'https://images.unsplash.com/photo-$id?w=600&q=80&fit=crop';

  static final _dados = [
    Abrigo(
      nome: 'Escola Municipal da Sé',
      bairro: 'Sé',
      regiao: 'Centro',
      capacidade: 120,
      ocupacao: 118,
      categorias: const [Categoria.acessivel, Categoria.atendimentoMedico],
      imagemUrl: _foto('1592066575517-58df903152f2'),
    ),
    Abrigo(
      nome: 'Ginásio República',
      bairro: 'República',
      regiao: 'Centro',
      capacidade: 200,
      ocupacao: 90,
      categorias: const [Categoria.aceitaPet, Categoria.roupaSecaEBanho],
      imagemUrl: _foto('1768554630751-6448593749eb'),
    ),
    Abrigo(
      nome: 'Centro Educacional Santana',
      bairro: 'Santana',
      regiao: 'Zona Norte',
      capacidade: 150,
      ocupacao: 150,
      categorias: const [
        Categoria.acessivel,
        Categoria.atendimentoMedico,
        Categoria.bebesECriancas,
      ],
      imagemUrl: _foto('1591123120675-6f7f1aae0e5b'),
    ),
    Abrigo(
      nome: 'Escola Estadual Vila Maria',
      bairro: 'Vila Maria',
      regiao: 'Zona Norte',
      capacidade: 100,
      ocupacao: 40,
      categorias: const [Categoria.bebesECriancas, Categoria.roupaSecaEBanho],
      imagemUrl: _foto('1613896527026-f195d5c818ed'),
    ),
    Abrigo(
      nome: 'Biblioteca de Itaquera',
      bairro: 'Itaquera',
      regiao: 'Zona Leste',
      capacidade: 250,
      ocupacao: 60,
      categorias: const [
        Categoria.acessivel,
        Categoria.aceitaPet,
        Categoria.roupaSecaEBanho,
      ],
      imagemUrl: _foto('1780004033644-0a6d7798943c'),
    ),
    Abrigo(
      nome: 'Escola Municipal São Miguel',
      bairro: 'São Miguel Paulista',
      regiao: 'Zona Leste',
      capacidade: 180,
      ocupacao: 120,
      categorias: const [Categoria.atendimentoMedico, Categoria.bebesECriancas],
      imagemUrl: _foto('1584750153892-38414eb8e76a'),
    ),
    Abrigo(
      nome: 'Centro Comunitário Mooca',
      bairro: 'Mooca',
      regiao: 'Zona Leste',
      capacidade: 120,
      ocupacao: 70,
      categorias: const [
        Categoria.acessivel,
        Categoria.aceitaPet,
        Categoria.atendimentoMedico,
      ],
      imagemUrl: _foto('1774386897531-1f5d7741409c'),
    ),
    Abrigo(
      nome: 'Paróquia Pinheiros',
      bairro: 'Pinheiros',
      regiao: 'Zona Oeste',
      capacidade: 80,
      ocupacao: 30,
      categorias: const [Categoria.bebesECriancas, Categoria.roupaSecaEBanho],
      imagemUrl: _foto('1709794150814-77b9d1f27364'),
    ),
  ];
}
