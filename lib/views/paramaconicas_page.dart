import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../firebase/database_manager.dart';

class ParamaconicasPage extends StatefulWidget {
  const ParamaconicasPage({Key? key}) : super(key: key);

  @override
  State<ParamaconicasPage> createState() => _ParamaconicasPageState();
}

class _ParamaconicasPageState extends State<ParamaconicasPage> {
  final CollectionReference _paramaconicas =
      FirebaseFirestore.instance.collection('paramaconicas');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.red,
        elevation: 4.0,
        title: const Text(
          'PARAMACÔNICAS',
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: StreamBuilder(
        stream: _paramaconicas.orderBy('nome', descending: false).snapshots(),
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
                        future: FireStoreDataBase(documentSnapshot["logo"])
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
                    onTap: () {
                      /*Potencia pot = Potencia(
                          documentSnapshot.id,
                          documentSnapshot['nome'],
                          documentSnapshot['potencia'].toString(),
                          documentSnapshot['logo']);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  LojasPage(data: pot)));*/
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
    );
  }
}
