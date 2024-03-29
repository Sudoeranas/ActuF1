import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EquipeClassement {
  final String position;
  final String Equipe;
  final String points;

  EquipeClassement({
    required this.position,
    required this.Equipe,
    required this.points,
  });
}

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
          body: FutureBuilder<List<EquipeClassement>>(
                    future: fetchRaceResults(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else {
                        if (snapshot.hasError) {
                          return Center(child: Text('Error: ${snapshot.error}'));
                        } else {
                          List<EquipeClassement>? equipeList = snapshot.data;
                          return ListView.builder(
                            itemCount: equipeList!.length,
                            itemBuilder: (context, index) {
                              var equipe = equipeList[index];
                              return ListTile(
                                title: Text('Position: ${equipe.position}'),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Team: ${equipe.Equipe}'),
                                    Text('Points: ${equipe.points}')
                                  ],
                                ),
                              );
                            },
                          );
                        }
                      }
                    },
                  ),
                ),
              );
            }

            Future<List<EquipeClassement>> fetchRaceResults() async {
                var url = Uri.parse('http://ergast.com/api/f1/current/constructorStandings.json');

                var response = await http.get(url);

                if (response.statusCode == 200) {
                  List<EquipeClassement> raceResultsList = [];
                  var jsonData = json.decode(response.body);
                  var racesData = jsonData['MRData']['StandingsTable']['StandingsLists'];

                  for (var standingsList in racesData) {
                          var constructorStandings = standingsList['ConstructorStandings'];
                          for (var raceData in constructorStandings) {
                            var raceResults = EquipeClassement(
                              position: raceData['position'].toString(),
                              Equipe: raceData['Constructor']['name'],
                              points: raceData['points'],
                            );
                            raceResultsList.add(raceResults);
                          }
                  }
                  return raceResultsList;
                } else {
                  throw Exception('Failed to load data');
                }
              }
            }