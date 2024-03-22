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

class UserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   String? username = getUsernameFromFirebase();
   String? userProfilePic = getPhotoUrlFromFirebase();
    return Scaffold(
      appBar: AppBar(
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 20),
          CircleAvatar(
            backgroundColor: Colors.grey,
                                backgroundImage: userProfilePic != null
                                      ? NetworkImage(userProfilePic)
                                      : AssetImage('assets/images/default_profile_pic.png') as ImageProvider,
                                   radius: 60,
          ),
          SizedBox(height: 20),
          Text(
            username != null ? username : 'Utilisateur inconnu',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
            },
            style: ButtonStyle( // Modifier le style du bouton
                          minimumSize: MaterialStateProperty.all(Size(250, 65)),
                          backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFFF0000)),
                          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                          ),
            child: Text('Se déconnecter', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Text('Version: 1.0.0'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}