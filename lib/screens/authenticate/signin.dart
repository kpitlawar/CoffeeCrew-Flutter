import 'package:firebaseApp/services/auth.dart';
import 'package:firebaseApp/shared/constants.dart';
import 'package:firebaseApp/shared/loading.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {

   final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _authService = AuthService();
   final _formKey = GlobalKey<FormState>(); // validation

   bool loading = false;

  // text field state
  String email ='';
  String password = '';
   String error = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() :
    Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign In'),
        actions: [
          FlatButton.icon(onPressed: (){
             widget.toggleView();
          }, icon: Icon(Icons.person), label: Text('Register'))
        ],
      ),
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
           key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                   decoration: textInputDecorator.copyWith(hintText:'Email'),
                      validator: (val) => val.isEmpty ? 'Enter an email' : null,
                  onChanged: (val) {
                    setState(() {
                      email = val;
                    });
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                   decoration: textInputDecorator.copyWith(hintText:'Password'),
                    validator: (val) => val.length < 6 ? 'Enter a password 6+ char long' : null,
                  obscureText: true,
                  onChanged: (val) {
                    setState(() {
                      password = val;
                    });
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                RaisedButton(
                  onPressed: () async{
                       if (_formKey.currentState.validate()) {
                        setState(() {
                          loading = true;
                        });
                    dynamic result = await _authService.signInWithEmailPassword(email, password);
                     if(result == null){
                        setState(() {
                          error = "COULD NOT SIGN IN WITH THOSE CREDENTIALS";
                          loading = false;
                        });
                     }
                    }
                  },
                  child: Text('Sign In', style: TextStyle(color:Colors.white),),
                  color: Colors.pink[400],
                ),
                SizedBox(height: 12,),
                Text(error, style: TextStyle(color: Colors.red, fontSize: 14),)
              ],
            ),
          )),
    );
  }
}
