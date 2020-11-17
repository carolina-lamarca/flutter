class Eletro {
  int _id;
  String _marca;
  String _modelo;
  String _cor;
  String _preco;
  //construtor da classe
  Eletro(this._marca, this._modelo, this._cor, this._preco);
  //converte dados de vetor para objeto
  Eletro.map(dynamic obj) {
    this._id = obj['id'];
    this._marca = obj['marca'];
    this._modelo = obj['modelo'];
    this._cor = obj['cor'];
    this._preco = obj['preco'];
  }
  // encapsulamento
  int get id => _id;
  String get marca => _marca;
  String get modelo => _modelo;
  String get cor => _cor;
  String get preco => _preco;
//converte o objeto em um map
  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['marca'] = _marca;
    map['modelo'] = _modelo;
    map['cor'] = _cor;
    map['preco'] = _preco;
    return map;
  }

  //converte map em um objeto
  Eletro.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._marca = map['marca'];
    this._modelo = map['modelo'];
    this._cor = map['cor'];
    this._preco = map['preco'];
  }
}
