import 'package:flutter/material.dart';
import 'package:flutter_bug/blug.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bug/firebase/home.dart';

void main()  {
  // await Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

class App extends StatefulWidget {
  // Create the initialization Future outside of `build`:
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
   bool _initialized = false;
  bool _error = false;

  // Define an async function to initialize FlutterFire
  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp(); 
      setState(() {
        _initialized = true;
      });


    } catch(e) {

    } catch(e) {
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
   if(_error) {


      return MyApp();

      // return Container();


      // return Container();

    }

    // Show a loader until FlutterFire is initialized
    if (!_initialized) {


      return MyApp();

      // return Container();


      // return Container();

    }

    return MyApp();
  }
}

class MyApp extends StatelessWidget {
  // final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      // theme: ThemeData(
      //   primarySwatch: Colors.green,
      // ),
      home: BoardApp(),
      // FlutterBlug()
      
    );
  }
}

