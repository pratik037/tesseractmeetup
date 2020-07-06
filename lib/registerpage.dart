import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
      backgroundColor: Color(0xff6C63FF),
      key: _key,
      appBar: AppBar(
        title: Text(
          "Register",
          style: TextStyle(fontSize: 30),
        ),
        backgroundColor: Color(0xff6C63FF),
        elevation: 0,
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.only(top: 32),
        children: [
          SvgPicture.asset(
            'assets/images/signup.svg',
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
                              borderSide: BorderSide(color: Colors.white)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          labelText: 'Email',
                          labelStyle: TextStyle(color: Colors.white),
                          prefixIcon: Icon(
                            Icons.email,
                            color: Colors.white,
                          ),
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
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          labelText: 'Password',
                          labelStyle: TextStyle(color: Colors.white),
                          prefixIcon: Icon(
                            Icons.vpn_key,
                            color: Colors.white,
                          ),
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
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          labelStyle: TextStyle(color: Colors.white),
                          labelText: 'Confirm Password',
                          prefixIcon: Icon(
                            Icons.vpn_key,
                            color: Colors.white,
                          ),
                          border: OutlineInputBorder()),
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
                            color: Color(0xffffb663),
                            borderRadius: BorderRadius.circular(30),
                            child: MaterialButton(
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  if (!await user.signUp(
                                      _email.text, _password.text)) {
                                    _key.currentState.showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            "Failed to register, please try again"),
                                      ),
                                    );
                                  } else {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => HomePage()));
                                  }
                                }
                              }, //Onpress ends here
                              child: Text(
                                "Sign Up",
                                style: TextStyle(
                                    color: Colors.black,
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
                    child: Text(
                      "Existing User? Login",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
