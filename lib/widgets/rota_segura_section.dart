import 'package:flutter/material.dart';

import '../models/abrigo.dart';
import 'destaque_card.dart';

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
    final cores = Theme.of(context).colorScheme;
    final textos = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // O alerta aparece sempre que houver região em alerta, com ou sem destaque.
        if (regioesEmAlerta.isNotEmpty) ...[
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
        ],
        if (abrigos.isNotEmpty) ...[
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
            height: DestaqueCard.altura(context),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: abrigos.length,
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.only(
                  right: index == abrigos.length - 1 ? 0 : 12,
                ),
                child: DestaqueCard(abrigo: abrigos[index]),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
