import 'package:estoque_app/pages/homePages/cabosPage.dart';
import 'package:estoque_app/pages/homePages/componentesPage.dart';
import 'package:estoque_app/pages/homePages/computadoresPage.dart';
import 'package:estoque_app/pages/homePages/materiaisPage.dart';
import 'package:estoque_app/pages/homePages/notebookPage.dart';
import 'package:flutter/material.dart';

class RoutesHomePage {
  static final Map<String, WidgetBuilder> routes = {
    '/computadores': (context) => ComputadoresPage(),
    '/componentes': (context) => ComponentesPage(),
    '/materiais': (context) => MateriaisPage(),
    '/notebooks': (context) => NotebookPage(),
    '/cabos': (context) => CabosPage(),
  };
}
