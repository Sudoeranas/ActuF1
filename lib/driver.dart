import 'package:flutter/material.dart';

class Driver extends StatelessWidget {
const Driver({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
            'Driver',
            style: TextStyle(
                fontSize: 30.0,
                color: Color(0xFFFF0000)
                ),
            ),
            bottom: TabBar(
              indicatorColor: Colors.red,
              labelColor: Colors.red,
              tabs: [
                Tab(text: 'DRIVERS'),
                Tab(text: 'TEAMS'),
                Tab(text: 'SCHEDULE'),
              ],
            ),
          ),
          body: TabBarView(
                      children: [
                        ListView(
                          children: <Widget>[
                            ListTile(title: Text('Max Verstappen')),
                            ListTile(title: Text('Lewis Hamilton')),
                            // Ajoutez plus d'éléments ici pour la liste DRIVERS
                          ],
                        ),
                        ListView(
                          children: <Widget>[
                            ListTile(title: Text('Red Bull')),
                            ListTile(title: Text('Mercedes')),
                            // Ajoutez plus d'éléments ici pour la liste TEAMS
                          ],
                        ),
                        ListView(
                          children: <Widget>[
                            ListTile(title: Text('Race 1')),
                            ListTile(title: Text('Race 2')),
                            // Ajoutez plus d'éléments ici pour la liste SCHEDULE
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          }