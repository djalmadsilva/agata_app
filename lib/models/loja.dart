import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetLojaNome extends StatelessWidget {
  final String idPotencia;
  final String idLoja;

  GetLojaNome(this.idPotencia, this.idLoja);

  @override
  Widget build(BuildContext context) {
    CollectionReference lojas = FirebaseFirestore.instance
        .collection('potencias')
        .doc(idPotencia)
        .collection('lojas');

    return FutureBuilder<DocumentSnapshot>(
      future: lojas.doc(idLoja).get(),
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
          return Text("${data['nome']} - Nº ${data['numero']}");
        }

        return Text("loading");
      },
    );
  }
}

class GetLoja extends StatelessWidget {
  final String idPotencia;
  final String idLoja;

  GetLoja(this.idPotencia, this.idLoja);

  @override
  Widget build(BuildContext context) {
    CollectionReference lojas = FirebaseFirestore.instance
        .collection('potencias')
        .doc(idPotencia)
        .collection('lojas');

    return FutureBuilder<DocumentSnapshot>(
      future: lojas.doc(idLoja).get(),
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
              "CEP ${data['cep']}, Caixa Postal ${data['cxpostal']}\n"
              "telefone ${data['telefone']}\n"
              "e-mail ${data['email']}\n"
              "site ${data['site']}\n"
              "rede social ${data['redesocial']}\n"
              "Reuniões às ${data['reuniao']}, Periodicidade ${data['periodicidade']}\n"
              "Rito ${data['rito']}");
        }

        return Text("loading");
      },
    );
  }
}

class Loja {
  String? idPotencia;
  String? id;
  String? nome;
  String? numero;
  String? logo;

  Loja(idPotencia, id, nome, numero, logo) {
    this.idPotencia = idPotencia;
    this.id = id;
    this.nome = nome;
    this.numero = numero;
    this.logo = logo;
  }
}
