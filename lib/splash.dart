import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color(0xfff7ff63),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              backgroundColor: Color(0xff6C63FF),
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xffffb663)),
            ),
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Text("Initialising...", style: TextStyle(fontSize: 20),),
            ),
          ],
        ),
      ),
      
    );
  }
}