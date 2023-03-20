import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:email_validator/email_validator.dart';
import '../firebase/database_manager.dart';
import '../models/filho.dart';
import '../models/mandato.dart';

class IrmaosPage extends StatefulWidget {
  const IrmaosPage({Key? key, required this.data}) : super(key: key);

  final PotLojAdm data;

  @override
  State<IrmaosPage> createState() => _IrmaosPageState(data);
}

class _IrmaosPageState extends State<IrmaosPage> {
  _IrmaosPageState(PotLojAdm potLojAdm) {
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

  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _cimController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _esposaController = TextEditingController();
  final TextEditingController _nascimentoController = TextEditingController();
  final TextEditingController _iniciacaoController = TextEditingController();
  final TextEditingController _celularController = TextEditingController();
  final TextEditingController _aniversarioespController =
      TextEditingController();
  final TextEditingController _diaMesController = TextEditingController();

  final CollectionReference _potencias =
      FirebaseFirestore.instance.collection('potencias');

  Future<void> _create([DocumentSnapshot? documentSnapshot]) async {
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _nomeController,
                  decoration: const InputDecoration(labelText: 'Nome'),
                ),
                TextField(
                  keyboardType: const TextInputType.numberWithOptions(
                      signed: false, decimal: false),
                  controller: _cimController,
                  decoration: const InputDecoration(
                    labelText: 'CIM',
                  ),
                ),
                TextField(
                  controller: _iniciacaoController,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.calendar_today),
                    labelText: 'Iniciado em:',
                  ),
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2101));

                    if (pickedDate != null) {
                      print(
                          pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                      String formattedDate =
                          DateFormat('dd-MM-yyyy').format(pickedDate);
                      print(
                          formattedDate); //formatted date output using intl package =>  16-03-2021
                      //you can implement different kind of Date Format here according to your requirement

                      setState(() {
                        _iniciacaoController.text =
                            formattedDate; //set output date to TextField value.
                      });
                    } else {
                      print("A data não foi selecionada");
                    }
                  },
                ),
                IntlPhoneField(
                  controller: _celularController,
                  decoration: InputDecoration(
                    labelText: 'Celular',
                    /*border: OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),*/
                  ),
                  onChanged: (phone) {
//                    print(phone.completeNumber);
                  },
                  onCountryChanged: (country) {
//                    print('Country changed to: ' + country.name);
                  },
                ),
                /*TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                ),*/
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: (value) => EmailValidator.validate(value!)
                      ? null
                      : "Informe um e-mail válido.",
                ),
                TextField(
                  controller: _nascimentoController,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.calendar_today),
                    labelText: 'Nascimento',
                  ),
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2101));

                    if (pickedDate != null) {
                      print(
                          pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                      String formattedDate =
                          DateFormat('dd-MM-yyyy').format(pickedDate);
                      print(
                          formattedDate); //formatted date output using intl package =>  16-03-2021
                      //you can implement different kind of Date Format here according to your requirement

                      setState(() {
                        _nascimentoController.text =
                            formattedDate; //set output date to TextField value.
                      });
                    } else {
                      print("A data não foi selecionada");
                    }
                  },
                ),
                TextField(
                  controller: _esposaController,
                  decoration: const InputDecoration(labelText: 'Esposa'),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: const Text('Criar'),
                  onPressed: () async {
                    final String nome = _nomeController.text;
                    final int? cim = int.tryParse(_cimController.text);
                    final String iniciacao = _iniciacaoController.text;
                    final String email = _emailController.text;
                    final String esposa = _esposaController.text;
                    final String nascimento = _nascimentoController.text;
                    final String celular = _celularController.text;
                    if (cim != null) {
                      await _potencias
                          .doc(idPotencia)
                          .collection('lojas')
                          .doc(idLoja)
                          .collection('irmaos')
                          .add({
                        "nome": nome,
                        "cim": cim,
                        "iniciacao": iniciacao,
                        "email": email,
                        "esposa": esposa,
                        "nascimento": nascimento,
                        "celular": celular,
                      });

                      _nomeController.text = '';
                      _cimController.text = '';
                      _emailController.text = '';
                      _esposaController.text = '';
                      _nascimentoController.text = '';
                      _iniciacaoController.text = '';
                      _celularController.text = '';

                      Navigator.of(context).pop();
                    }
                  },
                )
              ],
            ),
          );
        });
  }

  Future<void> _update([DocumentSnapshot? documentSnapshot]) async {
    String _emailAnt = '';
    String _diaMes = '';

    if (documentSnapshot != null) {
      _nomeController.text = documentSnapshot['nome'];
      _cimController.text = documentSnapshot['cim'].toString();
      _emailController.text = documentSnapshot['email'];
      _emailAnt = documentSnapshot['email'];
      _esposaController.text = documentSnapshot['esposa'];
      _nascimentoController.text = documentSnapshot['nascimento'];
      _iniciacaoController.text = documentSnapshot['iniciacao'];
      _celularController.text = documentSnapshot['celular'];
    }

    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  readOnly: true,
                  controller: _nomeController,
                  decoration: const InputDecoration(labelText: 'Nome'),
                ),
                TextField(
                  readOnly: true,
                  keyboardType: const TextInputType.numberWithOptions(
                      signed: false, decimal: false),
                  controller: _cimController,
                  decoration: const InputDecoration(
                    labelText: 'CIM',
                  ),
                ),
                TextField(
                  controller: _iniciacaoController,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.calendar_today),
                    labelText: 'Iniciado em:',
                  ),
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2101));

                    if (pickedDate != null) {
                      print(
                          pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                      String formattedDate =
                          DateFormat('dd-MM-yyyy').format(pickedDate);
                      print(
                          formattedDate); //formatted date output using intl package =>  16-03-2021
                      //you can implement different kind of Date Format here according to your requirement

                      setState(() {
                        _iniciacaoController.text =
                            formattedDate; //set output date to TextField value.
                      });
                    } else {
                      print("A data não foi selecionada");
                    }
                  },
                ),
                IntlPhoneField(
                  controller: _celularController,
                  decoration: InputDecoration(
                    labelText: 'Celular',
                    /*border: OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),*/
                  ),
                  onChanged: (phone) {
//                    print(phone.completeNumber);
                  },
                  onCountryChanged: (country) {
//                    print('Country changed to: ' + country.name);
                  },
                ),
                /*TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  onChanged: () {
                    const String email = _emailController.text;
                    EmailValidator.validate(email);
                  } ,
                ),*/
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: (value) => EmailValidator.validate(value!)
                      ? null
                      : "Informe um e-mail válido.",
                ),
                TextField(
                  controller: _nascimentoController,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.calendar_today),
                    labelText: 'Nascimento',
                  ),
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2101));

                    if (pickedDate != null) {
                      print(
                          pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                      String formattedDate =
                          DateFormat('dd-MM-yyyy').format(pickedDate);
                      print(
                          formattedDate); //formatted date output using intl package =>  16-03-2021
                      //you can implement different kind of Date Format here according to your requirement

                      setState(() {
                        _nascimentoController.text =
                            formattedDate; //set output date to TextField value.
                      });
                    } else {
                      print("A data não foi selecionada");
                    }
                  },
                ),
                TextField(
                  controller: _esposaController,
                  decoration: const InputDecoration(labelText: 'Esposa'),
                ),
                TextField(
                  controller: _aniversarioespController,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.calendar_today),
                    labelText: 'Aniversário',
                  ),
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2101));

                    if (pickedDate != null) {
                      print(
                          pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                      String formattedDate =
                          DateFormat('dd-MM-yyyy').format(pickedDate);
                      String diaMes = DateFormat('dd-MM').format(pickedDate);
                      print(
                          formattedDate); //formatted date output using intl package =>  16-03-2021
                      //you can implement different kind of Date Format here according to your requirement

                      setState(() {
                        _aniversarioespController.text =
                            formattedDate; //set output date to TextField value.
                        _diaMesController.text = diaMes;
                      });
                    } else {
                      print("A data não foi selecionada");
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: const Text('Alterar'),
                  onPressed: () async {
                    final String nome = _nomeController.text;
                    final int? cim = int.tryParse(_cimController.text);
                    final String email = _emailController.text;
                    final String esposa = _esposaController.text;
                    final String nascimento = _nascimentoController.text;
                    final String iniciacao = _iniciacaoController.text;
                    final String celular = _celularController.text;
                    final String aniversarioesp =
                        _aniversarioespController.text;
                    final String anoMes = _diaMesController.text;
//                    print('email: $email, emailLogin: $emailLogin, emailAnt: $_emailAnt');
//                    if (cim != null) {
                    if (emailLogin == email) {
                      await _potencias
                          .doc(idPotencia)
                          .collection('lojas')
                          .doc(idLoja)
                          .collection('irmaos')
                          .doc(documentSnapshot!.id)
//                          .update({"nome": nome, "cim": cim, "email": email});
                          .update({
                        "email": email,
                        "esposa": esposa,
                        "nascimento": nascimento,
                        "iniciacao": iniciacao,
                        "celular": celular,
                        "aniversarioesp": aniversarioesp,
                      });
                      _nomeController.text = '';
                      _cimController.text = '';
                      _emailController.text = '';
                      _esposaController.text = '';
                      _nascimentoController.text = '';
                      _iniciacaoController.text = '';
                      _celularController.text = '';
                      _aniversarioespController.text = '';
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content:
                              Text('Você alterou o registro com sucesso!')));
                      Navigator.of(context).pop();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text(
                              'Você NÃO POSSUI PERMISSÃO para alterar o registro!')));
                      Navigator.of(context).pop();
                    }
                  },
                )
              ],
            ),
          );
        });
  }

  Future<void> _delete(String irmaoId) async {
    await _potencias
        .doc(idPotencia)
        .collection('lojas')
        .doc(idLoja)
        .collection('irmaos')
        .doc(irmaoId)
        .delete();

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Você eliminou um registro com sucesso!')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.red,
        elevation: 4.0,
        title: const Text(
          'IRMÃOS DO QUADRO',
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: StreamBuilder(
        stream: _potencias
            .doc(idPotencia)
            .collection('lojas')
            .doc(idLoja)
            .collection('irmaos')
            .where('situacao', isEqualTo: 'ativo')
            .orderBy('nome', descending: false)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                    streamSnapshot.data!.docs[index];
                String _cim = documentSnapshot['cim'].toString();
                String _email = documentSnapshot['email'];
                String _nascimento = documentSnapshot['nascimento'];
                String _iniciacao = documentSnapshot['iniciacao'];
                String _esposa = documentSnapshot['esposa'];
                String _celular = documentSnapshot['celular'];
                String _aniversarioesp = documentSnapshot["aniversarioesp"];
                var filhos = documentSnapshot["filhos"];

                String _niveresp;
                int tamanho = _aniversarioesp.length;
                if (tamanho >= 5) {
                  _niveresp = _aniversarioesp.substring(0, 5); // '29-07'
                } else {
                  _niveresp = '';
                }

                String relacaoFilhos = '';
                relacaoFilhos = '\nFilhos\n';

                if (filhos.length > 0) {
                  for (var filho in filhos) {
                    relacaoFilhos += '${filho['nome']}, nascido em ${filho['aniversario']}\n';
                  }
                } else {
                  relacaoFilhos += 'Não possui filhos.\n';
                }

                String informacoesIrmao = 'CIM: $_cim\nIniciado em: $_iniciacao\nCelular: $_celular\nEmail: $_email\nNascido em: $_nascimento\nEsposa: $_esposa\nAniversário em: $_niveresp';
                informacoesIrmao += relacaoFilhos;

                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.white12,
                      child: FutureBuilder(
                        future: FireStoreDataBase(documentSnapshot["foto"])
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
                    subtitle: Text(informacoesIrmao),
                    trailing: SizedBox(
                      width: 50,
//                    width: 100,
                      child: Row(
                        children: [
                          IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () => _update(documentSnapshot)),
                          /*IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () => _delete(documentSnapshot.id)),*/
                        ],
                      ),
                    ),
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
// Add new product
    /*floatingActionButton: FloatingActionButton(
          onPressed: () => _create(),
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat);*/
  }
}
