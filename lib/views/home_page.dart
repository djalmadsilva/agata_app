import 'package:agata_app/views/checagem_page.dart';
import 'package:agata_app/views/corposfilosoficos_page.dart';
import 'package:agata_app/views/fundadores_page.dart';
import 'package:agata_app/views/paramaconicas_page.dart';
import 'package:agata_app/views/potencias_page.dart';
import 'package:agata_app/views/irmaos_page.dart';
import 'package:agata_app/views/sobre_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'administracoes_page.dart';
import 'aniversariantes_page.dart';
import 'cunhadas_page.dart';
import '../models/login.dart';
import '../models/mandato.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.data}) : super(key: key);

  final Login data;

  @override
  State<HomePage> createState() => _HomePageState(data);
}

class _HomePageState extends State<HomePage> {
  _HomePageState(Login login) {
    this.emailLogin = login.emailLogin!;
  }

  String emailLogin = '';

  final _firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.red,
        elevation: 4.0,
        title: const Text(
          'A∴R∴L∴S∴ ÁGATA RIOPRETENSE',
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: CustomScrollView(
        primary: false,
        slivers: <Widget>[
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverGrid.count(
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 2,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.red[100],
                  child: ElevatedButton.icon(
                    onPressed: () {
                      PotLojAdm potLojAdm = PotLojAdm();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                FundadoresPage(data: potLojAdm)),
                      );
                    },
                    icon: Icon(
                      Icons.exit_to_app,
                      size: 24.0,
                      color: Colors.black,
                    ),
                    label: Text(
                      'FUNDADORES',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.red[100],
                  child: ElevatedButton.icon(
                    onPressed: () {
                      PotLojAdm potLojAdm = PotLojAdm();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                AdministracoesPage(data: potLojAdm)),
                      );
                    },
                    icon: Icon(
                      Icons.exit_to_app,
                      size: 24.0,
                      color: Colors.black,
                    ),
                    label: Text(
                      'MANDATOS',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.red[200],
                  child: ElevatedButton.icon(
                    onPressed: () {
                      PotLojAdm potLojAdm = PotLojAdm();
                      potLojAdm.emailLogin = emailLogin;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => IrmaosPage(data: potLojAdm)),
                      );
                    },
                    icon: Icon(
                      Icons.exit_to_app,
                      size: 24.0,
                      color: Colors.black,
                    ),
                    label: Text(
                      'IRMÃOS DO QUADRO',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.red[200],
                  child: ElevatedButton.icon(
                    onPressed: () {
                      PotLojAdm potLojAdm = PotLojAdm();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                CunhadasPage(data: potLojAdm)),
                      );
                    },
                    icon: Icon(
                      Icons.exit_to_app,
                      size: 24.0,
                      color: Colors.black,
                    ),
                    label: Text(
                      'CLUBE DAS ACÁCIAS',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.red[300],
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PotenciasPage()),
                      );
                    },
                    icon: Icon(
                      Icons.exit_to_app,
                      size: 24.0,
                      color: Colors.black,
                    ),
                    label: Text(
                      'POTÊNCIAS E LOJAS',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.red[300],
                  child: ElevatedButton.icon(
                    onPressed: () {
                      PotLojAdm potLojAdm = PotLojAdm();
                      potLojAdm.emailLogin = emailLogin;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                AniversariantesPage(data: potLojAdm)),
                      );
                    },
                    icon: Icon(
                      Icons.exit_to_app,
                      size: 24.0,
                      color: Colors.black,
                    ),
                    label: Text(
                      'ANIVER-SARIANTES',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.red[400],
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ParamaconicasPage()),
                      );
                    },
                    icon: Icon(
                      Icons.exit_to_app,
                      size: 24.0,
                      color: Colors.black,
                    ),
                    label: Text(
                      'PARA-MAÇÔNICAS',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.red[400],
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CorposFilosoficosPage()),
                      );
                    },
                    icon: Icon(
                      Icons.exit_to_app,
                      size: 24.0,
                      color: Colors.black,
                    ),
                    label: Text(
                      'CORPOS FILOSÓFICOS',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.red[500],
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SobrePage()),
                      );
                    },
                    icon: Icon(
                      Icons.exit_to_app,
                      size: 24.0,
                      color: Colors.black,
                    ),
                    label: Text(
                      'SOBRE',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.red[500],
                  child: ElevatedButton.icon(
                    onPressed: () {
                      sair();
                    },
                    icon: Icon(
                      Icons.exit_to_app,
                      size: 24.0,
                      color: Colors.black,
                    ),
                    label: Text(
                      'SAIR',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  sair() async {
    await _firebaseAuth.signOut().then(
          (user) => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ChecagemPage(),
            ),
          ),
        );
  }
}
