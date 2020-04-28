class FilhosData {
  int id;
  String nome;
  String cpf;
  String dataNascimento;
  String estado;
  String cidade;
  String bairro;
  String numeroSus;

  FilhosData(Map<String, dynamic> data) {
    nome = data['nome'];
    id = data['id'];
    cpf = data['cpf'];
    dataNascimento = data['dataNascimento'];
    estado = data['estado'];
    cidade = data['cidade'];
    bairro = data['bairro'];
    numeroSus = data['numeroSus'];
  }

}