import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tesseractmeetup/authService.dart';
import 'package:tesseractmeetup/loginpage.dart';
import 'package:tesseractmeetup/main.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _retype = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthenticationService>(context);
    return Scaffold(
      key: _key,
      appBar: AppBar(
        title: Text("Register"),
      ),
      body: Form(
        key: _formKey,
        child: Center(
          child: ListView(
            shrinkWrap: true,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  controller: _email,
                  validator: (value) =>
                      value.isEmpty ? "Email cannot be empty" : null,
                  decoration: InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  controller: _password,
                  obscureText: true,
                  validator: (value) =>
                      value.isEmpty ? "Password cannot be empty" : null,
                  decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.vpn_key),
                      border: OutlineInputBorder()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  controller: _retype,
                  obscureText: true,
                  validator: (value) => value.isEmpty
                      ? "This cannot be empty"
                      : value == _password.text
                          ? null
                          : "Both passwords do not match",
                  decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      prefixIcon: Icon(Icons.vpn_key),
                      border: OutlineInputBorder()),
                ),
              ),
              user.status == Status.Authenticating
                  ? Center(child: CircularProgressIndicator())
                  : Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.red,
                        child: MaterialButton(
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              if (!await user.singUp(
                                  _email.text, _password.text)) {
                                _key.currentState.showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        "Failed to register, please try again"),
                                  ),
                                );
                              }
                              else{
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
                              }
                            }
                          }, //Onpress ends here
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                  child: Text("Login"))
            ],
          ),
        ),
      ),
    );
  }
}
