import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class InscriptionPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  Future<void> _registerWithEmailAndPassword(BuildContext context) async {
    try {
      if (_passwordController.text != _confirmPasswordController.text) {
        throw FirebaseAuthException(code: 'passwords-not-match', message: 'Les mots de passe ne correspondent pas.');
      }

      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      // Inscription réussie, rediriger vers la page d'accueil
      Navigator.pushNamed(context, '/home');
    } on FirebaseAuthException catch (e) {
      String errorMessage = '';
      if (e.code == 'email-already-in-use') {
        errorMessage = 'Cet e-mail est déjà utilisé par un autre compte.';
      } else if (e.code == 'weak-password') {
        errorMessage = 'Le mot de passe est trop faible.';
      } else if (e.code == 'passwords-not-match') {
        errorMessage = 'Les mots de passe ne correspondent pas.';
      } else {
        errorMessage = 'Une erreur s\'est produite. Veuillez réessayer.';
      }

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Erreur d\'inscription'),
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
            SizedBox(height: 10),
            TextField(
              controller: _confirmPasswordController,
              decoration: InputDecoration(
              labelText: 'Confirmer le mot de passe',
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              ),
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _registerWithEmailAndPassword(context),
              style: ButtonStyle( // Modifier le style du bouton
                minimumSize: MaterialStateProperty.all(Size(250, 65)),
                backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFFF0000)),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                ),
              child: Text('S\'inscrire'),
            ),
          ],
        ),
      ),
    );
  }
}
