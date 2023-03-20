import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../firebase/database_manager.dart';
import 'loja_page.dart';
import '../models/loja.dart';
import '../models/potencia.dart';

class LojasPage extends StatefulWidget {
  const LojasPage({Key? key, required this.data}) : super(key: key);

  final Potencia data;

  @override
  State<LojasPage> createState() => _LojasPageState(data);
}

class _LojasPageState extends State<LojasPage> {
  _LojasPageState(Potencia pot) {
    this.idPotencia = pot.id!;
    this.nomePotencia = pot.nome!;
    this.potenciaPotencia = pot.potencia!;
    this.logoPotencia = pot.logo!;
  }

  String idPotencia = '';
  String nomePotencia = '';
  String potenciaPotencia = '';
  String logoPotencia = '';

  final _lojas = FirebaseFirestore.instance.collection('potencias');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.red,
        elevation: 4.0,
        title: const Text(
          'LOJAS',
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
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: _lojas
                  .doc(idPotencia)
                  .collection('lojas')
                  .orderBy('nome', descending: false)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                if (streamSnapshot.hasData) {
                  return ListView.builder(
                    itemCount: streamSnapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final DocumentSnapshot documentSnapshot =
                          streamSnapshot.data!.docs[index];
                      return Card(
                        margin: const EdgeInsets.all(10),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.white12,
                            child: FutureBuilder(
                              future:
                                  FireStoreDataBase(documentSnapshot["logo"])
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
                          title: Text(documentSnapshot['nome']),
                          subtitle: Text(documentSnapshot['numero'].toString()),
                          onTap: () {
                            Loja loj = Loja(
                                idPotencia,
                                documentSnapshot.id,
                                documentSnapshot['nome'],
                                documentSnapshot['numero'].toString(),
                                documentSnapshot['logo']);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LojaPage(data: loj)));
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
