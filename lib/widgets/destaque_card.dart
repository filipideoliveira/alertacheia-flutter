import 'package:flutter/material.dart';

import '../models/abrigo.dart';
import 'foto_abrigo.dart';

// Card de cada abrigo na faixa horizontal da Rota segura.
class DestaqueCard extends StatelessWidget {
  const DestaqueCard({super.key, required this.abrigo});

  static const largura = 220.0;
  static const alturaFoto = 120.0;

  // Altura total do card. A parte de texto cresce junto com a fonte do celular,
  // pra não estourar quando a pessoa aumenta a letra na acessibilidade.
  static double altura(BuildContext context) =>
      alturaFoto + 24 + MediaQuery.textScalerOf(context).scale(68);

  final Abrigo abrigo;

  @override
  Widget build(BuildContext context) {
    final cores = Theme.of(context).colorScheme;
    final textos = Theme.of(context).textTheme;

    return SizedBox(
      width: largura,
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
                FotoAbrigo(
                  url: abrigo.imagemUrl,
                  largura: largura,
                  altura: alturaFoto,
                ),
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
                    height: MediaQuery.textScalerOf(context).scale(42),
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
