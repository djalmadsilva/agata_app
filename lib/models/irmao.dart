import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetIrmaoNome extends StatelessWidget {
  final String idPotencia;
  final String idLoja;
  final String idIrmao;

  GetIrmaoNome(this.idPotencia, this.idLoja, this.idIrmao);

  @override
  Widget build(BuildContext context) {
    CollectionReference irmaos = FirebaseFirestore.instance
        .collection('potencias')
        .doc(idPotencia)
        .collection('lojas')
        .doc(idLoja)
        .collection('irmaos');

    return FutureBuilder<DocumentSnapshot>(
      future: irmaos.doc(idIrmao).get(),
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

          return Text("${data['nome']} - CIM: ${data['cim']}");
        }

        return Text("loading");
      },
    );
  }
}

class GetIrmaoFoto extends StatelessWidget {
  final String idPotencia;
  final String idLoja;
  final String idIrmao;

  GetIrmaoFoto(this.idPotencia, this.idLoja, this.idIrmao);

  @override
  Widget build(BuildContext context) {
    CollectionReference irmaos = FirebaseFirestore.instance
        .collection('potencias')
        .doc(idPotencia)
        .collection('lojas')
        .doc(idLoja)
        .collection('irmaos');

    return FutureBuilder<DocumentSnapshot>(
      future: irmaos.doc(idIrmao).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Algo estava errado");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Documento não existe");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
          snapshot.data!.data() as Map<String, dynamic>;

          /*print('Antes');
          print(data['foto']);
          print('Depois');*/

          return Text("${data['foto']}");
//          return data['foto'];
//            return '/files/irmaos/macom.png';
//            return Text(snapshot.data!['foto']);
        }

        return Text("carregando");
      },
    );
  }
}

class GetIrmao extends StatelessWidget {
  final String idPotencia;
  final String idLoja;
  final String idIrmao;

  GetIrmao(this.idPotencia, this.idLoja, this.idIrmao);

  @override
  Widget build(BuildContext context) {
    CollectionReference irmaos = FirebaseFirestore.instance
        .collection('potencias')
        .doc(idPotencia)
        .collection('lojas')
        .doc(idLoja)
        .collection('irmaos');

    return FutureBuilder<DocumentSnapshot>(
      future: irmaos.doc(idIrmao).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

        Irmao irmao = Irmao();

        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
          snapshot.data!.data() as Map<String, dynamic>;

          irmao.idPotencia = idPotencia;
          irmao.idLoja = idLoja;
          irmao.idIrmao = idIrmao;
          irmao.nomeIrmao = data['nome'];
          irmao.cimIrmao = data['cim'];
          irmao.fotoIrmao = data['foto'];

          return Text("${data['nome']} - CIM: ${data['cim']}");
        }

        return Text("loading");
      },
    );
  }
}


class Irmao {
  String? idPotencia;
  String? idLoja;
  String? idIrmao;
  String? nomeIrmao;
  String? cimIrmao;
  String? fotoIrmao;
  String? esposaIrmao;
  String? fotoespIrmao;
}

class GetIrmaoCargo extends StatelessWidget {
  final String idPotencia;
  final String idLoja;
  final String idMandato;
  final String cargo;

  GetIrmaoCargo(this.idPotencia, this.idLoja, this.idMandato, this.cargo);

  @override
  Widget build(BuildContext context) {
    CollectionReference cargos = FirebaseFirestore.instance
        .collection('potencias')
        .doc(idPotencia)
        .collection('lojas')
        .doc(idLoja)
        .collection('mandatos');

    return FutureBuilder<DocumentSnapshot>(
      future: cargos.doc(idMandato).get(),
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

          return GetIrmaoNome(idPotencia, idLoja, data[cargo]);

        }

        return Text("loading");
      },
    );
  }
}

class GetIrmaoComissao extends StatelessWidget {
  final String idPotencia;
  final String idLoja;
  final String idMandato;
  final String idComissao;
//  final String membro;

  GetIrmaoComissao(this.idPotencia, this.idLoja, this.idMandato, this.idComissao);

  @override
  Widget build(BuildContext context) {
    CollectionReference comissoes = FirebaseFirestore.instance
        .collection('potencias')
        .doc(idPotencia)
        .collection('lojas')
        .doc(idLoja)
        .collection('mandatos')
        .doc(idMandato)
        .collection('comissao');

    return FutureBuilder<DocumentSnapshot>(
      future: comissoes.doc(idComissao).get(),
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

          return Stack(
            alignment: AlignmentDirectional.topStart,
            fit: StackFit.loose,
            clipBehavior: Clip.hardEdge,
            children: [
              Padding(padding: EdgeInsets.only(top: 80.0),
                child: GetIrmaoNome(idPotencia, idLoja, data['membro2']),),
              Padding(padding: EdgeInsets.only(top: 40.0),
                child: GetIrmaoNome(idPotencia, idLoja, data['membro1']),),
              Padding(padding: EdgeInsets.only(top: 0.0),
                child: GetIrmaoNome(idPotencia, idLoja, data['presid']),),
            ],
          );

        }

        return Text("loading");
      },
    );
  }
}