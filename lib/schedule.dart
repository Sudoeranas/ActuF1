import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Race {
  final String raceName;
  final String date;
  final String round;
  final String circuitName;
  final String countryImage;
  final String countryName;

  Race({
    required this.raceName,
    required this.date,
    required this.round,
    required this.circuitName,
    required this.countryImage,
    required this.countryName,
  });
}

Future<List<Race>> getRaceCurrentSeason() async {
  var url = Uri.parse('http://ergast.com/api/f1/current.json');
  var response = await http.get(url);

  if (response.statusCode == 200) {
      List<Race> races = [];

      var jsonData = json.decode(response.body);
      var racesData = jsonData['MRData']['RaceTable']['Races'];

      for (var raceData in racesData) {
           var race = Race(
           raceName: raceData['raceName'],
           date: raceData['date'],
           round: raceData['round'],
           circuitName: raceData['Circuit']['circuitName'],
           countryImage: '#',
           countryName: raceData['Circuit']['Location']['country'],
         );
         races.add(race);
      }
      for (var race in races) {
        print('Race Name: ${race.raceName}');
        print('Date: ${race.date}');
        print('Round: ${race.round}');
        print('Circuit Name: ${race.circuitName}');
        print('Country Image: ${race.countryImage}');
        print('Country Name: ${race.countryName}');
        print('---------------------------');
      }
      return races;
  } else {
      throw Exception('Failed to load data');
    }
}

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
                        FutureBuilder<List<Race>>(
                          future: getRaceCurrentSeason(),
                          builder: (BuildContext context, AsyncSnapshot<List<Race>> snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            } else {
                              if (snapshot.hasError) {
                                return Center(
                                  child: Text('Error: ${snapshot.error}'),
                                );
                              } else {
                                List<Race> upcomingRaces = snapshot.data!
                                    .where((race) => DateTime.parse(race.date).isAfter(DateTime.now()))
                                    .toList();
                                return ListView.builder(
                                  itemCount: upcomingRaces.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    Race race = upcomingRaces[index];
                                    return ListTile(
                                      leading: Icon(Icons.flag), // Placeholder for country image
                                      title: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Round: ${race.round}',
                                            style: TextStyle(
                                              color: Colors.red,
                                            ),
                                          ),
                                          Text(
                                            race.countryName,
                                            style: TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                          Text(
                                            race.circuitName,
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                      trailing: Text(
                                        race.date,
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                    );
                                  },
                                );
                              }
                            }
                          },
                        ),
                        FutureBuilder<List<Race>>(
                          future: getRaceCurrentSeason(),
                          builder: (BuildContext context, AsyncSnapshot<List<Race>> snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            } else {
                              if (snapshot.hasError) {
                                return Center(
                                  child: Text('Error: ${snapshot.error}'),
                                );
                              } else {
                                List<Race> pastRaces = snapshot.data!
                                    .where((race) => DateTime.parse(race.date).isBefore(DateTime.now()))
                                    .toList();
                                return ListView.builder(
                                  itemCount: pastRaces.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    Race race = pastRaces[index];
                                    return ListTile(
                                      leading: Icon(Icons.flag), // Placeholder for country image
                                      title: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Round: ${race.round}',
                                            style: TextStyle(
                                              color: Colors.red,
                                            ),
                                          ),
                                          Text(
                                            race.countryName,
                                            style: TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                          Text(
                                            race.circuitName,
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                      trailing: Text(
                                        race.date,
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                    );
                                  },
                                );
                              }
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          }
