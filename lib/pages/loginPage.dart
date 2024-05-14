import 'package:flutter/material.dart';
import 'package:estoque_app/pages/homePage.dart';
import 'package:estoque_app/pages/welcomePage.dart';
import 'package:estoque_app/routes/login_route.dart';
import 'package:estoque_app/validations/login_validator.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscurePassword = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String? emailError;
  String? passwordError;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 90),
                    Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Faça login para continuar',
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(0xFF364F41),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 100),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color(0xFFECECEC),
                      ),
                      child: TextField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(color: Color(0xFF7B7B7B)),
                          border: InputBorder.none,
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                          errorText: emailError,
                        ),
                        onChanged: (value) {
                          setState(() {
                            emailError = Validation.validateEmail(value);
                          });
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color(0xFFECECEC),
                      ),
                      child: TextField(
                        controller: passwordController,
                        obscureText: _obscurePassword,
                        decoration: InputDecoration(
                          labelText: 'Senha',
                          labelStyle: TextStyle(color: Color(0xFF7B7B7B)),
                          border: InputBorder.none,
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                          ),
                          errorText: passwordError,
                        ),
                        onChanged: (value) {
                          setState(() {
                            passwordError = Validation.validatePassword(value);
                          });
                        },
                      ),
                    ),
                    SizedBox(height: 90),
                    ElevatedButton(
                      onPressed: _isLoading
                          ? null
                          : () async {
                              if (emailError == null && passwordError == null) {
                                _login();
                              }
                            },
                      child: Container(
                        width: 140,
                        height: 55,
                        alignment: Alignment.center,
                        child: _isLoading
                            ? CircularProgressIndicator()
                            : Text(
                                'Entrar',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            _isLoading ? Colors.grey : Color(0xFF1B7744)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: 10,
                  left: 10,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => WelcomePage(),
                        ),
                      );
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Color(0xFF1B7744),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _login() async {
    setState(() {
      _isLoading = true;
    });

    final email = emailController.text;
    final password = passwordController.text;

    final result = await AuthService.login(email, password);

    setState(() {
      _isLoading = false;
    });

    if (result['success']) {
      if (result.containsKey('accessToken')) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => HomePage(),
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Erro ao fazer login. Resposta inválida da API."),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result['errorMessage']),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
