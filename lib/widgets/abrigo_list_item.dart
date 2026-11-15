import 'package:flutter/material.dart';

import '../models/abrigo.dart';
import 'foto_abrigo.dart';

// Widget 1: o card de cada abrigo na lista vertical.
class AbrigoListItem extends StatelessWidget {
  const AbrigoListItem({super.key, required this.abrigo});

  final Abrigo abrigo;

  @override
  Widget build(BuildContext context) {
    final cores = Theme.of(context).colorScheme;
    final textos = Theme.of(context).textTheme;

    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      color: cores.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: cores.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: FotoAbrigo(url: abrigo.imagemUrl, largura: 96, altura: 96),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    abrigo.nome,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textos.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.location_on, size: 14, color: cores.secondary),
                      const SizedBox(width: 2),
                      Expanded(
                        child: Text(
                          '${abrigo.bairro} · ${abrigo.regiao}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: textos.bodySmall?.copyWith(
                            color: cores.onSurfaceVariant,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    abrigo.categorias.map((c) => c.label).join(', '),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: textos.bodySmall?.copyWith(
                      color: cores.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _StatusVagas(abrigo: abrigo),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Barra de ocupação e texto de vagas. Vermelho só quando falta vaga.
class _StatusVagas extends StatelessWidget {
  const _StatusVagas({required this.abrigo});

  final Abrigo abrigo;

  @override
  Widget build(BuildContext context) {
    final cores = Theme.of(context).colorScheme;
    final cor = abrigo.vagaCritica ? cores.error : cores.secondary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(3),
          child: LinearProgressIndicator(
            value: abrigo.ocupacao / abrigo.capacidade,
            minHeight: 6,
            color: cor,
            backgroundColor: cores.primaryContainer,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          abrigo.lotado
              ? 'Lotado · ${abrigo.ocupacao} de ${abrigo.capacidade}'
              : '${abrigo.vagasLivres} vagas livres de ${abrigo.capacidade}',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: abrigo.vagaCritica ? cores.error : cores.primary,
          ),
        ),
      ],
    );
  }
}
