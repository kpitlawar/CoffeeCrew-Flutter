import 'package:firebaseApp/models/brew.dart';
import 'package:firebaseApp/screens/home/brew_list.dart';
import 'package:firebaseApp/screens/home/settings_form.dart';
import 'package:firebaseApp/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:firebaseApp/services/database.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {

  final AuthService _authService = AuthService();
  @override
  Widget build(BuildContext context) {


    void _showSettingsPanel(){
        showModalBottomSheet(context: context, builder: (context){
          return Container(
            padding: EdgeInsets.symmetric(vertical:20.0, horizontal: 50.0),
            child: SettingsForm(),
          );
        });
    }

    return StreamProvider<List<Brew>>.value(
      value: DatabaserServcie().brews,
          child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(title: Text('Welcome to Brew Crew'),
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        actions: [
          FlatButton.icon(onPressed: () async{
            await _authService.signOut(); 
          
          }, icon: Icon(Icons.person), label: Text('Logout')),
          FlatButton.icon(onPressed: (){
            _showSettingsPanel();
          }, icon: Icon(Icons.settings), label: Text('Settings'))
        ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(
              'assets/coffee_bg.png'
            ),
            fit: BoxFit.cover)
          ),
          child: BrewList( )),
      ),
    );
  }
}