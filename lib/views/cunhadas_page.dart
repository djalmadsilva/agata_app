import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../firebase/database_manager.dart';
import '../models/mandato.dart';

class CunhadasPage extends StatefulWidget {
  const CunhadasPage({Key? key, required this.data}) : super(key: key);

  final PotLojAdm data;

  @override
  State<CunhadasPage> createState() => _CunhadasPageState(data);
}

class _CunhadasPageState extends State<CunhadasPage> {
  _CunhadasPageState(PotLojAdm potLoj) {
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

  final _lojas = FirebaseFirestore.instance.collection('potencias');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.red,
        elevation: 4.0,
        title: const Text(
          'CLUBE DAS ACÁCIAS',
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
                /*ListTile(
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
                ),*/
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: _lojas
                  .doc(idPotencia)
                  .collection('lojas')
                  .doc(idLoja)
                  .collection('irmaos')
                  .where('situacao', isEqualTo: 'ativo')
                  .orderBy('esposa', descending: false)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                if (streamSnapshot.hasData) {
                  return ListView.builder(
                    itemCount: streamSnapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final DocumentSnapshot documentSnapshot =
                          streamSnapshot.data!.docs[index];

                      String _nome = documentSnapshot["nome"];
                      String _aniversarioesp =
                          documentSnapshot["aniversarioesp"];

                      String _niveresp;
                      int tamanho = _aniversarioesp.length;
                      if (tamanho >= 5) {
                        _niveresp = _aniversarioesp.substring(0, 5); // '29-07'
                      } else {
                        _niveresp = '';
                      }

                      return Card(
                        margin: const EdgeInsets.all(10),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.white12,
                            child: FutureBuilder(
                              future:
                                  FireStoreDataBase(documentSnapshot["fotoesp"])
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
                          title: Text(documentSnapshot['esposa']),
                          subtitle:
                              Text('Aniversário em: $_niveresp\nIrmão: $_nome'),
                          onTap: () {
                            /*Loja loj = Loja(
                                documentSnapshot.id,
                                documentSnapshot['nome'],
                                documentSnapshot['numero'].toString(),
                                documentSnapshot['logo']);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LojaPage(data: loj)));*/
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
          ),
        ],
      ),
    );
  }
}
