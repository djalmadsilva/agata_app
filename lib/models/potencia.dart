import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetPotenciaNome extends StatelessWidget {
  final String idPotencia;

  GetPotenciaNome(this.idPotencia);

  @override
  Widget build(BuildContext context) {
    CollectionReference potencias =
        FirebaseFirestore.instance.collection('potencias');

    return FutureBuilder<DocumentSnapshot>(
      future: potencias.doc(idPotencia).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Text("${data['nome']} - ${data['potencia']}");
        }

        return Text("loading");
      },
    );
  }
}

class GetPotencia extends StatelessWidget {
  final String idPotencia;

  GetPotencia(this.idPotencia);

  @override
  Widget build(BuildContext context) {
    CollectionReference potencias =
    FirebaseFirestore.instance.collection('potencias');

    return FutureBuilder<DocumentSnapshot>(
      future: potencias.doc(idPotencia).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
          snapshot.data!.data() as Map<String, dynamic>;
          return Text("Fundada em ${data['fundacao']}\n"
              "${data['endereco']}, ${data['oriente']}\n"
              "CEP ${data['cep']}\n"
              "telefone ${data['telefone']}\n"
              "e-mail ${data['email']}\n"
              "site ${data['site']}\n"
              "rede social ${data['redesocial']}");
        }

        return Text("loading");
      },
    );
  }
}

class Potencia {
  String? id;
  String? nome;
  String? potencia;
  String? logo;

  Potencia(id, nome, potencia, logo) {
    this.id = id;
    this.nome = nome;
    this.potencia = potencia;
    this.logo = logo;
  }
}
