import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'history.dart';
import 'schedule.dart';
import 'team.dart';
import 'driver.dart';


String? getUsernameFromFirebase() {
  User? user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    return user.displayName; // Récupère le nom d'utilisateur
  } else {
    return null;
  }
}

String? getPhotoUrlFromFirebase() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.photoURL; // Récupère l'URL de la photo de profil
    } else {
      return null;
    }
  }

class HomePage extends StatefulWidget {
const HomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  static const List<Widget?> _widgetOptions = <Widget?>[
      null,
      Schedule(),
      Driver(),
      Team(),
      History(),
    ];
    void _onItemTapped(int index) {
        setState(() {
          _selectedIndex = index;
        });
      }
  @override
  Widget build(BuildContext context) {
  String? username = getUsernameFromFirebase();
  String? userProfilePic = getPhotoUrlFromFirebase();

  Widget? selectedWidget = _widgetOptions[_selectedIndex];

    return Scaffold(
            appBar: AppBar(
              title: Text("Hello, ${username != null ? username : 'Utilisateur inconnu'}"),
              actions: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/user-page');
                  },
                  child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: CircleAvatar(
                    backgroundColor: Colors.grey,
                    backgroundImage: userProfilePic != null
                          ? NetworkImage(userProfilePic)
                          : AssetImage('assets/images/default_profile_pic.png') as ImageProvider,
                       radius: 25,
                    ),
                  ),
                ),
              ],
            ),
            body: Center(
              child: selectedWidget ?? Container(
                    child: Text('Contenu de la page d"accueil'),
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
                  items: <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      label: 'Accueil',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.calendar_today_outlined),
                      label: 'Calendrier',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.headphones),
                      label: 'Classement Pilote',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.people),
                      label: 'Classement Ecurie',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.flag),
                      label: 'Historique',
                    ),
                  ],
                  currentIndex: _selectedIndex,
                  selectedItemColor: Colors.red,
                  onTap: _onItemTapped,
                ),
              );
             }
            }