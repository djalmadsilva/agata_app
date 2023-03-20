import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../firebase/database_manager.dart';
import '../models/mandato.dart';

class AniversariantesPage extends StatefulWidget {
  const AniversariantesPage({Key? key, required this.data}) : super(key: key);

  final PotLojAdm data;

  @override
  State<AniversariantesPage> createState() => _AniversariantesPageState(data);
}

class _AniversariantesPageState extends State<AniversariantesPage> {
  _AniversariantesPageState(PotLojAdm potLojAdm) {
    this.idPotencia = potLojAdm.idPotencia!;
    this.nomePotencia = potLojAdm.nomePotencia!;
    this.potenciaPotencia = potLojAdm.potenciaPotencia!;
    this.logoPotencia = potLojAdm.logoPotencia!;
    this.idLoja = potLojAdm.idLoja!;
    this.nomeLoja = potLojAdm.nomeLoja!;
    this.numeroLoja = potLojAdm.numeroLoja!;
    this.logoLoja = potLojAdm.logoLoja!;
    this.emailLogin = potLojAdm.emailLogin!;
    this.emailAnt = potLojAdm.emailAnt!;
  }

  String idPotencia = '';
  String nomePotencia = '';
  String potenciaPotencia = '';
  String logoPotencia = '';
  String idLoja = '';
  String nomeLoja = '';
  String numeroLoja = '';
  String logoLoja = '';
  String emailLogin = '';
  String emailAnt = '';
  String diaMes = '';
  String dateMin = '';
  String dateMax = '';
  int anoAtual = 0;
  int anoIniciacao = 0;
  int idadeMaconica = 0;

  final TextEditingController _dataController = TextEditingController();

  final CollectionReference _potencias =
      FirebaseFirestore.instance.collection('potencias');

  final String dataAtual = DateFormat('dd-MM-yyyy').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.red,
        elevation: 4.0,
        title: const Text(
          'ANIVERSARIANTES',
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _dataController,
            decoration: const InputDecoration(
              icon: Icon(Icons.calendar_today),
              labelText: 'Data:',
            ),
            readOnly: true,
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2101));

              if (pickedDate != null) {
//                print(
//                    'pickedDate: $pickedDate'); //pickedDate output format => 2021-03-10 00:00:00.000
                anoAtual = pickedDate.year;
                diaMes = DateFormat('dd-MM').format(pickedDate);
                dateMin = '$diaMes-0000';
                dateMax = '$diaMes-9999';

                /*String formattedDate = DateFormat('dd-MM').format(pickedDate);
                dateMin = '$formattedDate-0000';
                dateMax = '$formattedDate-9999';*/
//                print(
//                    'formattedDate: $formattedDate'); //formatted date output using intl package =>  16-03-2021
                //you can implement different kind of Date Format here according to your requirement
//                print('dateMin: $dateMin');
//                print('dateMax: $dateMax');
                setState(() {
                  _dataController.text =
                      diaMes; //set output date to TextField value.
                });
              } else {
                print("A data não foi selecionada");
              }
            },
          ),
          Text(
            'IRMÃOS ANIVERSARIANTES',
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: StreamBuilder(
              stream: _potencias
                  .doc(idPotencia)
                  .collection('lojas')
                  .doc(idLoja)
                  .collection('irmaos')
                  .where('nascimento', isNotEqualTo: '')
                  .where('situacao', isEqualTo: 'ativo')
                  .where('nascimento', isLessThanOrEqualTo: dateMax)
                  .where('nascimento', isGreaterThanOrEqualTo: dateMin)
//                  .orderBy('nascimento', descending: false)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                if (streamSnapshot.hasData) {
                  return ListView.builder(
                    itemCount: streamSnapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final DocumentSnapshot documentSnapshot =
                          streamSnapshot.data!.docs[index];
                      String _nome = documentSnapshot['nome'];
                      String _nascimento = documentSnapshot['nascimento'];
                      String _celular = documentSnapshot['celular'];

                      String _niver;
                      int tamanho = _nascimento.length;
                      if (tamanho >= 5) {
                        _niver = _nascimento.substring(0, 5); // '29-07'
                      } else {
                        _niver = '';
                      }

                      return Card(
                        margin: const EdgeInsets.all(10),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.white12,
                            child: FutureBuilder(
                              future:
                                  FireStoreDataBase(documentSnapshot["foto"])
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
                          title: Text('$_niver $_nome'),
                          subtitle: Text('Celular: $_celular'),
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
          Text(
            'IRMÃOS INICIADOS',
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: StreamBuilder(
              stream: _potencias
                  .doc(idPotencia)
                  .collection('lojas')
                  .doc(idLoja)
                  .collection('irmaos')
                  .where('iniciacao', isNotEqualTo: '')
                  .where('situacao', isEqualTo: 'ativo')
                  .where('iniciacao', isLessThanOrEqualTo: dateMax)
                  .where('iniciacao', isGreaterThanOrEqualTo: dateMin)
//                  .orderBy('nascimento', descending: false)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                if (streamSnapshot.hasData) {
                  return ListView.builder(
                    itemCount: streamSnapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final DocumentSnapshot documentSnapshot =
                          streamSnapshot.data!.docs[index];
                      String _nome = documentSnapshot['nome'];
                      String _iniciacao = documentSnapshot['iniciacao'];
                      String _celular = documentSnapshot['celular'];

                      String _niver;
                      String _ano;
                      int tamanho = _iniciacao.length;
                      if (tamanho >= 5) {
                        _niver = _iniciacao.substring(0, 5); // '29-07'
                      } else {
                        _niver = '';
                      }
                      if (tamanho >= 10) {
                        _ano = _iniciacao.substring(6, 10); // '29-07-1961'
                      } else {
                        _ano = '';
                      }
//                      print('Ano: $_ano');
                      anoIniciacao = int.parse(_ano);
//                      print('anoAtual: $anoAtual, anoIniciacao: $anoIniciacao');
                      idadeMaconica = anoAtual - anoIniciacao;

                      return Card(
                        margin: const EdgeInsets.all(10),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.white12,
                            child: FutureBuilder(
                              future:
                                  FireStoreDataBase(documentSnapshot["foto"])
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
                          title: Text('$_niver $_nome'),
                          subtitle: Text(
                              'Idade Maçônica: $idadeMaconica anos,\nCelular: $_celular'),
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
          Text(
            'CUNHADAS ANIVERSARIANTES',
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: StreamBuilder(
              stream: _potencias
                  .doc(idPotencia)
                  .collection('lojas')
                  .doc(idLoja)
                  .collection('irmaos')
                  .where('aniversarioesp', isNotEqualTo: '')
                  .where('situacao', isEqualTo: 'ativo')
                  .where('aniversarioesp', isLessThanOrEqualTo: dateMax)
                  .where('aniversarioesp', isGreaterThanOrEqualTo: dateMin)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                if (streamSnapshot.hasData) {
                  return ListView.builder(
                    itemCount: streamSnapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final DocumentSnapshot documentSnapshot =
                          streamSnapshot.data!.docs[index];
                      String _nome = documentSnapshot['nome'];
                      String _esposa = documentSnapshot['esposa'];
                      String _aniversarioesp =
                          documentSnapshot['aniversarioesp'];
                      String _celular = documentSnapshot['celular'];

                      String _niver;
                      int tamanho = _aniversarioesp.length;
                      if (tamanho >= 5) {
                        _niver = _aniversarioesp.substring(0, 5); // '29-07'
                      } else {
                        _niver = '';
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
                          title: Text('$_niver $_esposa'),
                          subtitle: Text('Irmão: $_nome, Celular: $_celular'),
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
          Text(
            'SOBRINHOS ANIVERSARIANTES',
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: StreamBuilder(
              stream: _potencias
                  .doc(idPotencia)
                  .collection('lojas')
                  .doc(idLoja)
                  .collection('irmaos')
                  .where('situacao', isEqualTo: 'ativo')
//                  .where('filhos.id.aniversario', isGreaterThanOrEqualTo: dateMin)
//                  .where('filhos.id.aniversario', isLessThanOrEqualTo: dateMax)
//                    .where('filhos', arrayContains: 'aniversario'.substring(0,5) == diaMes)
//                  .where('filhos', arrayContains: {'aniversario' == '09-10-2019'})
//                  .where('filhos.aniversario', isEqualTo: '09-10-2019')
//                  .where('filhos', isNull: false)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                if (streamSnapshot.hasData) {
                  return ListView.builder(
                    itemCount: streamSnapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final DocumentSnapshot documentSnapshot =
                          streamSnapshot.data!.docs[index];
                      String _nome = documentSnapshot['nome'];
                      String _celular = documentSnapshot['celular'];
                      var filhos = documentSnapshot["filhos"];

                      String _aniversarioFilho = '';
                      String _niver = '';

                      String _titulo = '';
                      String _subTitulo = '';
                      String _foto = '';
                      bool _encontrou = false;

                      if (filhos.length == 0) {
                        return Visibility(child: Text("Feito"), visible: false);
                      }

                      for (var filho in filhos) {
                        _aniversarioFilho = '${filho['aniversario']}';
                        _niver = _aniversarioFilho.substring(0, 5); // '29-07'

                        if (_niver == diaMes) {
                          _foto = '${filho['foto']}';
                          _titulo = '$_niver ${filho['nome']}\n';
                          _subTitulo = 'Irmão: $_nome, Celular: $_celular';
                          _encontrou = true;
                        }
                      }
                      if (_encontrou == true) {
                        _encontrou = false;
                        return Card(
                          margin: const EdgeInsets.all(10),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.white12,
                              child: FutureBuilder(
                                future: FireStoreDataBase(_foto)
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
                            title: Text('$_titulo'),
                            subtitle: Text('$_subTitulo'),
                          ),
                        );
                      } else {
                        return Visibility(child: Text("Feito"), visible: false);
                      }
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
