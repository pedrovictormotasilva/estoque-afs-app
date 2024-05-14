import 'package:flutter/material.dart';
import 'package:estoque_app/widgets/container_homepage.dart';
import 'package:estoque_app/routes/homePage.dart';

class HomePage extends StatefulWidget {


  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}



class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: RoutesHomePage.routes,
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70.0),
          child: AppBar(
            backgroundColor: Color(0xFF086632),
            title: Padding(
              padding: EdgeInsets.only(top: 9),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Color(0xFFAFAFAF),
                    child: Icon(Icons.person, color: Colors.black),
                  ),
                  SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 4),
                        child: Text(
                          'Bem-vindo,',
                          style: TextStyle(fontSize: 14, color: Color(0xFFCECECE)),
                        ),
                      ),

                        Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: Text('Nome',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                        )
                    ],
                  ),


                ],
              ),
            ),
            actions: [
              Padding(
                padding: EdgeInsets.only(top: 10, right: 16),
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.menu, color: Color(0xFFE6E6E6)),
                ),
              ),
            ],
          ),
        ),
        body: Container(
          color: Color(0xFFE9E9E9),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 35, top: 30),
                child: Text(
                  'Visão Geral',
                  style: TextStyle(fontSize: 17, color: Color(0xFF054823)),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    ContainerHomePage(
                      text: 'Computadores',
                      icon: Icons.desktop_mac_outlined,
                      quantity: 10,
                      routeName: '/computadores',
                    ),
                    SizedBox(height: 10),
                    ContainerHomePage(
                      text: 'Componentes',
                      icon: Icons.developer_board,
                      quantity: 5,
                      routeName: '/componentes',
                    ),
                    SizedBox(height: 10),
                    ContainerHomePage(
                      text: 'Materiais',
                      icon: Icons.build,
                      quantity: 15,
                      routeName: '/materiais',
                    ),
                    SizedBox(height: 10),
                    ContainerHomePage(
                      text: 'Notebooks',
                      icon: Icons.laptop,
                      quantity: 8,
                      routeName: '/notebooks',
                    ),
                    SizedBox(height: 10),
                    ContainerHomePage(
                      text: 'Cabos',
                      icon: Icons.usb,
                      quantity: 20,
                      routeName: '/cabos',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
