import 'package:alertacheia/data/abrigo_repository.dart';
import 'package:alertacheia/models/categoria.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final repository = AbrigoRepository();

  test('lista os 8 abrigos, com mais vagas primeiro', () {
    final abrigos = repository.listar();
    expect(abrigos.length, 8);
    expect(abrigos.first.nome, 'Biblioteca de Itaquera');
    expect(abrigos.last.lotado, isTrue);
  });

  test('filtra pela categoria do enum', () {
    final comPet = repository.filtrar(Categoria.aceitaPet);
    expect(comPet.length, 3);
    expect(
      comPet.every((a) => a.categorias.contains(Categoria.aceitaPet)),
      isTrue,
    );
  });

  test('a rota segura nunca indica abrigo lotado', () {
    final destaques = repository.destaques();
    expect(destaques.length, 3);
    expect(destaques.any((a) => a.lotado), isFalse);
  });
}
