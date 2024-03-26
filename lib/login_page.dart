import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn(clientId: '1046508604035-dce07s8ood1ku1un2foussspgkaocemf.apps.googleusercontent.com');
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

Future<void> _resetPassword(String email) async {
  try {
    await _auth.sendPasswordResetEmail(email: email);
    // Afficher un message indiquant que l'e-mail de réinitialisation a été envoyé.
  } catch (e) {
    print(e);
    // Gérer les erreurs.
  }
}

Future<void> _signInWithEmailPassword(BuildContext context) async {
    try {
      UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      Navigator.pushNamed(context, '/home');
    } on FirebaseAuthException catch (e) {
        print(e);
        String errorMessage = '';
      if (e.code == 'user-not-found') {
        errorMessage = 'Aucun utilisateur trouvé pour cet email.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Mot de passe incorrect.';
      }else{
      errorMessage = 'Une erreur s\'est produite. Veuillez réessayer.';
      }
      showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('Erreur de connexion'),
                content: Text(errorMessage),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('OK'),
                  ),
                ],
              ),
            );
    } catch (e) {
      print(e);
    }
  }

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
      body: Container(
      decoration: BoxDecoration(
        image: DecorationImage(
        image: AssetImage('assets/images/Accueil.png'),

       ),
      ),
      padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Container(
            color: Colors.white.withOpacity(0.2),
            child:Container(
              width: 225,
              height: 180,
              child: Image.asset('assets/images/Logo.png'),
              ),
            ),
            SizedBox(height: 250),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                    labelText: 'Email',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                ),
              SizedBox(height: 10),
                   TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                        labelText: 'Mot de passe',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          ),
                    ),
                    obscureText: true,
                 ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () => _signInWithEmailPassword(context),
                style: ButtonStyle( // Modifier le style du bouton
                  minimumSize: MaterialStateProperty.all(Size(250, 65)),
                  backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFFF0000)),
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  ),
                child: Text('Se connecter'),
              ),
            Text(
              'OU',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                Map<String, dynamic>? user = await _signInWithGoogle();
                if (user != null) {
                  Navigator.pushNamed(
                  context,
                  '/home',
                  arguments: await _signInWithGoogle(),
                );
              }
            },
            style: ButtonStyle(
              minimumSize: MaterialStateProperty.all(Size(250, 65)),
              backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFFF0000)),
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
            child: Text('Se connecter avec Google'),
            ),
                  TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Réinitialiser le mot de passe'),
                          content: TextField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              labelText: 'Email',
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                _resetPassword(_emailController.text);
                                Navigator.pop(context);
                              },
                              child: Text('Envoyer'),
                            ),
                          ],
                        ),
                      );
                    },
                    child: Text('Mot de passe oublié?'),
                    ),
          ],
        ),
      ),
    );
  }
}