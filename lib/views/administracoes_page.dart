import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'administracao_page.dart';
import '../firebase/database_manager.dart';
import '../models/irmao.dart';
import '../models/mandato.dart';

class AdministracoesPage extends StatefulWidget {
  const AdministracoesPage({Key? key, required this.data}) : super(key: key);

  final PotLojAdm data;

  @override
  State<AdministracoesPage> createState() => _AdministracoesPageState(data);
}

class _AdministracoesPageState extends State<AdministracoesPage> {
  _AdministracoesPageState(PotLojAdm potLojAdm) {
    this.idPotencia = potLojAdm.idPotencia!;
    this.nomePotencia = potLojAdm.nomePotencia!;
    this.potenciaPotencia = potLojAdm.potenciaPotencia!;
    this.logoPotencia = potLojAdm.logoPotencia!;
    this.idLoja = potLojAdm.idLoja!;
    this.nomeLoja = potLojAdm.nomeLoja!;
    this.numeroLoja = potLojAdm.numeroLoja!;
    this.logoLoja = potLojAdm.logoLoja!;
  }

  String idPotencia = '';
  String nomePotencia = '';
  String potenciaPotencia = '';
  String logoPotencia = '';
  String idLoja = '';
  String nomeLoja = '';
  String numeroLoja = '';
  String logoLoja = '';
  String idIrmao = '';
  int irmaoLoja = 0;

  final _potencias = FirebaseFirestore.instance.collection('potencias');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.red,
        elevation: 4.0,
        title: const Text(
          'MANDATOS',
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: Column(
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
          Expanded(
            child: StreamBuilder(
              stream: _potencias
                  .doc(idPotencia)
                  .collection('lojas')
                  .doc(idLoja)
                  .collection('mandatos')
                  .orderBy('dataini', descending: true)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                if (streamSnapshot.hasData) {
                  return ListView.builder(
                    itemCount: streamSnapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final DocumentSnapshot documentSnapshot =
                          streamSnapshot.data!.docs[index];

                      String mandato = documentSnapshot['dataini'].toString();
                      mandato += '-';
                      mandato += documentSnapshot['datater'].toString();

                      /*String foto = GetIrmaoFoto(
                          idPotencia, idLoja, documentSnapshot['vm']).toString();*/

//                    String foto = '/files/irmaos/macom.png';

//                      print('Foto: $foto');

                      return Card(
                        margin: const EdgeInsets.all(10),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.white12,
                            child: FutureBuilder(
                              future:
                                  FireStoreDataBase(documentSnapshot['fotovm'])
                                      .getData(),
                              builder: (context, snapshot) {
                                if (snapshot.hasError) {
                                  return const Text(
                                    "Algo estava errado",
                                  );
                                }
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
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
                          title: Text(mandato),
                          subtitle: GetIrmaoNome(
                              idPotencia, idLoja, documentSnapshot['vm']),
                          onTap: () {
                            Mandato mandato = Mandato();
                            mandato.idPotencia = idPotencia;
                            mandato.nomePotencia = nomePotencia;
                            mandato.potenciaPotencia = potenciaPotencia;
                            mandato.logoPotencia = logoPotencia;
                            mandato.idLoja = idLoja;
                            mandato.nomeLoja = nomeLoja;
                            mandato.numeroLoja = numeroLoja;
                            mandato.logoLoja = logoLoja;
                            mandato.idMandato = documentSnapshot.id;
                            mandato.dataIni =
                                documentSnapshot['dataini'].toString();
                            mandato.dataTer =
                                documentSnapshot['datater'].toString();

//                            debugPrint('Potência: $mandato.idPotencia.toString()');

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        AdministracaoPage(data: mandato)));
                          },
                        ),
                      );
                    },
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
