import 'package:flutter/material.dart';

class NotebookPage extends StatefulWidget {
  final String accessToken;

  const NotebookPage({Key? key, required this.accessToken}) : super(key: key);

  @override
  State<NotebookPage> createState() => _NotebookPageState();
}

class _NotebookPageState extends State<NotebookPage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
