import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


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


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  String? username = getUsernameFromFirebase();
  String? userProfilePic = getPhotoUrlFromFirebase();
    return MaterialApp(
          home: Scaffold(
            appBar: AppBar(
              title: Text(username != null ? username : 'Utilisateur inconnu'),
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
              child: Text('Contenu de la page'),
            ),
          ),
        );
      }
    }