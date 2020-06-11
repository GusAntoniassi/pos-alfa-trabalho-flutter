import 'package:aula02bd/ui/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight
  ]);

  runApp(MaterialApp(
    title: "Meus livros",
    debugShowCheckedModeBanner: false,
    home: HomePage()
  ));
}
