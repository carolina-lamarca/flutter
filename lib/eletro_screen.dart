import 'package:flutter/material.dart';
import 'package:prova2/eletro.dart';
import 'package:prova2/database_helper.dart';

class EletroScreen extends StatefulWidget {
  final Eletro eletro;
  EletroScreen(this.eletro);
  @override
  State<StatefulWidget> createState() => new _EletroScreenState();
}

class _EletroScreenState extends State<EletroScreen> {
  DatabaseHelper db = new DatabaseHelper();
  TextEditingController _marcaController;
  TextEditingController _modeloController;
  TextEditingController _corController;
  TextEditingController _precoController;
  @override
  void initState() {
    super.initState();
    _marcaController = new TextEditingController(text: widget.eletro.marca);
    _modeloController = new TextEditingController(text: widget.eletro.modelo);
    _corController = new TextEditingController(text: widget.eletro.cor);
    _precoController = new TextEditingController(text: widget.eletro.preco);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Eletrodoméstico')),
      body: Container(
        margin: EdgeInsets.all(15.0),
        alignment: Alignment.center,
        child: Column(
          children: [Image.network(
        'https://image.freepik.com/vetores-gratis/aparelhos-e-utensilios-de-cozinha-conjunto-de-icones_1284-10067.jpg',),
            TextField(
              controller: _marcaController,
              decoration: InputDecoration(labelText: 'Marca'),
            ),
            Padding(padding: new EdgeInsets.all(5.0)),
            TextField(
              controller: _modeloController,
              decoration: InputDecoration(labelText: 'Modelo'),
            ),
            Padding(padding: new EdgeInsets.all(5.0)),
            TextField(
              controller: _corController,
              decoration: InputDecoration(labelText: 'Cor'),
            ),
            Padding(padding: new EdgeInsets.all(5.0)),
            TextField(
              controller: _precoController,
              decoration: InputDecoration(labelText: 'Preco'),
            ),
            Padding(padding: new EdgeInsets.all(5.0)),
            RaisedButton(
              child: (widget.eletro.id != null)
                  ? Text('Alterar')
                  : Text('Inserir'),
              onPressed: () {
                if (widget.eletro.id != null) {
                  db
                      .updateEletro(Eletro.fromMap({
                    'id': widget.eletro.id,
                    'marca': _marcaController.text,
                    'modelo': _modeloController.text,
                    'cor': _corController.text,
                    'preco': _precoController.text
                  }))
                      .then((_) {
                    Navigator.pop(context, 'update');
                  });
                } else {
                  db
                      .inserirEletro(Eletro(
                          _marcaController.text,
                          _modeloController.text,
                          _corController.text,
                          _precoController.text))
                      .then((_) {
                    Navigator.pop(context, 'save');
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
