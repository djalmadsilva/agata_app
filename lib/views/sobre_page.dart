import 'package:flutter/material.dart';

class SobrePage extends StatelessWidget {
  const SobrePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.red,
          elevation: 4.0,
          title: const Text(
            'NOMINATA MAÇÔNICA',
            style: TextStyle(fontSize: 20),
          ),
        ),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/nominata.png',
                    fit: BoxFit.fill,
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Versão: 1.0.0\n',
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text.rich(
                  TextSpan(
                    style: TextStyle(
                      fontSize: 17,
                    ),
                    children: [
                      WidgetSpan(
                        child: Icon(Icons.person),
                      ),
                      TextSpan(text: 'Djalma Domingos da Silva\n'),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text.rich(
                  TextSpan(
                    style: TextStyle(
                      fontSize: 17,
                    ),
                    children: [
                      WidgetSpan(
                        child: Icon(Icons.email),
                      ),
                      TextSpan(text: 'djalmadsilva@gmail.com\n'),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text.rich(
                  TextSpan(
                    style: TextStyle(
                      fontSize: 17,
                    ),
                    children: [
                      WidgetSpan(
                        child: Image.asset(
                          'assets/images/whatsapp.png',
                          fit: BoxFit.fill,
                        ),
                      ),
                      TextSpan(text: '(17) 99711-3255'),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
