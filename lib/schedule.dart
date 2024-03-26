import 'package:flutter/material.dart';

class Schedule extends StatelessWidget {
const Schedule({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
            'Schedule',
            style: TextStyle(
                fontSize: 30.0,
                color: Color(0xFFFF0000)
                ),
            ),
            bottom: TabBar(
              indicatorColor: Colors.red,
              labelColor: Colors.red,
              tabs: [
                Tab(text: 'UPCOMING'),
                Tab(text: 'PAST'),
              ],
            ),
          ),
          body: TabBarView(
                      children: [
                        ListView(
                          children: <Widget>[
                            ListTile(title: Text('Spain')),
                            ListTile(title: Text('Monaco')),
                            // Ajoutez plus d'éléments ici pour la liste DRIVERS
                          ],
                        ),
                        ListView(
                          children: <Widget>[
                            ListTile(title: Text('USA')),
                            ListTile(title: Text('Italy')),
                            // Ajoutez plus d'éléments ici pour la liste TEAMS
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          }