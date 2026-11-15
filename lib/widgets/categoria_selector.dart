import 'package:flutter/material.dart';

import '../models/categoria.dart';

// Widget 2: a fileira de chips do filtro.
// Ele não filtra nada: só mostra qual está ativo e avisa a tela do toque.
class CategoriaSelector extends StatelessWidget {
  const CategoriaSelector({
    super.key,
    required this.categorias,
    required this.categoriaSelecionada,
    required this.onCategoriaSelecionada,
  });

  final List<Categoria> categorias;
  final Categoria? categoriaSelecionada;
  final ValueChanged<Categoria?> onCategoriaSelecionada;

  @override
  Widget build(BuildContext context) {
    // O primeiro item, null, é o "Todas".
    final opcoes = <Categoria?>[null, ...categorias];

    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: opcoes.length,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final categoria = opcoes[index];
          return _Chip(
            texto: categoria?.label ?? 'Todas',
            selecionado: categoria == categoriaSelecionada,
            onTap: () => onCategoriaSelecionada(categoria),
          );
        },
      ),
    );
  }
}

// Selecionado fica azul cheio; os outros, brancos com borda fina.
class _Chip extends StatelessWidget {
  const _Chip({
    required this.texto,
    required this.selecionado,
    required this.onTap,
  });

  final String texto;
  final bool selecionado;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final cores = Theme.of(context).colorScheme;

    return ChoiceChip(
      label: Text(texto),
      selected: selecionado,
      onSelected: (_) => onTap(),
      showCheckmark: false,
      shape: const StadiumBorder(),
      backgroundColor: cores.surface,
      selectedColor: cores.primary,
      side: BorderSide(
        color: selecionado ? cores.primary : cores.outlineVariant,
      ),
      labelStyle: TextStyle(
        color: selecionado ? cores.onPrimary : cores.primary,
      ),
    );
  }
}
