import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'cadastro_page.dart';
import 'home_page.dart';
import '../models/login.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.red,
        elevation: 4.0,
        title:  const Text('Página de Login'),
      ),
      body: ListView(
        padding: EdgeInsets.all(12),
        children: [
          Image.asset(
            'assets/images/logo-agata.jpeg',
            alignment: Alignment.center,
          ),
          const Text(
            'A∴R∴L∴S∴ ÁGATA RIOPRETENSE nº 346',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),
          const Text(
            'Or∴ São José do Rio Preto-SP\nFundada em 30/03/2011',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.normal,
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(
              label: Text('e-mail'),
            ),
          ),
          TextFormField(
            controller: _passwordController,
            decoration: InputDecoration(
              label: Text('senha'),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              login();
            },
            child: Text('Entrar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CadastroPage(),
                ),
              );
            },
            child: Text('Criar Conta'),
          ),
        ],
      ),
    );
  }

  login() async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
              email: _emailController.text, password: _passwordController.text);
      if (userCredential != null) {
        Login login = Login();
        login.emailLogin = _emailController.text;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(data: login),
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Usuário não encontrado'),
            backgroundColor: Colors.redAccent,
          ),
        );
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Sua senha está errada'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    }
  }
}

