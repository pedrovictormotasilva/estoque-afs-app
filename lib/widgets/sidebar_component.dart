import 'package:estoque_app/pages/homePages/cabosPage.dart';
import 'package:estoque_app/pages/homePages/componentesPage.dart';
import 'package:estoque_app/pages/homePages/computadoresPage.dart';
import 'package:estoque_app/pages/homePages/materiaisPage.dart';
import 'package:estoque_app/pages/homePages/notebookPage.dart';
import 'package:flutter/material.dart';

class SideBar extends StatefulWidget {
  final String accessToken;
  const SideBar({super.key, required this.accessToken});



  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Color(0xFF074824),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF074824),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: Icon(Icons.close, color: Colors.white),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
            _createDrawerItem(
              icon: Icons.computer,
              text: 'Computadores',
              index: 0,
              onTap: () {
                setState(() {
                  _selectedIndex = 0;
                });
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ComputadoresPage(
                    accessToken: widget.accessToken,
                  ),
                ));
              },
            ),
            _createDrawerItem(
              icon: Icons.build,
              text: 'Componentes',
              index: 1,
              onTap: () {
                setState(() {
                  _selectedIndex = 1;
                });
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ComponentesPage(
                    accessToken: widget.accessToken,
                  ),
                ));
              },
            ),
            _createDrawerItem(
              icon: Icons.business,
              text: 'Materiais',
              index: 2,
              onTap: () {
                setState(() {
                  _selectedIndex = 2;
                });
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => MateriaisPage(
                    accessToken: widget.accessToken,
                  ),
                ));
              },
            ),
            _createDrawerItem(
              icon: Icons.laptop,
              text: 'Notebooks',
              index: 3,
              onTap: () {
                setState(() {
                  _selectedIndex = 3;
                });
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => NotebookPage(
                    accessToken: widget.accessToken,
                  ),
                ));
              },
            ),
            _createDrawerItem(
              icon: Icons.cable,
              text: 'Cabos',
              index: 4,
              onTap: () {
                setState(() {
                  _selectedIndex = 4;
                });
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => CabosPage(
                    accessToken: widget.accessToken,
                  ),
                ));
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _createDrawerItem({
    required IconData icon,
    required String text,
    required int index,
    GestureTapCallback? onTap,
  }) {
    Color indicatorColor =
        index == _selectedIndex ? Color(0xFFF98D07) : Color(0xFFC7C7C7);

    return ListTile(
      leading: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: indicatorColor,
        ),
      ),
      title: Row(
        children: <Widget>[
          Icon(icon, color: Colors.white),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(
              text,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      onTap: onTap,
    );
  }
}
