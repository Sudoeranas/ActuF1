import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DriverClassement {
  final String position;
  final String PrenomPilote;
  final String NomPilote;
  final String Equipe;
  final String points;

  DriverClassement({
    required this.position,
    required this.PrenomPilote,
    required this.NomPilote,
    required this.Equipe,
    required this.points,
  });
}

class Driver extends StatelessWidget {
  const Driver({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Driver Standing',
            style: TextStyle(
              fontSize: 30.0,
              color: Color(0xFFFF0000),
            ),
          ),
        ),
        body: FutureBuilder<List<DriverClassement>>(
          future: fetchRaceResults(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else {
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                List<DriverClassement>? driverList = snapshot.data;
                return ListView.builder(
                  itemCount: driverList!.length,
                  itemBuilder: (context, index) {
                    var driver = driverList[index];
                    return ListTile(
                      title: Text('Position: ${driver.position}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Driver: ${driver.PrenomPilote} ${driver.NomPilote}'),
                          Text('Team: ${driver.Equipe}'),
                          Text('Points: ${driver.points}')
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

  Future<List<DriverClassement>> fetchRaceResults() async {
    var url = Uri.parse('http://ergast.com/api/f1/current/driverStandings.json');

    var response = await http.get(url);

    if (response.statusCode == 200) {
      List<DriverClassement> raceResultsList = [];
      var jsonData = json.decode(response.body);
      var racesData = jsonData['MRData']['StandingsTable']['StandingsLists'][0]['DriverStandings'];

      for (var raceData in racesData) {
        var raceResults = DriverClassement(
          position: raceData['position'].toString(),
          PrenomPilote: raceData['Driver']['givenName'],
          NomPilote: raceData['Driver']['familyName'],
          Equipe: raceData['Constructors'][0]['name'],
          points: raceData['points'],
        );

        raceResultsList.add(raceResults);
      }
      return raceResultsList;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
