import 'package:aula02bd/helpers/livro_helper.dart';
import 'package:aula02bd/widgets/app_button.dart';
import 'package:aula02bd/widgets/app_dialog.dart';
import 'package:aula02bd/widgets/app_text_field.dart';
import 'package:aula02bd/widgets/title_bar.dart';
import 'package:flutter/material.dart';

class CadastroPage extends StatefulWidget {
  final Livro _livroData;
  final Function _refreshCallback;

  CadastroPage(this._livroData, this._refreshCallback);

  @override
  _CadastroPageState createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  LivroHelper livroHelper = LivroHelper();

  final nomeController = TextEditingController();
  final editoraController = TextEditingController();
  final anoController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget._livroData != null) {
      nomeController.text = widget._livroData.nome;
      editoraController.text = widget._livroData.editora ?? "";
      anoController.text =
          widget._livroData.ano != null ? widget._livroData.ano.toString() : "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitleBar.create("Cadastro de Livros"),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          child: Column(
        children: <Widget>[
          AppTextField.create(nomeController, "Nome"),
          AppTextField.create(editoraController, "Editora"),
          AppTextField.create(anoController, "Ano",
              textInputType: TextInputType.number),
          criarBotao("Salvar", Icons.save, Colors.green[900], Colors.white,
              salvarLivro),
          criarBotaoExcluir()
        ],
      )),
    );
  }

  Widget criarBotao(String texto, IconData icone, Color corBotao,
      Color corTexto, Function f) {
    return AppButton.create(texto, f,
        left: 60,
        top: 10,
        right: 60,
        bottom: 0,
        bgColor: corBotao,
        icon: icone);
  }

  void salvarLivro() {
    if (nomeController.text.isEmpty) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
                title: Text("Atenção"),
                content: Text("Informe o nome do livro"),
                actions: <Widget>[
                  FlatButton(
                    child: Text("OK"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ]);
          });
    }

    Livro livro = Livro();
    livro.nome = nomeController.text;
    livro.editora = editoraController.text;
    livro.ano = int.parse(anoController.text);

    if (widget._livroData == null) {
      livroHelper.inserir(livro);
    } else {
      livro.codigo = widget._livroData.codigo;
      livroHelper.alterar(livro);
    }

    widget._refreshCallback();
    Navigator.pop(context);
  }

  Widget criarBotaoExcluir() {
    if (widget._livroData != null) {
      return criarBotao(
          "Excluir", Icons.delete, Colors.red[600], Colors.white, excluirLivro);
    }

    return Container();
  }

  void excluirLivro() {
    YesOrNoDialog.create(context, "Deseja realmente apagar o registro?",
        trueCallback: () {
      livroHelper.apagar(widget._livroData.codigo);
      widget._refreshCallback();
      Navigator.pop(context);
    });
  }
}
