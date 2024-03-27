import 'package:flutter/material.dart';

class Driver extends StatelessWidget {
const Driver({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text(
            'Driver',
            style: TextStyle(
                fontSize: 30.0,
                color: Color(0xFFFF0000)
                ),
            ),
          ),
          body: Text("Contenu Driver"),
                ),
              );
            }
          }