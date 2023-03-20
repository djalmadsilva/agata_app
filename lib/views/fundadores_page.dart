import 'package:flutter/material.dart';
import '../firebase/database_manager.dart';
import '../models/mandato.dart';

class FundadoresPage extends StatefulWidget {
  const FundadoresPage({Key? key, required this.data}) : super(key: key);

  final PotLojAdm data;

  @override
  State<FundadoresPage> createState() => _FundadoresPageState(data);
}

class _FundadoresPageState extends State<FundadoresPage> {
  _FundadoresPageState(PotLojAdm potLoj) {
    this.idPotencia = potLoj.idPotencia!;
    this.nomePotencia = potLoj.nomePotencia!;
    this.potenciaPotencia = potLoj.potenciaPotencia!;
    this.logoPotencia = potLoj.logoPotencia!;
    this.idLoja = potLoj.idLoja!;
    this.nomeLoja = potLoj.nomeLoja!;
    this.numeroLoja = potLoj.numeroLoja!;
    this.logoLoja = potLoj.logoLoja!;
  }

  String idPotencia = '';
  String nomePotencia = '';
  String potenciaPotencia = '';
  String logoPotencia = '';
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
          'FUNDADORES',
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
                      future: FireStoreDataBase(logoPotencia).getData(),
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
                  title: Text(nomePotencia),
                  subtitle: Text(potenciaPotencia.toString()),
                  onTap: () {},
                ),
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
                  title: Text(nomeLoja),
                  subtitle: Text(numeroLoja.toString()),
                  onTap: () {},
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              //shrinkWrap: true,
              padding: const EdgeInsets.all(8),
              children: <Widget>[
                Container(
                  height: 40,
                  color: Colors.amber[600],
                  child: const Center(child: Text('Abrão Selem Neto, M∴M∴')),
                ),
                Container(
                  height: 40,
                  color: Colors.amber[300],
                  child: const Center(
                      child: Text('Atílio Maximino Fernandes, M∴I∴')),
                ),
                Container(
                  height: 40,
                  color: Colors.amber[600],
                  child: const Center(
                      child: Text('Claiton Roberto de Aguiar, M∴M∴')),
                ),
                Container(
                  height: 40,
                  color: Colors.amber[300],
                  child: const Center(
                      child: Text('Claudio Antonio Stefani Junior, M∴M∴')),
                ),
                Container(
                  height: 40,
                  color: Colors.amber[600],
                  child: const Center(
                      child: Text('Daher Nassib Daher Junior, M∴I∴')),
                ),
                Container(
                  height: 40,
                  color: Colors.amber[300],
                  child: const Center(child: Text('Edmo Gabriel, M∴I∴')),
                ),
                Container(
                  height: 40,
                  color: Colors.amber[600],
                  child:
                      const Center(child: Text('Ednir Aparecido Vieira, M∴M∴')),
                ),
                Container(
                  height: 40,
                  color: Colors.amber[300],
                  child: const Center(
                      child: Text('Eumar Silva Albuquerque, M∴I∴')),
                ),
                Container(
                  height: 40,
                  color: Colors.amber[600],
                  child:
                      const Center(child: Text('Jamil Pedrozo Nassif, M∴M∴')),
                ),
                Container(
                  height: 40,
                  color: Colors.amber[300],
                  child: const Center(child: Text('Luis Roberto Thiesi, M∴I∴')),
                ),
                Container(
                  height: 40,
                  color: Colors.amber[600],
                  child: const Center(
                      child: Text('Marcílio Ivan dos Santos, M∴M∴')),
                ),
                Container(
                  height: 40,
                  color: Colors.amber[300],
                  child: const Center(child: Text('Maurício Scarpassa, M∴I∴')),
                ),
                Container(
                  height: 40,
                  color: Colors.amber[600],
                  child: const Center(child: Text('Maurício Bellodi, M∴M∴')),
                ),
                Container(
                  height: 40,
                  color: Colors.amber[300],
                  child:
                      const Center(child: Text('Milton Roberto Zanatel, M∴M∴')),
                ),
                Container(
                  height: 40,
                  color: Colors.amber[600],
                  child:
                      const Center(child: Text('Nelson Silvestre Pappa, M∴I∴')),
                ),
                Container(
                  height: 40,
                  color: Colors.amber[300],
                  child:
                      const Center(child: Text('Nicanor Batista Junior, M∴I∴')),
                ),
                Container(
                  height: 40,
                  color: Colors.amber[600],
                  child: const Center(child: Text('Odival Abrão Jana, M∴I∴')),
                ),
                Container(
                  height: 40,
                  color: Colors.amber[300],
                  child: const Center(
                      child: Text('Renato Luis Pereira Brito, M∴M∴')),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
