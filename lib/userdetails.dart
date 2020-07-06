import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tesseractmeetup/authService.dart';

class UserDetails extends StatelessWidget {
  final FirebaseUser user;

  const UserDetails({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xff6C63FF)
              ),
              accountName: Text(user.displayName),
              accountEmail: Text(user.email),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Color(0xffffb663),
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Color(0xffffb663),
        title: Text("User Details"),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () =>
                Provider.of<AuthenticationService>(context, listen: false)
                    .signout(),
          )
        ],
      ),
      body: Column(
        children: [
          Center(
            child: Container(
              child: Text(user.email),
            ),
          )
        ],
      ),
    );
  }
}
