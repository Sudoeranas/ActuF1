import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


String? getUsernameFromFirebase() {
  User? user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    return user.displayName;
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

  Future<void> updateUsername(String username) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.updateDisplayName(username);
    }
  }

  class UserPage extends StatefulWidget {
    @override
    _UserPageState createState() => _UserPageState();
  }

class _UserPageState extends State<UserPage> {
final _editUsernameController = TextEditingController();
String _username = "Utilisateur inconnu";
@override
  void initState() {
    super.initState();
    _username = getUsernameFromFirebase() ?? "Utilisateur inconnu";
  }

  Future<void> _showEditUsernameDialog() async {
      return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Mettre à jour le nom d\'utilisateur'),
            content: TextField(
              controller: _editUsernameController,
              decoration: InputDecoration(hintText: "Entrez le nouveau nom d'utilisateur"),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Annuler'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text('Confirmer'),
                onPressed: () async {
                  await updateUsername(_editUsernameController.text);
                  setState(() {
                    _username = _editUsernameController.text;
                  });
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

 @override
   Widget build(BuildContext context) {
     String? userProfilePic = getPhotoUrlFromFirebase();
     return Scaffold(
       appBar: AppBar(),
       body: Column(
         mainAxisAlignment: MainAxisAlignment.start,
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
           Center(
             child: Text(
               _username,
               style: TextStyle(fontSize: 24),
             ),
           ),
           SizedBox(height: 10),
           ElevatedButton(
             onPressed: _showEditUsernameDialog,
             child: Text('Modifier le nom d\'utilisateur'),
           ),
           SizedBox(height: 20),
           Expanded(
             child: Align(
               alignment: Alignment.bottomCenter,
               child: ElevatedButton(
                 onPressed: () {
                   FirebaseAuth.instance.signOut();
                   Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
                 },
                 style: ButtonStyle(
                   minimumSize: MaterialStateProperty.all(Size(250, 65)),
                   backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFFF0000)),
                   foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                 ),
                 child: Text('Se déconnecter', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
               ),
             ),
           ),
           SizedBox(height: 20),
           Align(
             alignment: Alignment.bottomCenter,
             child: Padding(
               padding: EdgeInsets.only(bottom: 20),
               child: Text('Version: 1.0.0'),
             ),
           ),
         ],
       ),
     );
   }
 }