import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../firebase/database_manager.dart';
import '../models/mandato.dart';

class IrmaoPage extends StatefulWidget {
  const IrmaoPage({Key? key, required this.data}) : super(key: key);

  final PotLojAdm data;

  @override
  State<IrmaoPage> createState() => _IrmaoPageState(data);
}

class _IrmaoPageState extends State<IrmaoPage> {
  _IrmaoPageState(PotLojAdm potLojAdm) {
    this.idPotencia = potLojAdm.idPotencia!;
    this.nomePotencia = potLojAdm.nomePotencia!;
    this.potenciaPotencia = potLojAdm.potenciaPotencia!;
    this.logoPotencia = potLojAdm.logoPotencia!;
    this.idLoja = potLojAdm.idLoja!;
    this.nomeLoja = potLojAdm.nomeLoja!;
    this.numeroLoja = potLojAdm.numeroLoja!;
    this.logoLoja = potLojAdm.logoLoja!;
    this.idIrmao = potLojAdm.idIrmao!;
    this.nomeIrmao = potLojAdm.nomeIrmao!;
    this.cimIrmao = potLojAdm.cimIrmao!;
    this.fotoIrmao = potLojAdm.fotoIrmao!;
    this.esposaIrmao = potLojAdm.esposaIrmao!;
    this.fotoespIrmao = potLojAdm.fotoespIrmao!;
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
  String nomeIrmao = '';
  String cimIrmao = '';
  String fotoIrmao = '';
  String esposaIrmao = '';
  String fotoespIrmao = '';

  final CollectionReference _potencias =
      FirebaseFirestore.instance.collection('potencias');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.red,
        elevation: 4.0,
        title: const Text(
          'IRMÃO',
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
                      .collection('irmaos')
                      .where("nome", isEqualTo: nomeIrmao)
//                      .where("cim", isEqualTo: cimIrmao)
//                      .doc(idIrmao)
                      .snapshots(),
                  builder:
                      (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                    if (streamSnapshot.hasData) {
                      return ListView.builder(
                        itemCount: streamSnapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          final DocumentSnapshot documentSnapshot =
                              streamSnapshot.data!.docs[index];
                          return Card(
                            margin: const EdgeInsets.all(10),
                            child: ListTile(
                              title: Text(documentSnapshot['nome']),
                              subtitle:
                                  Text(documentSnapshot['cim'].toString()),
                            ),
                          );
                        },
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }))
        ],
      ),
    );
  }
}
