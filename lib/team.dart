import 'package:flutter/material.dart';

class Team extends StatelessWidget {
const Team({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text(
            'Team',
            style: TextStyle(
                fontSize: 30.0,
                color: Color(0xFFFF0000)
                ),
            ),
          ),
          body: Text("Contenu Team"),
                ),
              );
            }
          }