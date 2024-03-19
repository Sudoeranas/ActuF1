import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  final Map<String, dynamic>? args =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
      final String? userProfilePic = args?['userProfilePic'];
    return Scaffold(
      appBar: AppBar(
        title: Text('Accueil'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            userProfilePic != null
                ? CircleAvatar(
                    backgroundImage: NetworkImage(userProfilePic!),
                    radius: 50,
                  )
                : SizedBox(), // Placeholder si l'image de profil est indisponible
            SizedBox(height: 20),
            Text('Bienvenue sur la page d\'accueil'),
            // Autres widgets de la page d'accueil...
          ],
        ),
      ),
    );
  }
}