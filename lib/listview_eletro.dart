import 'package:flutter/material.dart';
import 'package:prova2/eletro.dart';
import 'package:prova2/database_helper.dart';
import 'package:prova2/eletro_screen.dart';

class ListViewEletro extends StatefulWidget {
  @override
  _ListViewEletroState createState() => new _ListViewEletroState();
}

class _ListViewEletroState extends State<ListViewEletro> {
  List<Eletro> items = new List();
  //conexão com banco de dados
  DatabaseHelper db = new DatabaseHelper();
  @override
  void initState() {
    super.initState();
    db.getEletros().then((eletros) {
      setState(() {
        eletros.forEach((eletro) {
          items.add(Eletro.fromMap(eletro));
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cadastro Eletro',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Cadastro de Eletro'),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        body: Center(
          child: ListView.builder(
              itemCount: items.length,
              padding: const EdgeInsets.all(15.0),
              itemBuilder: (context, position) {
                return Column(
                  children: [
                    Divider(height: 5.0),
                    ListTile(
                      title: Text(
                        '${items[position].marca}',
                        style: TextStyle(
                          fontSize: 22.0,
                          color: Colors.deepOrangeAccent,
                        ),
                      ),
                      subtitle: Row(children: [
                        Text('${items[position].modelo}',
                            style: new TextStyle(
                              fontSize: 18.0,
                              fontStyle: FontStyle.italic,
                            )),
                        Text('${items[position].cor}',
                            style: new TextStyle(
                              fontSize: 18.0,
                              fontStyle: FontStyle.italic,
                            )),
                        Text('${items[position].preco}',
                            style: new TextStyle(
                              fontSize: 18.0,
                              fontStyle: FontStyle.italic,
                            )),
                        IconButton(
                            icon: const Icon(Icons.remove_circle_outline),
                            onPressed: () => _deleteEletro(
                                context, items[position], position)),
                      ]),
                      leading: CircleAvatar(
                        backgroundColor: Colors.blueAccent,
                        radius: 15.0,
                        child: Text(
                          '${items[position].id}',
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      onTap: () => _navigateToEletro(context, items[position]),
                    ),
                  ],
                );
              }),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => _createNewEletro(context),
        ),
      ),
    );
  }

  void _deleteEletro(BuildContext context, Eletro eletro, int position) async {
    db.deleteEletro(eletro.id).then((eletros) {
      setState(() {
        items.removeAt(position);
      });
    });
  }

  void _navigateToEletro(BuildContext context, Eletro eletro) async {
    String result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EletroScreen(eletro)),
    );
    if (result == 'update') {
      db.getEletros().then((eletros) {
        setState(() {
          items.clear();
          eletros.forEach((eletro) {
            items.add(Eletro.fromMap(eletro));
          });
        });
      });
    }
  }

  void _createNewEletro(BuildContext context) async {
    //aguarda o retorno da página de cadastro
    String result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => EletroScreen(Eletro('', '', '', ''))),
    );
    //se o retorno for salvar, recarrega a lista
    if (result == 'save') {
      db.getEletros().then((eletros) {
        setState(() {
          items.clear();
          eletros.forEach((eletro) {
            items.add(Eletro.fromMap(eletro));
          });
        });
      });
    }
  }
}
