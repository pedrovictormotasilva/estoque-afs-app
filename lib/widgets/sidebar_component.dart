import 'package:flutter/material.dart';

class SideBar extends StatefulWidget {
  const SideBar({super.key});

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
                Navigator.pushNamed(context, '/computadores');
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
                Navigator.pushNamed(context, '/componentes');
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
                Navigator.pushNamed(context, '/materiais');
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
                Navigator.pushNamed(context, '/notebooks');
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
                Navigator.pushNamed(context, '/cabos');
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
