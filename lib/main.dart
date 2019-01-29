import 'package:flutter/material.dart';

import 'models/player.dart';
import 'models/formation.dart';
import 'models/formation_position.dart';
import 'models/formation_row.dart';
import 'models/roster.dart';
import 'widgets/game_field.dart';
import 'screens/rosterDetails.dart';

import 'blocs/provider.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Footie Chicks Fustal',
          theme: ThemeData(
            primarySwatch: Colors.teal,
          ),
          home: MyHomePage(title: 'Footie Chicks'),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  Roster getRoster(){
    return new Roster(name:"Footie Chicks 1", players: {
    1: Player(name: "Brooklyn", id:1),
    2: Player(name: "Maddie", id:2),
    3: Player(name: "Carly", id:3),
    4: Player(name: "Reagan", id:4),
    5: Player(name: "Kayleigh", id:5),
    6: Player(name: "Aubree", id:6),
    7: Player(name: "Ruby", id:7)
   });
  }

  final Formation _formation = Formation("Futsal", [
    FormationRow([FormationPosition("Center")]),
    FormationRow([FormationPosition("Left Wing"), FormationPosition("Right Wing")]),
    FormationRow([FormationPosition("Fullback")]),
    FormationRow([FormationPosition("Keeper")]),
  ]);

  
  @override
  Widget build(BuildContext context) {
    final _bloc = BlocProvider.of(context);
   // _bloc.setRoster(getRoster());
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
         Container( 
           padding: EdgeInsets.all(10), 
           child: IconButton(
             icon:Icon(Icons.autorenew), 
             onPressed: (){
               _bloc.setRoster(this.getRoster());
               _bloc.resetGameTimer();
               })
         ),
         Container( 
          padding: EdgeInsets.all(10), 
          child: IconButton(icon:Icon(Icons.people), onPressed:(){
            Navigator.push(context, MaterialPageRoute(builder: (context) => RosterDetails()));
            }            
            )),
         Container( padding: EdgeInsets.all(10), child: Icon(Icons.settings)),
        ]
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body:  Container(
        constraints: BoxConstraints(),
        child: GameFieldWidget(
            formation: _formation)),
      //trailing comma makes auto-formatting nicer for build methods.
    );
  }



}
