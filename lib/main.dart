import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tesseractmeetup/authService.dart';
import 'package:tesseractmeetup/loginpage.dart';
import 'package:tesseractmeetup/splash.dart';
import 'package:tesseractmeetup/userdetails.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthenticationService.instance(),  
          child: MaterialApp(
        home: HomePage(),
        debugShowCheckedModeBanner: false,
        title: 'Tesseract Meetup',
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, AuthenticationService user, _){
        switch(user.status){
          case Status.Uninitialised:
            return Splash();

          case Status.Unaunthenticated:
          case Status.Authenticating:
            return LoginPage();
          case Status.Authenticated:
          return UserDetails(user: user.user);
        }
      });
  }
}
