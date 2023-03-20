import 'package:flutter/material.dart';
import '../firebase/database_manager.dart';
import '../models/loja.dart';

class LojaPage extends StatefulWidget {
  const LojaPage({Key? key, required this.data}) : super(key: key);

  final Loja data;

  @override
  State<LojaPage> createState() => _LojaPageState(data);
}

class _LojaPageState extends State<LojaPage> {
  _LojaPageState(Loja loj) {
    this.idPotencia = loj.idPotencia!;
    this.idLoja = loj.id!;
    this.nomeLoja = loj.nome!;
    this.numeroLoja = loj.numero!;
    this.logoLoja = loj.logo!;
  }

  String idPotencia = '';
  String idLoja = '';
  String nomeLoja = '';
  String numeroLoja = '';
  String logoLoja = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.red,
        elevation: 4.0,
        title: const Text(
          'LOJA',
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.white12,
                    child: FutureBuilder(
                      future: FireStoreDataBase(logoLoja).getData(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return const Text(
                            "Algo estava errado",
                          );
                        }
                        if (snapshot.connectionState == ConnectionState.done) {
                          return Image.network(
                            snapshot.data.toString(),
                          );
                        }
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    ),
                  ),
                  title: GetLojaNome(idPotencia, idLoja),
                  subtitle: GetLoja(idPotencia, idLoja),
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
