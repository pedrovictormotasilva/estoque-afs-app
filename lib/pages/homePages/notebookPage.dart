import 'dart:convert';
import 'package:estoque_app/pages/homePage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:estoque_app/utils/crud_util.dart';
import 'package:estoque_app/widgets/addProductModal.dart';
import 'package:estoque_app/widgets/crud_container.dart';
import 'package:estoque_app/widgets/sidebar_component.dart';

class NotebookPage extends StatefulWidget {
  final String accessToken;
  final String userEmail;

  const NotebookPage(
      {Key? key, required this.accessToken, required this.userEmail})
      : super(key: key);

  @override
  State<NotebookPage> createState() => _NotebookPageState();
}

class _NotebookPageState extends State<NotebookPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late Future<Map<String, dynamic>> _products;
  bool _isLoading = true;
  String _searchQuery = '';
  List<dynamic> _filteredProducts = [];

  @override
  void initState() {
    super.initState();
    _loadProducts();
    print('Token na página NotebookPage: "${widget.accessToken}"');
  }

  Future<void> _loadProducts() async {
    try {
      final products =
          await ProductApiService.getProducts(widget.accessToken, 4);
      setState(() {
        _products = Future.value(products);
        _filteredProducts = products['Company'];
      });
    } catch (error) {
      print('Falha ao carregar produtos: $error');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _filterProducts(String query) async {
    try {
      final products = await _products;
      setState(() {
        _searchQuery = query;
        _filteredProducts = products['Company'].where((product) {
          final productName = product['nome'].toString().toLowerCase();
          final input = query.toLowerCase();
          return productName.contains(input);
        }).toList();
      });
    } catch (error) {
      print('Erro ao filtrar produtos: $error');
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
              'Notebooks',
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
                              onChanged: (value) {
                                _filterProducts(value);
                              },
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
                            categoryId: 4, // Aqui o categoryId é 4
                          );
                        },
                      );

                      if (result == true) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NotebookPage(
                              accessToken: widget.accessToken,
                              userEmail: widget.userEmail,
                            ),
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
    return _isLoading
        ? CircularProgressIndicator()
        : _filteredProducts.isEmpty
            ? Center(
                child: Text('Nenhum produto encontrado.'),
              )
            : Column(
                children: _filteredProducts.map<Widget>((product) {
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
                        _filteredProducts.removeWhere((p) => p == product);
                      });
                      ProductApiService.deleteProduct(
                          widget.accessToken, productId);
                    },
                  );
                }).toList(),
              );
  }
}
