import 'package:alertacheia/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // Sem overflow nem com a fonte do celular aumentada na acessibilidade.
  for (final escala in [1.0, 1.3, 2.0]) {
    testWidgets('tela sem overflow com fonte em ${escala}x', (tester) async {
      tester.view.physicalSize = const Size(1080, 2340);
      tester.view.devicePixelRatio = 3;
      addTearDown(tester.view.reset);
      tester.platformDispatcher.textScaleFactorTestValue = escala;
      addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);

      await tester.pumpWidget(const AlertaCheiaApp());
      await tester.pumpAndSettle();

      expect(find.textContaining('Alerta de enchente'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  }
}
