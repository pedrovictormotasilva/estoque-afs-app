import 'package:flutter/material.dart';

class CabosPage extends StatefulWidget {
  final String accessToken;

  const CabosPage({Key? key, required this.accessToken}) : super(key: key);

  @override
  State<CabosPage> createState() => _CabosPageState();
}

class _CabosPageState extends State<CabosPage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
