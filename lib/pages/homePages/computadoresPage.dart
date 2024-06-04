import 'dart:convert';
import 'package:estoque_app/pages/homePage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:estoque_app/utils/crud_util.dart';
import 'package:estoque_app/widgets/addProductModal.dart';
import 'package:estoque_app/widgets/crud_container.dart';
import 'package:estoque_app/widgets/sidebar_component.dart';

class ComputadoresPage extends StatefulWidget {
  final String accessToken;
  final String userEmail;
  const ComputadoresPage({Key? key, required this.accessToken, required this.userEmail})
      : super(key: key);

  @override
  State<ComputadoresPage> createState() => _ComputadoresPageState();
}

class _ComputadoresPageState extends State<ComputadoresPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late Future<Map<String, dynamic>> _products;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProducts();
    print('Token na página ComputadoresPage: "${widget.accessToken}"');
  }

  Future<void> _loadProducts() async {
    try {
      _products = ProductApiService.getProducts(widget.accessToken, 1);
      await _products;
    } catch (error) {
      print('Falha ao carregar produtos: $error');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

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
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => HomePage(
                  accessToken: widget.accessToken,
                  userEmail: widget.userEmail,
                ),
              ));
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
      endDrawer: SideBar(
        accessToken: widget.accessToken,
        userEmail: widget.userEmail,
      ),
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
                          ),
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
                    onPressed: () async {
                      final result = await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AddProductModal(
                              accessToken: widget.accessToken,
                          categoryId: 1,);

                        },
                      );

                      if (result == true) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ComputadoresPage(
                                accessToken: widget.accessToken,
                            userEmail: widget.userEmail,),
                          ),
                        );
                      }
                    },
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
              _isLoading ? CircularProgressIndicator() : _buildProductList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductList() {
    return FutureBuilder<Map<String, dynamic>>(
      future: _products,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Erro: ${snapshot.error}');
        } else {
          final products = snapshot.data?['Company'] ?? [];

          if (products.isEmpty) {
            return Center(
              child: Text('Nenhum produto encontrado.'),
            );
          }

          return Column(
            children: products.map<Widget>((product) {
              final productName = product['nome'] ?? '';
              final productCode = (product['id_item'] != null)
                  ? product['id_item'].toString()
                  : '0';
              final productStock =
                  (product['estoque'] != null) ? product['estoque'] : 0;
              final productId =
                  (product['id_item'] != null) ? product['id_item'] : 0;

              return CrudContainer(
                title: productName,
                code: productCode,
                stock: productStock,
                accessToken: widget.accessToken,
                productId: productId,
                onDelete: () {
                  setState(() {
                    _products =
                        ProductApiService.getProducts(widget.accessToken, 1);
                  });
                },
              );
            }).toList(),
          );
        }
      },
    );
  }
}
