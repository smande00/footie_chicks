import 'package:flutter/material.dart';
import '../blocs/provider.dart';
import '../models/player.dart';
import '../models/roster.dart';
import '../screens/editPlayer.dart';

class RosterDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Roster Management"),        
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      floatingActionButton: FloatingActionButton(child:IconButton(
        icon:Icon(Icons.add), 
        onPressed: (){
          if(bloc.currentRoster == null){
            bloc.setRoster(Roster(name:"New Roster", players: Map<int,Player>() ));
          }
          
          var player = Player(name:"New Player");
          bloc.addPlayerToCurrentRoster(player);
        },)),

      body: StreamBuilder(
          stream: bloc.rosterUpdateStream.stream,
          builder: (context, AsyncSnapshot<void> snapshot) {
            return 
            Center(
              child: ListView.builder(
            itemCount: bloc.currentRoster != null ? bloc.currentRoster.players.length : 0,
            itemBuilder: (context, int) {
              final player = bloc.currentRoster.players.values.toList()[int];              
              return 
                Dismissible(
                  background: Container(color: Colors.red),
                  key: Key(player.id.toString()),
                  onDismissed: (direction)=>bloc.deleteRosterPlayer(player.id),
                  child:
                    GestureDetector(
                      onDoubleTap: (){
                         Navigator.push(context, MaterialPageRoute(builder: (context) => EditPlayer(player:player)));
                      },
                      child:
                        Container(
                          constraints: BoxConstraints(minWidth: double.infinity),
                          margin: EdgeInsets.all(5),
                          padding: EdgeInsets.all(15),
                          decoration: 
                            BoxDecoration(
                              gradient: LinearGradient(colors: [Theme.of(context).backgroundColor, Theme.of(context).secondaryHeaderColor]),
                              border: Border.all(),
                              borderRadius: BorderRadius.all(Radius.elliptical(15, 15)) ),
                          child: Text(player.name),)
                  ));
            },
          ));
        })
    );
  }
}
