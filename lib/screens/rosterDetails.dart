import 'package:flutter/material.dart';
import '../blocs/provider.dart';
import '../models/player.dart';
import '../models/roster.dart';
import '../screens/editPlayer.dart';

class RosterDetails extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Roster Management"),  
        actions: <Widget>[
          FloatingActionButton(
            mini: true,
            backgroundColor: Theme.of(context).highlightColor,
            onPressed: (){
              if(bloc.currentRoster == null){
                bloc.setRoster(Roster(name:"New Roster", players: Map<int,Player>() ));
              } 
              var player = Player(name:"New Player");
              bloc.addPlayerToCurrentRoster(player);
            },  
            child:Icon(Icons.add), 
            ),
        ]),
      backgroundColor: Theme.of(context).backgroundColor,
      bottomSheet: Text("I'm a bottom sheet"),
      body: StreamBuilder(
          stream: bloc.rosterUpdateStream.stream,
          builder: (context, AsyncSnapshot<void> snapshot) {
            return 
            Center(child: ListView.builder(
              itemCount: bloc.currentRoster != null ? bloc.currentRoster.players.length : 0,
              itemBuilder: (context, int) {
                final player = bloc.currentRoster.players.values.toList()[int];              
                return 
                  Dismissible(background: Container(color: Colors.red),
                    key: Key(player.id.toString()),
                    onDismissed: (direction)=>bloc.deleteRosterPlayer(player.id),
                    child: GestureDetector(
                      onDoubleTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => EditPlayer(player:player)));
                      },
                      
                      child: buildPlayerCard(context, player)
                    ));
            },
          ));
        })
    );
  }

  Widget buildPlayerCard(BuildContext context, Player player) {
      return 
        Container(constraints: BoxConstraints(minWidth: double.infinity),
            margin: EdgeInsets.all(5),
           // padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Theme.of(context).backgroundColor, Theme.of(context).secondaryHeaderColor]),
              border: Border.all(),
              borderRadius: BorderRadius.all(Radius.elliptical(15, 15)) ),
            child: ExpansionTile(key: PageStorageKey<Player>(player), 
              title:  Text(player.name), 
              children: <Widget>[
                Text("Lets show some cool player stats here"),
                Text("Or maybe we should show an edit form"),
                Text("Running out of stuff to say but I want more space")

              ]), 
          );

     /* ;*/
  }

}
