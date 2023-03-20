import 'package:flutter/material.dart';
import '../firebase/database_manager.dart';
import '../models/irmao.dart';
import '../models/mandato.dart';

class AdministracaoPage extends StatefulWidget {
  const AdministracaoPage({Key? key, required this.data}) : super(key: key);

  final Mandato data;

  @override
  State<AdministracaoPage> createState() => _AdministracaoPageState(data);
}

class _AdministracaoPageState extends State<AdministracaoPage> {
  _AdministracaoPageState(Mandato mandato) {
    this.idPotencia = mandato.idPotencia!;
    this.nomePotencia = mandato.nomePotencia!;
    this.potenciaPotencia = mandato.potenciaPotencia!;
    this.logoPotencia = mandato.logoPotencia!;
    this.idLoja = mandato.idLoja!;
    this.nomeLoja = mandato.nomeLoja!;
    this.numeroLoja = mandato.numeroLoja!;
    this.logoLoja = mandato.logoLoja!;
    this.idMandato = mandato.idMandato!;
    this.dataIni = mandato.dataIni!;
    this.dataTer = mandato.dataTer!;
  }

  String idPotencia = '';
  String nomePotencia = '';
  String potenciaPotencia = '';
  String logoPotencia = '';
  String idLoja = '';
  String nomeLoja = '';
  String numeroLoja = '';
  String logoLoja = '';
  String idMandato = '';
  String dataIni = '';
  String dataTer = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.red,
        elevation: 4.0,
        title: const Text(
          'MANDATO',
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
                  title: Text('$nomeLoja - $dataIni-$dataTer'),
                  subtitle: Text(numeroLoja.toString()),
                  onTap: () {},
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(8),
              children: <Widget>[
                Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.white12,
                      child: FutureBuilder(
                        future:
                            FireStoreDataBase('/files/joias/vm.png').getData(),
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
                    title: Text('V∴M∴'),
                    subtitle:
                        GetIrmaoCargo(idPotencia, idLoja, idMandato, 'vm'),
                    onTap: () {},
                  ),
                ),
                Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.white12,
                      child: FutureBuilder(
                        future: FireStoreDataBase('/files/joias/1vig.png')
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
                    title: Text('1∴Vig∴'),
                    subtitle:
                        GetIrmaoCargo(idPotencia, idLoja, idMandato, '1vig'),
                    onTap: () {},
                  ),
                ),
                Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.white12,
                      child: FutureBuilder(
                        future: FireStoreDataBase('/files/joias/2vig.png')
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
                    title: Text('2∴Vig∴'),
                    subtitle:
                        GetIrmaoCargo(idPotencia, idLoja, idMandato, '2vig'),
                    onTap: () {},
                  ),
                ),
                Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.white12,
                      child: FutureBuilder(
                        future: FireStoreDataBase('/files/joias/orad.png')
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
                    title: Text('Orad∴'),
                    subtitle:
                        GetIrmaoCargo(idPotencia, idLoja, idMandato, 'orad'),
                    onTap: () {},
                  ),
                ),
                Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.white12,
                      child: FutureBuilder(
                        future: FireStoreDataBase('/files/joias/orad.png')
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
                    title: Text('Orad∴Adj∴'),
                    subtitle:
                        GetIrmaoCargo(idPotencia, idLoja, idMandato, 'oradadj'),
                    onTap: () {},
                  ),
                ),
                Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.white12,
                      child: FutureBuilder(
                        future: FireStoreDataBase('/files/joias/secr.png')
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
                    title: Text('Secr∴'),
                    subtitle:
                        GetIrmaoCargo(idPotencia, idLoja, idMandato, 'secr'),
                    onTap: () {},
                  ),
                ),
                Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.white12,
                      child: FutureBuilder(
                        future: FireStoreDataBase('/files/joias/secr.png')
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
                    title: Text('Secr∴Adj∴'),
                    subtitle:
                        GetIrmaoCargo(idPotencia, idLoja, idMandato, 'secradj'),
                    onTap: () {},
                  ),
                ),
                Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.white12,
                      child: FutureBuilder(
                        future: FireStoreDataBase('/files/joias/tesour.png')
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
                    title: Text('Tesour∴'),
                    subtitle:
                        GetIrmaoCargo(idPotencia, idLoja, idMandato, 'tesour'),
                    onTap: () {},
                  ),
                ),
                Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.white12,
                      child: FutureBuilder(
                        future: FireStoreDataBase('/files/joias/tesour.png')
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
                    title: Text('Tesour∴Adj∴'),
                    subtitle: GetIrmaoCargo(
                        idPotencia, idLoja, idMandato, 'tesouradj'),
                    onTap: () {},
                  ),
                ),
                Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.white12,
                      child: FutureBuilder(
                        future: FireStoreDataBase('/files/joias/chanc.png')
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
                    title: Text('Chanc∴'),
                    subtitle:
                        GetIrmaoCargo(idPotencia, idLoja, idMandato, 'chanc'),
                    onTap: () {},
                  ),
                ),
                Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.white12,
                      child: FutureBuilder(
                        future: FireStoreDataBase('/files/joias/mccer.png')
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
                    title: Text('M∴CCer∴'),
                    subtitle:
                        GetIrmaoCargo(idPotencia, idLoja, idMandato, 'mccer'),
                    onTap: () {},
                  ),
                ),
                Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.white12,
                      child: FutureBuilder(
                        future: FireStoreDataBase('/files/joias/hosp.png')
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
                    title: Text('Hosp∴'),
                    subtitle:
                        GetIrmaoCargo(idPotencia, idLoja, idMandato, 'hosp'),
                    onTap: () {},
                  ),
                ),
                Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.white12,
                      child: FutureBuilder(
                        future: FireStoreDataBase('/files/joias/mbbanq.png')
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
                    title: Text('M∴BBanq∴'),
                    subtitle:
                        GetIrmaoCargo(idPotencia, idLoja, idMandato, 'mbbanq'),
                    onTap: () {},
                  ),
                ),
                Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.white12,
                      child: FutureBuilder(
                        future: FireStoreDataBase('/files/joias/mharm.png')
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
                    title: Text('M∴Harm∴'),
                    subtitle:
                        GetIrmaoCargo(idPotencia, idLoja, idMandato, 'mharm'),
                    onTap: () {},
                  ),
                ),
                Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.white12,
                      child: FutureBuilder(
                        future: FireStoreDataBase('/files/joias/diac.png')
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
                    title: Text('1∴Diac∴'),
                    subtitle:
                        GetIrmaoCargo(idPotencia, idLoja, idMandato, '1diac'),
                    onTap: () {},
                  ),
                ),
                Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.white12,
                      child: FutureBuilder(
                        future: FireStoreDataBase('/files/joias/diac.png')
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
                    title: Text('2∴Diac∴'),
                    subtitle:
                        GetIrmaoCargo(idPotencia, idLoja, idMandato, '2diac'),
                    onTap: () {},
                  ),
                ),
                Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.white12,
                      child: FutureBuilder(
                        future: FireStoreDataBase('/files/joias/cobrint.png')
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
                    title: Text('Cobr∴Int∴'),
                    subtitle:
                        GetIrmaoCargo(idPotencia, idLoja, idMandato, 'cobrint'),
                    onTap: () {},
                  ),
                ),
                Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.white12,
                      child: FutureBuilder(
                        future: FireStoreDataBase('/files/joias/cobrext.png')
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
                    title: Text('Cobr∴Ext∴'),
                    subtitle:
                        GetIrmaoCargo(idPotencia, idLoja, idMandato, 'cobrext'),
                    onTap: () {},
                  ),
                ),
                Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.white12,
                      child: FutureBuilder(
                        future:
                            FireStoreDataBase('/files/joias/exp.png').getData(),
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
                    title: Text('1∴Exp∴'),
                    subtitle:
                        GetIrmaoCargo(idPotencia, idLoja, idMandato, '1exp'),
                    onTap: () {},
                  ),
                ),
                Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.white12,
                      child: FutureBuilder(
                        future:
                            FireStoreDataBase('/files/joias/exp.png').getData(),
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
                    title: Text('2∴Exp∴'),
                    subtitle:
                        GetIrmaoCargo(idPotencia, idLoja, idMandato, '2exp'),
                    onTap: () {},
                  ),
                ),
                Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.white12,
                      child: FutureBuilder(
                        future:
                            FireStoreDataBase('/files/joias/exp.png').getData(),
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
                    title: Text('3∴Exp∴'),
                    subtitle:
                        GetIrmaoCargo(idPotencia, idLoja, idMandato, '3exp'),
                    onTap: () {},
                  ),
                ),
                Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.white12,
                      child: FutureBuilder(
                        future: FireStoreDataBase('/files/joias/arqu.png')
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
                    title: Text('Arqu∴'),
                    subtitle:
                        GetIrmaoCargo(idPotencia, idLoja, idMandato, 'arqu'),
                    onTap: () {},
                  ),
                ),
                Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.white12,
                      child: FutureBuilder(
                        future: FireStoreDataBase('/files/joias/portest.png')
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
                    title: Text('Port∴Est∴'),
                    subtitle:
                        GetIrmaoCargo(idPotencia, idLoja, idMandato, 'portest'),
                    onTap: () {},
                  ),
                ),
                Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.white12,
                      child: FutureBuilder(
                        future: FireStoreDataBase('/files/joias/portband.png')
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
                    title: Text('Port∴Band∴'),
                    subtitle: GetIrmaoCargo(
                        idPotencia, idLoja, idMandato, 'portband'),
                    onTap: () {},
                  ),
                ),
                Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.white12,
                      child: FutureBuilder(
                        future: FireStoreDataBase('/files/joias/portesp.png')
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
                    title: Text('Port∴Esp∴'),
                    subtitle:
                        GetIrmaoCargo(idPotencia, idLoja, idMandato, 'portesp'),
                    onTap: () {},
                  ),
                ),
                Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.white12,
                      child: FutureBuilder(
                        future: FireStoreDataBase('/files/joias/bibl.png')
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
                    title: Text('Bibl∴'),
                    subtitle:
                        GetIrmaoCargo(idPotencia, idLoja, idMandato, 'bibl'),
                    onTap: () {},
                  ),
                ),
                Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.white12,
                      child: FutureBuilder(
                        future: FireStoreDataBase('/files/joias/mestrinst.png')
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
                    title: Text('V∴M∴Dep∴'),
                    subtitle:
                        GetIrmaoCargo(idPotencia, idLoja, idMandato, 'vmdep'),
                    onTap: () {},
                  ),
                ),
                Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.white12,
                      child: FutureBuilder(
                        future: FireStoreDataBase('/files/joias/mestr.png')
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
                    title: Text('V∴M∴Dep∴Supl∴'),
                    subtitle: GetIrmaoCargo(
                        idPotencia, idLoja, idMandato, 'vmdepsupl'),
                    onTap: () {},
                  ),
                ),
                Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.white12,
                      child: FutureBuilder(
                        future: FireStoreDataBase(
                                '/files/joias/comissaocentral.jpeg')
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
                    title: Text('COMISSÃO CENTRAL'),
                    subtitle: GetIrmaoComissao(
                        idPotencia, idLoja, idMandato, 'central'),
                    onTap: () {},
                  ),
                ),
                Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.white12,
                      child: FutureBuilder(
                        future: FireStoreDataBase(
                                '/files/joias/comissaofinancas.jpeg')
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
                    title: Text('COMISSÃO FINANÇAS'),
                    subtitle: GetIrmaoComissao(
                        idPotencia, idLoja, idMandato, 'financas'),
                    onTap: () {},
                  ),
                ),
                Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.white12,
                      child: FutureBuilder(
                        future: FireStoreDataBase(
                                '/files/joias/comissaoritualistica.jpeg')
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
                    title: Text('COMISSÃO RITUALÍSTICA'),
                    subtitle: GetIrmaoComissao(
                        idPotencia, idLoja, idMandato, 'ritualistica'),
                    onTap: () {},
                  ),
                ),
                Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.white12,
                      child: FutureBuilder(
                        future: FireStoreDataBase(
                                '/files/joias/comissaoeventos.png')
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
                    title: Text('COMISSÃO EVENTOS'),
                    subtitle: GetIrmaoComissao(
                        idPotencia, idLoja, idMandato, 'eventos'),
                    onTap: () {},
                  ),
                ),
                Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.white12,
                      child: FutureBuilder(
                        future: FireStoreDataBase(
                                '/files/joias/comissaobeneficencia.png')
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
                    title: Text('COMISSÃO BENEFICÊNCIA'),
                    subtitle: GetIrmaoComissao(
                        idPotencia, idLoja, idMandato, 'beneficencia'),
                    onTap: () {},
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
