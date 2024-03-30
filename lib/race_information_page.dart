import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RaceDetails {
    final String raceName;
    final String date;
    final String time;
    final String circuitName;
    final String countryImage;
    final String firstPracticeDate;
    final String secondPracticeDate;
    final String thirdPracticeDate;
    final String QualifyingDate;
    final String firstPracticeTime;
    final String secondPracticeTime;
    final String thirdPracticeTime;
    final String QualifyingTime;
    final String type;

    RaceDetails({
        required this.raceName,
        required this.date,
        required this.time,
        required this.circuitName,
        required this.countryImage,
        required this.firstPracticeDate,
        required this.secondPracticeDate,
        required this.thirdPracticeDate,
        required this.QualifyingDate,
        required this.firstPracticeTime,
        required this.secondPracticeTime,
        required this.thirdPracticeTime,
        required this.QualifyingTime,
        required this.type,
    });
}

class RaceResults {
    final String position;
    final String PrenomPilote;
    final String NomPilote;
    final String Equipe;

    RaceResults({
        required this.position,
        required this.PrenomPilote,
        required this.NomPilote,
        required this.Equipe,
    });
}

class RaceInformationPage extends StatelessWidget {
  final String year;
  final String round;

  RaceInformationPage({required this.year, required this.round});

  @override
  Widget build(BuildContext context) {
  return DefaultTabController(
    length: 2,
    child: Scaffold(
      appBar: AppBar(
        toolbarHeight:120.0,
        // Flèche de retour
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: FutureBuilder<List<RaceDetails>>(
            future: fetchRaceData(), // Appel à votre fonction pour récupérer les données de l'API
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // Afficher un indicateur de chargement si les données ne sont pas encore disponibles
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                // Afficher un message d'erreur si une erreur s'est produite lors du chargement des données
                return Text('Error: ${snapshot.error}');
              } else {
                // Afficher les données dans l'AppBar une fois qu'elles sont disponibles
                List<RaceDetails> raceDetailsList = snapshot.data!;
                var raceDetails = raceDetailsList.first;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Text(
                     'Round: ${round}',
                     style: TextStyle(
                       color: Colors.red,
                     ),
                  ),
                    Text(
                      raceDetails.raceName,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      raceDetails.circuitName,
                      style: TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                    Text(
                      raceDetails.date,
                      style: TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                  ],
                );
              }
            },
          ),
        actions: [
          CircleAvatar(
            backgroundImage: AssetImage('assets/images/default_flag.png'),
            radius: 30.0,
          ),
        ],
        bottom: TabBar(
        indicatorColor: Colors.red,
        labelColor: Colors.red,
          tabs: [
            Tab(text: 'Informations'),
            Tab(text: 'Results'),
          ],
        ),
      ),
      body: TabBarView(
                children: [
                  FutureBuilder<List<RaceDetails>>(
                    future: fetchRaceData(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else {
                        if (snapshot.hasError) {
                          return Center(child: Text('Error: ${snapshot.error}'));
                        } else {
                          List<RaceDetails> raceDetailsList = snapshot.data!;
                          var raceDetails = raceDetailsList.first;
                          return Container(
                            padding: EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Map',
                                  style: TextStyle(
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 16.0),
                                Image.network(
                                  '#',
                                  height: 200.0,
                                  fit: BoxFit.cover,
                                ),
                                SizedBox(height: 16.0),
                                Text(
                                  'Race weekend',
                                  style: TextStyle(
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 8.0),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                          'First practice:',
                                          ),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              Text(raceDetails.firstPracticeDate,
                                                  style: TextStyle(
                                                   fontWeight: FontWeight.bold,
                                                  ),
                                              ),
                                              Text(raceDetails.firstPracticeTime,
                                                  style: TextStyle(
                                                   fontWeight: FontWeight.bold,
                                                  ),
                                              ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Divider(),
                                        Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('Second practice:'),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                                 children: [
                                                   Text(raceDetails.secondPracticeDate,
                                                      style: TextStyle(
                                                       fontWeight: FontWeight.bold,
                                                      ),
                                                   ),
                                                   Text(raceDetails.secondPracticeTime,
                                                      style: TextStyle(
                                                       fontWeight: FontWeight.bold,
                                                      ),

                                                   ),
                                                   ],
                                                 ),
                                              ],
                                            ),
                                            Divider(),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text('${raceDetails.type}:'),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                  children: [
                                                    Text(raceDetails.thirdPracticeDate,
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                      Text(raceDetails.thirdPracticeTime,
                                                        style: TextStyle(
                                                          fontWeight: FontWeight.bold,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                  ),
                                                  Divider(),
                                                  Row(
                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                children: [
                                                                  Text('Qualifying:'),
                                                                  Column(
                                                                    crossAxisAlignment: CrossAxisAlignment.end,
                                                                    children: [
                                                                      Text(raceDetails.QualifyingDate,
                                                                           style: TextStyle(
                                                                            fontWeight: FontWeight.bold,
                                                                           ),
                                                                      ),
                                                                      Text(raceDetails.QualifyingTime,
                                                                          style: TextStyle(
                                                                           fontWeight: FontWeight.bold,
                                                                          ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                              Divider(),
                                                              Row(
                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                children: [
                                                                  Text('Race:'),
                                                                  Column(
                                                                    crossAxisAlignment: CrossAxisAlignment.end,
                                                                    children: [
                                                                      Text(raceDetails.date,
                                                                       style: TextStyle(
                                                                        fontWeight: FontWeight.bold,
                                                                       ),

                                                                      ),
                                                                      Text(raceDetails.time,
                                                                          style: TextStyle(
                                                                           fontWeight: FontWeight.bold,
                                                                          ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  }
                                                }
                                              },
                                            ),
                  // Deuxième onglet : "Results"
                  FutureBuilder<List<RaceResults>>(
                                future: fetchRaceResults(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return Center(child: CircularProgressIndicator());
                                  } else {
                                    if (snapshot.hasError) {
                                      return Center(child: Text('Cette course n\'est pas encore terminée'));
                                    } else {
                                      List<RaceResults> raceResultsList = snapshot.data!;
                                      return ListView.builder(
                                        itemCount: raceResultsList.length,
                                        itemBuilder: (context, index) {
                                          var raceResult = raceResultsList[index];
                                          return ListTile(
                                            title: Text('Position: ${raceResult.position}'),
                                            subtitle: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text('Driver: ${raceResult.PrenomPilote} ${raceResult.NomPilote}'),
                                                Text('Team: ${raceResult.Equipe}'),
                                              ],
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
                      );
                    }

         Future<List<RaceDetails>> fetchRaceData() async {
           var url = Uri.parse('http://ergast.com/api/f1/$year/$round.json');

           var response = await http.get(url);

           if (response.statusCode == 200) {
                 List<RaceDetails> raceDetailsList = [];
                 var jsonData = json.decode(response.body);
                 var racesData = jsonData['MRData']['RaceTable']['Races'];



                 for (var raceData in racesData) {
                 String thirdPracticeDate = '';
                 String thirdPracticeTime = '';
                 String type = '';

                         if (raceData.containsKey('ThirdPractice')) {
                           thirdPracticeDate = raceData['ThirdPractice']['date'];
                           thirdPracticeTime = raceData['ThirdPractice']['time'];
                           type = "ThirdPractice";
                         } else if (raceData.containsKey('Sprint')) {
                           thirdPracticeDate = raceData['Sprint']['date'];
                           thirdPracticeTime = raceData['Sprint']['time'];
                           type = "Sprint";
                         }
                 var raceDetails = RaceDetails(
                      raceName: raceData['raceName'],
                      date: raceData['date'],
                      time: raceData['time'],
                      circuitName: raceData['Circuit']['circuitName'],
                      countryImage: '#',
                      firstPracticeDate: raceData['FirstPractice']['date'],
                      secondPracticeDate: raceData['SecondPractice']['date'],
                      thirdPracticeDate: thirdPracticeDate,
                      QualifyingDate: raceData['Qualifying']['date'],
                      firstPracticeTime: raceData['FirstPractice']['time'],
                      secondPracticeTime: raceData['SecondPractice']['time'],
                      thirdPracticeTime: thirdPracticeTime,
                      QualifyingTime: raceData['Qualifying']['time'],
                      type: type,
                    );

                    raceDetailsList.add(raceDetails);
                    }
                    return raceDetailsList;
                 }
                 else {
                 throw Exception('Failed to load data');
               }
         }

         Future<List<RaceResults>> fetchRaceResults() async {
                    var url = Uri.parse('http://ergast.com/api/f1/$year/$round/results.json');

                    var response = await http.get(url);

                    if (response.statusCode == 200) {
                          List<RaceResults> raceResultsList = [];
                          var jsonData = json.decode(response.body);
                          var racesData = jsonData['MRData']['RaceTable']['Races'][0]['Results'];

                          for (var raceData in racesData) {

                          var raceResults = RaceResults(
                               position: raceData['position'].toString(),
                               PrenomPilote: raceData['Driver']['givenName'],
                               NomPilote: raceData['Driver']['familyName'],
                               Equipe: raceData['Constructor']['name'],
                             );
                             raceResultsList.add(raceResults);
                             }
                             return raceResultsList;
                          }
                          else {
                          throw Exception('Failed to load data');
                        }
                  }
}
