import 'package:flutter/material.dart';

// Foto do abrigo pela internet, usada na lista e nos destaques.
// Se a foto não carregar, mostra um ícone no lugar.
class FotoAbrigo extends StatelessWidget {
  const FotoAbrigo({
    super.key,
    required this.url,
    required this.altura,
    this.largura,
  });

  final String url;
  final double altura;
  final double? largura;

  @override
  Widget build(BuildContext context) {
    final cores = Theme.of(context).colorScheme;

    return Image.network(
      url,
      width: largura,
      height: altura,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) => Container(
        width: largura,
        height: altura,
        color: cores.primaryContainer,
        child: Icon(Icons.home_work, color: cores.secondary),
      ),
    );
  }
}
