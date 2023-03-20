import 'package:agata_app/views/checagem_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({Key? key}) : super(key: key);

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _firebaseAuth = FirebaseAuth.instance;

  final _cabecalho = 'TERMO DE CONSENTIMENTO PARA TRATAMENTO DE DADOS PESSOAIS';
  final _paragrafo1 = 'Este documento visa registrar a manifestação livre, informada e '
      'inequívoca pela qual o usuário concorda com o tratamento de seus dados pessoais '
      'para finalidade específica, conforme a Lei nº 13.709/2018 – Lei Geral de Proteção '
      'de Dados Pessoais (LGPD).';
  final _paragrafo2 = 'Ao manifestar sua aceitação para com o presente termo, o Usuário '
      'consente e concorda que o autor deste aplicativo tome decisões referentes ao '
      'tratamento de seus dados pessoais, viabilizando suas atividades para as seguintes '
      'finalidades:';
  final _item1 = '• Divulgar informações referentes ao histórico maçônico do Usuário e '
      'gestão das Lojas;';
  final _item2 = '• Validar e atualizar as informações cadastrais dos Usuários e de seu '
      'cônjuge e filhos; ';
  final _item3 = '• Validar dados de utilização e consulta a dados e informações de '
      'Usuários e Lojas.';
  final _paragrafo3 = 'Em caso de não pertencimento ao Quadro da Loja, os dados serão '
      'totalmente descartados de forma segura.';
  final _sessao1 = 'Compartilhamento de Dados';
  final _paragrafo4 = 'O autor deste aplicativo fica autorizado a compartilhar os dados '
      'pessoais do Usuário, caso seja necessário para as finalidades listadas neste termo, '
      'observados os princípios e as garantias estabelecidas pela Lei nº 13.709/2018.';
  final _sessao2 = 'Segurança dos Dados';
  final _paragrafo5 = 'O autor deste aplicativo responsabiliza-se pela manutenção de '
      'medidas de segurança, técnicas e administrativas aptas a proteger os dados pessoais '
      'de acessos não autorizados e de situações acidentais ou ilícitas de destruição, perda, '
      'alteração, comunicação ou qualquer forma de tratamento inadequado ou ilícito.';
  final _paragrafo6 = 'Em conformidade ao art. 48 da Lei nº 13.709/2018, o autor deste '
      'aplicativo, comunicará ao Titular e à Autoridade Nacional de Proteção de Dados (ANPD) '
      'a ocorrência de incidente de segurança que possa acarretar risco ou dano relevante '
      'ao Titular. Declaro autorização e ciência das informações supracitadas.';

  bool value = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro Page'),
      ),
      body: ListView(
        padding: EdgeInsets.all(12),
        children: [
          TextFormField(
            controller: _nomeController,
            decoration: InputDecoration(
              label: Text('Nome completo'),
            ),
          ),
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(
              label: Text('E-mail válido'),
            ),
          ),
          TextFormField(
            controller: _passwordController,
            decoration: InputDecoration(
              label: Text('Senha'),
            ),
          ),
          Text('\n$_cabecalho\n', style: TextStyle(fontWeight: FontWeight.bold),),
          Text('$_paragrafo1'),
          Text('$_paragrafo2'),
          Text('$_item1'),
          Text('$_item2'),
          Text('$_item3'),
          Text('$_paragrafo3'),
          Text('\n$_sessao1', style: TextStyle(fontWeight: FontWeight.bold),),
          Text('$_paragrafo4'),
          Text('\n$_sessao2', style: TextStyle(fontWeight: FontWeight.bold),),
          Text('$_paragrafo5'),
          Text('$_paragrafo6\n'),
          SizedBox(
            width: 10,
          ), //SizedBox
          Text(
            'Li o TERMO DE CONSENTIMENTO PARA TRATAMENTO DE DADOS PESSOAIS e estou de acordo: ',
            style: TextStyle(fontSize: 17.0),
          ), //Text
          SizedBox(width: 10), //SizedBox
          /** Checkbox Widget **/
          Checkbox(
            value: value,
            onChanged: (bool? value) {
              setState(() {
                this.value = value!;
              });
            },
          ),
          ElevatedButton(
            onPressed: () {
              value ? cadastrar() : () {};
            },
            child: Text('Cadastrar'),
          ),
        ],
      ),
    );
  }

  cadastrar() async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
              email: _emailController.text, password: _passwordController.text);
      if (userCredential != null) {
        userCredential.user!.updateDisplayName(_nomeController.text);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => ChecagemPage(),
            ),
            (route) => false);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Crie uma senha mais forte'),
            backgroundColor: Colors.redAccent,
          ),
        );
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Este e-mail já foi cadastrado'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    }
  }
}
