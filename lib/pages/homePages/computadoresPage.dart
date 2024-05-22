import 'package:flutter/material.dart';
import 'package:estoque_app/widgets/crud_container.dart';
import 'package:estoque_app/widgets/sidebar_component.dart';

class ComputadoresPage extends StatefulWidget {
  final String accessToken;

  const ComputadoresPage({Key? key, required this.accessToken})
      : super(key: key);

  @override
  State<ComputadoresPage> createState() => _ComputadoresPageState();
}

class _ComputadoresPageState extends State<ComputadoresPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: AppBar(
          backgroundColor: Color(0xFF086632),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          titleSpacing: 0,
          title: Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            child: Text(
              'Computadores',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                _scaffoldKey.currentState!.openEndDrawer();
              },
              icon: Icon(
                Icons.menu,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      endDrawer: SideBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 48,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                        border: Border.all(color: Color(0xFF086632)),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        children: [
                          Icon(Icons.search, color: Color(0xFF828A89)),
                          SizedBox(width: 8),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Pesquisar',
                                hintStyle: TextStyle(color: Color(0xFF828A89)),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          TextButton.icon(
                            onPressed: () {},
                            icon: Icon(Icons.filter_list,
                                color: Color(0xFF828A89)),
                            label: Text(
                              '',
                              style: TextStyle(
                                color: Color(0xFF828A89),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  VerticalDivider(
                    color: Color(0xFFBEBEBE),
                    thickness: 1.0,
                    width: 1.0,
                  ),
                  SizedBox(width: 10),
                  TextButton.icon(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      backgroundColor: Color(0xFF086632),
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    icon: Icon(Icons.add, color: Colors.white),
                    label: Text(
                      'Novo',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Column(
                children: [
                  CrudContainer(
                    title: 'computador tal',
                    code: '123456',
                    stock: 10,
                  ),
                  SizedBox(height: 20),
                  CrudContainer(
                    title: 'computador tal',
                    code: '123456',
                    stock: 10,
                  ),
                  SizedBox(height: 20),
                  CrudContainer(
                    title: 'computador tal',
                    code: '123456',
                    stock: 10,
                  ),
                  SizedBox(height: 20),
                  CrudContainer(
                    title: 'computador tal',
                    code: '123456',
                    stock: 10,
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
