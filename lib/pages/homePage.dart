import 'package:flutter/material.dart';
import 'package:estoque_app/pages/accountPage.dart';
import 'package:estoque_app/pages/homePages/cabosPage.dart';
import 'package:estoque_app/pages/homePages/componentesPage.dart';
import 'package:estoque_app/pages/homePages/computadoresPage.dart';
import 'package:estoque_app/pages/homePages/materiaisPage.dart';
import 'package:estoque_app/pages/homePages/notebookPage.dart';
import 'package:estoque_app/utils/getProducts_util.dart';
import 'package:estoque_app/utils/getUsers_util.dart';
import 'package:estoque_app/widgets/container_homepage.dart';
import 'package:estoque_app/widgets/sidebar_component.dart';

class HomePage extends StatefulWidget {
  final String accessToken;
  final String userEmail;

  const HomePage({Key? key, required this.accessToken, required this.userEmail})
      : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? userName;
  int? userId;
  String? errorMessage;
  Map<int, int> productCounts = {};

  @override
  void initState() {
    super.initState();
    _fetchUserName();
    _fetchProductCounts();
  }

  void _fetchUserName() async {
    try {
      final userInfo = await UserService.getUserInfo(widget.accessToken);
      setState(() {
        if (userInfo != null) {
          userName = userInfo['nome'];
          userId = userInfo['id'];
        } else {
          errorMessage = 'Nome não encontrado na resposta da API';
        }
      });
    } catch (error) {
      print('Erro ao buscar informações do usuário: $error');
      setState(() {
        errorMessage = 'Erro ao carregar nome';
      });
    }
  }

  void _fetchProductCounts() async {
    try {
      final counts = await ProductService.getProductCounts(widget.accessToken);
      setState(() {
        productCounts = counts;
      });
    } catch (error) {
      print('Erro ao buscar contagem de produtos: $error');
    }
  }

  int getCategoryCount(int categoryId) {
    return productCounts[categoryId] ?? 0;
  }

  Future<void> _navigateToPage(Widget page) async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => page),
    );
    if (result == true) {
      _fetchProductCounts();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70.0),
          child: AppBar(
            backgroundColor: Color(0xFF086632),
            title: Row(
              children: [
                SizedBox(width: 16),
                GestureDetector(
                  onTap: () {
                    if (userId != null) {
                      print('Navigating to AccountPage'); // Adicionado para depuração
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => AccountPage(
                          accessToken: widget.accessToken,
                          userName: userName ?? errorMessage ?? 'Carregando...',
                          userEmail: widget.userEmail,
                          userId: userId!,
                        ),
                      ));
                    } else {
                      print('userId is null');
                    }
                  },
                  child: CircleAvatar(
                    backgroundColor: Color(0xFFAFAFAF),
                    child: Icon(Icons.person, color: Colors.black),
                  ),
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
        endDrawer: SideBar(accessToken: widget.accessToken, userEmail: widget.userEmail,),
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
                      quantity: getCategoryCount(1),
                      onTap: () {
                        _navigateToPage(ComputadoresPage(accessToken: widget.accessToken, userEmail: widget.userEmail,));
                      },
                    ),
                    SizedBox(height: 10),
                    ContainerHomePage(
                      text: 'Componentes',
                      icon: Icons.developer_board,
                      quantity: getCategoryCount(2),
                      onTap: () {
                        _navigateToPage(ComponentesPage(accessToken: widget.accessToken, userEmail: widget.userEmail,));
                      },
                    ),
                    SizedBox(height: 10),
                    ContainerHomePage(
                      text: 'Materiais',
                      icon: Icons.build,
                      quantity: getCategoryCount(3),
                      onTap: () {
                        _navigateToPage(MateriaisPage(accessToken: widget.accessToken, userEmail: widget.userEmail,));
                      },
                    ),
                    SizedBox(height: 10),
                    ContainerHomePage(
                      text: 'Notebooks',
                      icon: Icons.laptop,
                      quantity: getCategoryCount(4),
                      onTap: () {
                        _navigateToPage(NotebookPage(accessToken: widget.accessToken, userEmail: widget.userEmail,));
                      },
                    ),
                    SizedBox(height: 10),
                    ContainerHomePage(
                      text: 'Cabos',
                      icon: Icons.usb,
                      quantity: getCategoryCount(5),
                      onTap: () {
                        _navigateToPage(CabosPage(accessToken: widget.accessToken, userEmail: widget.userEmail,));
                      },
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
