import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

enum Status{Uninitialised, Unaunthenticated, Authenticating, Authenticated}
//  UnRegistered, Registering, Registered}

class AuthenticationService extends ChangeNotifier{
  FirebaseAuth _auth;

  FirebaseUser _user;

  Status _status = Status.Uninitialised;


// initializing FirebaseAuth object and listening to authentication Changes in Authservice Instance constructor
  AuthenticationService.instance() : _auth = FirebaseAuth.instance{
    _auth.onAuthStateChanged.listen(_onAuthStateChanged);
  }

  Future<void> _onAuthStateChanged(FirebaseUser firebaseUser)async{
    if(firebaseUser == null){
      _status = Status.Unaunthenticated;
    }
    else{
      _user = firebaseUser;
      _status = Status.Authenticated;
    }
  notifyListeners();
  }

  Status get status => _status;

  FirebaseUser get user => _user;

  Future<bool> signIn(String email, String password) async{
    try{
      _status = Status.Authenticating;
      notifyListeners();

      await _auth.signInWithEmailAndPassword(email: email, password: password);

      return true;

    }catch(e){
      _status = Status.Unaunthenticated;
      notifyListeners();
      return false;
    }
  }

  Future<bool> singUp(String email, String password) async{
    try{
      _status = Status.Authenticating;
      notifyListeners();

      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      _status = Status.Authenticated;
      notifyListeners();

      return true;
    }catch(e){
      _status = Status.Unaunthenticated;
      notifyListeners();
      return false;
    }
  }

  Future signout() async{
    _auth.signOut();
    _status = Status.Unaunthenticated;
    notifyListeners();
    // return Future.delayed(Duration.zero);
  }
}