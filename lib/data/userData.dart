class UserData {
  String nome;
  String email;
  int id;
  String cpf;

  UserData(Map<String, dynamic> data) {
    email = data['email'];
    nome = data['nome'];
    id = data['id'];
    cpf = data['cpf'];
  }

}