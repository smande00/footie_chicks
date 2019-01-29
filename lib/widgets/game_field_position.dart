import 'package:flutter/material.dart';
import 'package:footie_chicks/models/player.dart';
import 'package:footie_chicks/models/formation_position.dart';
import 'package:footie_chicks/blocs/provider.dart';

class GameFieldPositionWidget extends StatelessWidget {
  final FormationPosition position;
  
  const GameFieldPositionWidget(
      {Key key, this.position})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    
         return Container(
            
                padding: EdgeInsets.all(10),
                child: 
                  DragTarget<Player>(
                    builder: (context,
                      List<Player> candidateData, rejectedData) {
                        return Column(children: [
                          Icon(Icons.person),
                          Text(position.name),
                          getPlayerTextWidget(Theme.of(context), BlocProvider.of(context))
                        ]);
                      }, 
                    onWillAccept: (Player data) {
                      return true;
                    }, 
                    onAccept: (Player data) {
                       BlocProvider.of(context).assignPlayer(data, this.position);
                      }));
           
      //});
  }


  getPlayerTextWidget(ThemeData theme, Bloc bloc){
    final player = bloc.getPlayerAtPosition(position);
    if( player != null){
      return  Text(player.name, style: theme.textTheme.title,);
    }
    return Text("Unassigned", style: TextStyle(color: theme.errorColor),);
  }
}