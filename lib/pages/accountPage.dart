import 'package:estoque_app/pages/homePage.dart';

import 'package:flutter/material.dart';

class AccountPage extends StatefulWidget {
  const AccountPage(
      {Key? key,
      required this.accessToken,
      required this.userName,
      required this.userEmail})
      : super(key: key);
  final String accessToken;
  final String userName;
  final String userEmail;

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  bool _obscureText = true;
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () =>
              Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => HomePage(
              accessToken: widget.accessToken,
              userEmail: widget.userEmail,
              

            ),
          )),
        ),
        title: Text(
          'Perfil',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.menu, color: Colors.white),
            onPressed: () {
              _scaffoldKey.currentState!.openDrawer();
            },
          ),

        ],

        backgroundColor: Color(0xFF086632),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Stack(
              alignment: Alignment.center,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Color(0xFF086632),
                  child: CircleAvatar(
                    radius: 48,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      size: 50,
                      color: Color(0xFF8B8B8B),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () {
                      // Função para trocar ou fazer upload de imagem
                      print('Trocar imagem');
                    },
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Color(0xFF086632),
                        shape: BoxShape.circle,
                      ),
                      child:
                          Icon(Icons.camera_alt, color: Colors.white, size: 20),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                widget.userName,
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2B4537)),
              ),
            ),
            Center(
              child: Text(
                widget.userEmail,
                style: TextStyle(color: Color(0xFF828A89)),
              ),
            ),
            SizedBox(height: 20),
            buildPasswordField('Senha Atual', currentPasswordController,
                Color(0xFF232323), Color(0xFF8C8C8C)),
            SizedBox(height: 20),
            buildPasswordField('Nova Senha', newPasswordController,
                Color(0xFF232323), Color(0xFF8C8C8C)),
            SizedBox(height: 10),
            buildButton('Mudar Senha', Color(0xFF086632), Colors.white, () {
              // Lógica para mudar a senha
              print('Mudar senha');
            }),
            Spacer(),
            buildButton('Sair', Colors.transparent, Color(0xFFFF6F6F), () {
              // Lógica para sair
              print('Sair');
            }, leadingIcon: Icon(Icons.logout, color: Color(0xFFFF6F6F))),
          ],
        ),
      ),
    );
  }

  Widget buildPasswordField(String title, TextEditingController controller,
      Color titleColor, Color hintColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(color: titleColor, fontSize: 16),
        ),
        SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Color(0xFF086632), width: 1),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: TextField(
              controller: controller,
              obscureText: _obscureText,
              decoration: InputDecoration(
                hintText: 'Digite sua $title',
                hintStyle: TextStyle(color: hintColor),
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildButton(String title, Color backgroundColor, Color textColor,
      VoidCallback onPressed,
      {Widget? leadingIcon}) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: leadingIcon ?? Container(),
      label: Text(title, style: TextStyle(color: textColor)),
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
