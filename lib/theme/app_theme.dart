import 'package:flutter/material.dart';

// Azul de oceano profundo: a identidade do app.
const oceano = Color(0xFF0B3954);
const oceanoMedio = Color(0xFF1F6F8B);
const aguaClara = Color(0xFFDCEBF2);
const fundo = Color(0xFFF2F6F8);

// Vermelho de alerta: só para o que exige atenção.
const alerta = Color(0xFFD62828);

// Neutros: texto secundário e bordas finas dos cards.
const textoSuave = Color(0xFF5B7083);
const borda = Color(0xFFD6E2E9);

final appTheme = ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: fundo,
  colorScheme: ColorScheme.fromSeed(seedColor: oceano).copyWith(
    primary: oceano,
    onPrimary: Colors.white,
    primaryContainer: aguaClara,
    secondary: oceanoMedio,
    surface: Colors.white,
    onSurface: oceano,
    onSurfaceVariant: textoSuave,
    outlineVariant: borda,
    error: alerta,
    onError: Colors.white,
  ),
);
