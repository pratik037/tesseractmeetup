import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:tesseractmeetup/authService.dart';
import 'package:tesseractmeetup/registerpage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();
  TextStyle style = TextStyle(color: Colors.white, fontSize: 20);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthenticationService>(context);
    return Scaffold(
      backgroundColor: Color(0xff6C63FF),
      key: _key,
      appBar: AppBar(
        title: Text(
          'Login',
          style: TextStyle(fontSize: 30),
        ),
        backgroundColor: Color(0xff6C63FF),
        elevation: 0,
        centerTitle: true,
      ),
      body: ListView(
        children: [
          SvgPicture.asset(
            'assets/images/login.svg',
            height: 200,
          ),
          Form(
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
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                              gapPadding: 30),
                          enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                              borderSide: BorderSide(color: Colors.black)),
                          labelText: 'Email',
                          labelStyle: style,
                          prefixIcon: Icon(
                            Icons.email,
                            color: Colors.white,
                          ),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)))),
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
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                              gapPadding: 30),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                              gapPadding: 30),
                          labelText: 'Password',
                          labelStyle: style,
                          prefixIcon: Icon(
                            Icons.vpn_key,
                            color: Colors.white,
                          ),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)))),
                    ),
                  ),
                  user.status == Status.Authenticating
                      ? Center(
                          child: CircularProgressIndicator(
                            backgroundColor: Color(0xff6C63FF),
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Color(0xffffb663)),
                          ),
                        )
                      : Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Material(
                            elevation: 5,
                            borderRadius: BorderRadius.circular(30),
                            color: Color(0xffffb663),
                            child: MaterialButton(
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  if (!await user.signIn(
                                      _email.text, _password.text)) {
                                    _key.currentState.showSnackBar(SnackBar(
                                        content: Text(
                                            "Verify the credentials again")));
                                  }
                                }
                              }, //Onpress ends here
                              child: Text(
                                "Sign In",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                  FlatButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => RegisterPage()));
                      },
                      child: Text(
                        "Register",
                        style: TextStyle(color: Colors.white),
                      ))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }
}
