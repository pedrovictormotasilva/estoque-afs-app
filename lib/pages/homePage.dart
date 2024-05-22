import 'package:estoque_app/routes/get_users.dart';
import 'package:flutter/material.dart';
import 'package:estoque_app/widgets/sidebar_component.dart';
import 'package:estoque_app/widgets/container_homepage.dart';
import 'package:estoque_app/routes/homePage.dart';

class HomePage extends StatefulWidget {
  final String accessToken;

  const HomePage({Key? key, required this.accessToken}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? userName;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchUserName();
  }

  void _fetchUserName() async {
    try {
      final name = await UserService.getUserName(widget.accessToken);
      setState(() {
        if (name != null) {
          userName = name;
        } else {
          errorMessage = 'Nome não encontrado na resposta da API';
        }
      });
    } catch (error) {
      print('Erro ao buscar nome do usuário: $error');
      setState(() {
        errorMessage = 'Erro ao carregar nome';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: RoutesHomePage.routes,
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70.0),
          child: AppBar(
            backgroundColor: Color(0xFF086632),
            title: Row(
              children: [
                SizedBox(width: 16),
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
                        style:
                            TextStyle(fontSize: 14, color: Color(0xFFCECECE)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Text(
                        userName ?? errorMessage ?? 'Carregando...',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            iconTheme: IconThemeData(color: Colors.white),
          ),
        ),
        endDrawer: const SideBar(),
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
