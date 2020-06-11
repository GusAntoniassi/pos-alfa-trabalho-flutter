import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';

final String nomeBancoDados = "banco_dados.db";
final String livroTabela = "TbLivro";
final String codigoColumn = "codigo";
final String nomeColumn = "nome";
final String editoraColumn = "editora";
final String anoColumn = "ano";

class Livro {
  int codigo;
  String nome, editora;
  int ano;

  Livro();

  // Método estático
  Livro.fromMap(Map map) {
    codigo = map[codigoColumn];
    nome = map[nomeColumn];
    editora = map[editoraColumn];
    ano = map[anoColumn];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      codigoColumn: codigo,
      nomeColumn: nome,
      editoraColumn: editora,
      anoColumn: ano
    };

    // Usado p/ definir o código no insert
    if (codigo != null) {
      map[codigoColumn] = codigo;
    }
  
    return map;
  }

  @override
  String toString() {
    return "Livro:\n  Cod: $codigo\n    Nome: $nome\n    Editora: $editora\n    Ano: $ano";
  }
}

class LivroHelper {
  static final LivroHelper _instance = LivroHelper.internal();
  factory LivroHelper() => _instance;
  LivroHelper.internal();

  Database _db;

  Future<Database> get db async {
    if (_db == null) {
      _db = await initDb();
    }

    return _db;
  }

  Future<Database> initDb() async {
    final path = await getDatabasesPath();
    final caminhoBanco = join(path, nomeBancoDados);

    return await openDatabase(caminhoBanco, version: 1, 
      onCreate: (Database db, int newVersion) async {
        await db.execute("CREATE TABLE $livroTabela ("
          "$codigoColumn INTEGER PRIMARY KEY,"
          "$nomeColumn TEXT,"
          "$editoraColumn TEXT,"
          "$anoColumn INTEGER"
        ")");
      }
    );
  }

  Future<Livro> inserir(Livro livro) async {
    Database dbLivro = await db;
    livro.codigo = await dbLivro.insert(livroTabela, livro.toMap());

    return livro;
  }

  Future<int> alterar(Livro livro) async {
    Database dbLivro = await db;
    return await dbLivro.update(livroTabela, livro.toMap(), 
      where: "$codigoColumn = ?",
      whereArgs: [livro.codigo] 
    );
  }

  Future<int> apagar(int codigo) async {
    Database dbLivro = await db;
    return await dbLivro.delete(livroTabela,
      where: "$codigoColumn = ?",
      whereArgs: [codigo]
    );
  }

  Future<List> getTodos() async {
    Database dbLivro = await db;
    List listaMap = await dbLivro.query(livroTabela, 
      columns: [codigoColumn, nomeColumn, editoraColumn, anoColumn]
    );

    List<Livro> listaLivro = List();
    for (Map m in listaMap) {
      listaLivro.add(Livro.fromMap(m));
    }

    return listaLivro;
  }

  Future<Livro> getLivro(int id) async {
    Database dbLivro = await db;
    
    List<Map> listaMap = await dbLivro.query(livroTabela, 
      columns: [codigoColumn, nomeColumn, editoraColumn, anoColumn],
      where: "$codigoColumn = ?",
      whereArgs: [id],
      limit: 1
    );

    return listaMap.length > 0 ? Livro.fromMap(listaMap.first) : null;
  }

  Future<int> getTotal() async {
    Database dbLivro = await db;

    return Sqflite.firstIntValue(
      await dbLivro.rawQuery("SELECT COUNT(*) FROM $livroTabela")
    );
  }

  Future close() async {
    Database dbLivro = await db;
    dbLivro.close();
  }
}