import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/home_screen.dart';
import 'screens/profile_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Eco Connect',
      theme: ThemeData(
        primaryColor: Color(0xFF4D8D6E),
        colorScheme: ColorScheme.light(
          primary: Color(0xFF4D8D6E),
          secondary: Color(0xFF4D8D6E),
        ),
        fontFamily: 'Roboto',
      ),
      home: AuthenticationWrapper(),
      routes: {
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignupScreen(),
        '/home': (context) => HomeScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          User? user = snapshot.data;
          if (user == null) {
            // User is not signed in, show login screen
            return LoginScreen();
          } else {
            // User is signed in, redirect to home screen
            return HomeScreen();
          }
        }

        // While waiting for the authentication state, show a loading indicator
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(
              color: Color(0xFF4D8D6E),
            ),
          ),
        );
      },
    );
  }
}

