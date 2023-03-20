
class Filho {
  dynamic? nome;
  dynamic? aniversario;

  Filho(dynamic nome, dynamic aniversario) {
    this.nome = nome;
    this.aniversario = aniversario;
  }
}

class FilhoDocument {
  List<Filho>? filhos;
}