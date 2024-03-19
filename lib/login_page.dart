import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn(clientId: '1046508604035-dce07s8ood1ku1un2foussspgkaocemf.apps.googleusercontent.com');

Future<Map<String, dynamic>?> _signInWithGoogle() async {
  try {
    final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      final UserCredential authResult = await _auth.signInWithCredential(credential);
      final User? user = authResult.user;

      String? userProfilePic = googleSignInAccount.photoUrl;

      return {
        'user': user,
        'userProfilePic': userProfilePic,
      };
    }
  } catch (error) {
    print(error);
  }
  return null;
}

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // TODO: Ajouter la connexion par e-mail et mot de passe
              },
              child: Text('Se connecter avec e-mail et mot de passe'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                Map<String, dynamic>? user = await _signInWithGoogle();
                if (user != null) {
                  print("Connexion réussie");
                  Navigator.pushNamed(
                    context,
                    '/home',
                    arguments: await _signInWithGoogle(),
                  );
                } else {
                  print("Connexion échouée");
                }
              },
              child: Text('Se connecter avec Google'),
            ),
          ],
        ),
      ),
    );
  }
}