import 'package:flutter/material.dart';

class ComponentesPage extends StatefulWidget {
  final String accessToken;

  const ComponentesPage({Key? key, required this.accessToken}) : super(key: key);

  @override
  State<ComponentesPage> createState() => _ComponentesPageState();
}

class _ComponentesPageState extends State<ComponentesPage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
