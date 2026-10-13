import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tababa/firebase_options.dart';
import 'package:tababa/screens/login_screen.dart';
import 'package:tababa/screens/nav_bar.dart';
import 'package:tababa/screens/splash_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
// FirebaseAuth.instance.signOut();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      home:userState()  ,
    );
  }
  StreamBuilder<User?>userState(){
    return StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(), 
    builder: (context,snapshot){
      if(snapshot.connectionState==ConnectionState.waiting)
      {
        return Scaffold(body: Center(child: CircularProgressIndicator(),),);
      }
      if(snapshot.hasData)
      {
        return NavBar();
      }
      return LoginScreen();

    });
  }
}
