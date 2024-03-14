import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
    Widget build(BuildContext context) {
      return MaterialApp(
        title: 'Actu F1',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: MyHomePage(title: 'Page Accueil'),
      );
    }
  }

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/Accueil.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                color: Colors.white.withOpacity(0.2),
                child:Container(
                  width: 225,
                  height: 180,
                  child: Image.asset('assets/images/Logo.png'),
                ),
              ),
              SizedBox(height: 250),
              ElevatedButton(
                onPressed: () {},
                child: Container(
                  width: 250, // Définissez la largeur souhaitée ici
                  height: 65, // Définissez la hauteur souhaitée ici
                  alignment: Alignment.center,
                  child: Text(
                    'Connexion',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFFF0000)),
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          side: BorderSide(color: Colors.black)
                      )
                  ),
                ),
              ),
              SizedBox(height: 20), // Ajoutez de l'espace entre les boutons
              ElevatedButton(
                onPressed: () {},
                child: Container(
                  width: 250, // Définissez la largeur souhaitée ici
                  height: 65, // Définissez la hauteur souhaitée ici
                  alignment: Alignment.center,
                  child: Text(
                      'Inscription',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFFF0000)),
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          side: BorderSide(color: Colors.black)
                      )
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}