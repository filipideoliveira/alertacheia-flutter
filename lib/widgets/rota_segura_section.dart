import 'package:flutter/material.dart';

import '../models/abrigo.dart';
import 'foto_abrigo.dart';

// Widget 3: o alerta da região e a faixa horizontal de destaques.
class RotaSeguraSection extends StatelessWidget {
  const RotaSeguraSection({
    super.key,
    required this.abrigos,
    required this.regioesEmAlerta,
  });

  final List<Abrigo> abrigos;
  final List<String> regioesEmAlerta;

  @override
  Widget build(BuildContext context) {
    if (abrigos.isEmpty) return const SizedBox.shrink();

    final cores = Theme.of(context).colorScheme;
    final textos = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: cores.error,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(Icons.warning_rounded, size: 18, color: cores.onError),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Alerta de enchente: ${regioesEmAlerta.join(' e ')}',
                  style: textos.bodyMedium?.copyWith(
                    color: cores.onError,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'Rota segura',
          style: textos.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        Text(
          'Com vaga e sem rua alagada no caminho',
          style: textos.bodyMedium?.copyWith(color: cores.onSurfaceVariant),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 212,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: abrigos.length,
            separatorBuilder: (context, index) => const SizedBox(width: 12),
            itemBuilder: (context, index) =>
                _DestaqueCard(abrigo: abrigos[index]),
          ),
        ),
      ],
    );
  }
}

class _DestaqueCard extends StatelessWidget {
  const _DestaqueCard({required this.abrigo});

  final Abrigo abrigo;

  @override
  Widget build(BuildContext context) {
    final cores = Theme.of(context).colorScheme;
    final textos = Theme.of(context).textTheme;

    return SizedBox(
      width: 220,
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 0,
        color: cores.surface,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: cores.outlineVariant),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Foto com o selo de vagas por cima, no canto.
            Stack(
              children: [
                FotoAbrigo(url: abrigo.imagemUrl, largura: 220, altura: 120),
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: abrigo.vagaCritica ? cores.error : cores.primary,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Text(
                      '${abrigo.vagasLivres} vagas',
                      style: textos.labelMedium?.copyWith(
                        color: cores.onPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Altura de 2 linhas, pra todos os cards ficarem alinhados.
                  SizedBox(
                    height: 42,
                    child: Text(
                      abrigo.nome,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: textos.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.location_on, size: 14, color: cores.secondary),
                      const SizedBox(width: 2),
                      Expanded(
                        child: Text(
                          abrigo.bairro,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: textos.bodySmall?.copyWith(
                            color: cores.onSurfaceVariant,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
