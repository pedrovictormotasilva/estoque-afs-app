import 'package:flutter/material.dart';

class CrudContainer extends StatefulWidget {
  final String title;
  final String code;
  final int stock;

  const CrudContainer({
    Key? key,
    required this.title,
    required this.code,
    required this.stock,
  }) : super(key: key);

  @override
  State<CrudContainer> createState() => _CrudContainerState();
}

class _CrudContainerState extends State<CrudContainer> {
  @override
  Widget build(BuildContext context) {
    String FormatTittle =
        '${widget.title[0].toUpperCase()}${widget.title.substring(1)}';

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 3,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  FormatTittle,
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                ),
                Row(
                  children: <Widget>[
                    IconButton(
                      icon:
                          Icon(Icons.delete_outline, color: Color(0xFFF24E1E)),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon:
                          Icon(Icons.edit_note_sharp, color: Color(0xFF086632)),
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
            Divider(),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Código:',
                  style: TextStyle(fontSize: 16, color: Color(0xFF525252)),
                ),
                Text(
                  widget.code,
                  style: TextStyle(fontSize: 16, color: Color(0xFF525252)),
                ),
              ],
            ),
            Divider(),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Estoque:',
                  style: TextStyle(fontSize: 16, color: Color(0xFF525252)),
                ),
                Text(
                  '${widget.stock}',
                  style: TextStyle(fontSize: 16, color: Color(0xFF525252)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
