import 'package:flutter/material.dart';

import '../data/abrigo_repository.dart';
import '../models/categoria.dart';
import '../widgets/abrigo_list_item.dart';
import '../widgets/categoria_selector.dart';
import '../widgets/rota_segura_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _repository = AbrigoRepository();

  // Estado do filtro: null significa "Todas".
  Categoria? _categoriaSelecionada;

  void _selecionarCategoria(Categoria? categoria) {
    setState(() => _categoriaSelecionada = categoria);
  }

  @override
  Widget build(BuildContext context) {
    // A tela só pede ao repositório. Nenhum filtro é feito aqui.
    final abrigosVisiveis = _repository.filtrar(_categoriaSelecionada);
    final destaques = _repository.destaques();
    final cores = Theme.of(context).colorScheme;
    final titulo = Theme.of(context).textTheme.titleLarge
        ?.copyWith(fontWeight: FontWeight.bold);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'AlertaCheia',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: cores.primary,
        foregroundColor: cores.onPrimary,
      ),
      // O topo, o filtro e a lista rolam juntos numa coluna só.
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RotaSeguraSection(
                abrigos: destaques,
                regioesEmAlerta: _repository.regioesEmAlerta(),
              ),
              const SizedBox(height: 20),
              Text('Do que você precisa?', style: titulo),
              const SizedBox(height: 12),
              CategoriaSelector(
                categorias: Categoria.values,
                categoriaSelecionada: _categoriaSelecionada,
                onCategoriaSelecionada: _selecionarCategoria,
              ),
              const SizedBox(height: 20),
              Text(
                '${_categoriaSelecionada?.label ?? 'Todos os abrigos'} '
                '(${abrigosVisiveis.length})',
                style: titulo,
              ),
              const SizedBox(height: 12),
              if (abrigosVisiveis.isEmpty)
                const Text('Nenhum abrigo com esse atendimento')
              else
                // A lista vertical. Quem rola é a tela, por isso ela não rola sozinha.
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: abrigosVisiveis.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 12),
                  itemBuilder: (context, index) =>
                      AbrigoListItem(abrigo: abrigosVisiveis[index]),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
