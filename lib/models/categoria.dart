// Os atendimentos que um abrigo pode oferecer.
// O filtro compara estes valores, nunca o texto.
enum Categoria {
  acessivel('Acessível'),
  aceitaPet('Aceita pet'),
  atendimentoMedico('Atendimento médico'),
  bebesECriancas('Bebês e crianças'),
  roupaSecaEBanho('Roupa seca e banho');

  const Categoria(this.label);

  final String label;
}
