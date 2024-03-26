import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'login_page.dart';
import 'home_page.dart';
import 'inscription_page.dart';
import 'user_page.dart';
import 'history.dart';
import 'schedule.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
        appId: '1:1046508604035:android:cec2c41c15e16f52f5e9b6',
        apiKey: 'AIzaSyCfrl0x82tiORaD2uw5KWfgmckZxSo90uk',
        projectId: 'actuf1-e7ce5',
        messagingSenderId: '1046508604035',
        measurementId: '432656429',
        ),
     );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
    Widget build(BuildContext context) {
      return MaterialApp(
        title: 'Actu F1',
        routes: {
        '/login': (context) => LoginPage(),
        '/register': (context) => InscriptionPage(),
        '/home': (context) => HomePage(),
        '/user-page': (context) => UserPage(),
        '/history': (context) => History(),
        '/schedule': (context) => Schedule(),
        },
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
                onPressed: () {
                Navigator.pushNamed(context, '/login');
                },
                child: Container(
                  width: 250,
                  height: 65,
                  alignment: Alignment.center,
                  child: Text(
                    'Connexion',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                Navigator.pushNamed(context, '/register');
                },
                child: Container(
                  width: 250,
                  height: 65,
                  alignment: Alignment.center,
                  child: Text(
                      'Inscription',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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