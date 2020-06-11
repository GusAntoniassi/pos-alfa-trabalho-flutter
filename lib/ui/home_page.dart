import 'package:aula02bd/helpers/livro_helper.dart';
import 'package:aula02bd/ui/cadastro_page.dart';
import 'package:aula02bd/widgets/app_dialog.dart';
import 'package:aula02bd/widgets/text_label.dart';
import 'package:aula02bd/widgets/title_bar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  LivroHelper livroHelper = LivroHelper();

  Future<List<dynamic>> _getLista() async {
    return await livroHelper.getTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitleBar.create(
        "Meus livros",
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.add, color: Colors.white, size: 32),
              onPressed: () {
                abrirCadastroLivro(context);
              })
        ],
      ),
      body: FutureBuilder(
          future: _getLista(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
              case ConnectionState.none:
                return Center(
                    child: Container(
                        width: 200,
                        height: 200,
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.black),
                          strokeWidth: 5,
                        )));
              default:
                if (snapshot.hasError) {
                  return GestureDetector(
                    child: Column(
                      children: <Widget>[
                        Icon(Icons.error_outline, size: 100, color: Colors.red),
                        TextLabel.create("Não foi possível carregar os livros.",
                            size: 20.0, color: Colors.red)
                      ],
                    ),
                    onTap: () {
                      setState(() {});
                    },
                  );
                }
                return criarListagem(context, snapshot);
            }
          }),
      backgroundColor: Colors.white,
    );
  }

  void abrirCadastroLivro(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => CadastroPage(null, _refresh)));
  }

  void abrirEdicaoLivro(BuildContext context, Livro livro) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => CadastroPage(livro, _refresh)));
  }

  Widget criarListagem(BuildContext context, AsyncSnapshot<dynamic> snapshot) {
    return RefreshIndicator(
        onRefresh: _refresh,
        child: Container(
          color: Color(0xFFEDEDED),
          padding: EdgeInsets.all(8),
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: UniqueKey(),
                  child: criarItemLista(snapshot.data[index] as Livro),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    alignment: Alignment(1, 0),
                    padding: EdgeInsets.all(8),
                    color: Colors.red,
                    child: TextLabel.create(
                      "Excluir Livro",
                      color: Colors.white,
                      size: 16.0,
                    ),
                  ),
                  confirmDismiss: (DismissDirection direction) {
                    return YesOrNoDialog.create(context, "Deseja remover o livro");
                  },
                  onDismissed: (DismissDirection direction) {
                    LivroHelper()
                        .apagar((snapshot.data[index] as Livro).codigo);
                  },
                );
              }),
        ));
  }

  Widget criarItemLista(Livro livro) {
    return GestureDetector(
        child: Card(
            color: Colors.white,
            child: Padding(
                padding: EdgeInsets.all(16),
                child: Row(children: <Widget>[
                  Expanded(
                      child: Text(
                    livro.nome,
                    style: TextStyle(fontSize: 24, color: Colors.black),
                  )),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      TextLabel.create(livro.editora ?? "",
                          bold: FontWeight.bold, color: Colors.black),
                      TextLabel.create(
                          livro.ano == null ? "" : livro.ano.toString(),
                          size: 14.0,
                          color: Colors.black)
                    ],
                  )
                ]))),
        onTap: () {
          abrirEdicaoLivro(context, livro);
        });
  }

  Future<void> _refresh() async {
    setState(() {});
  }
}
