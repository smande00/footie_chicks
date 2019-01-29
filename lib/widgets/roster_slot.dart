import 'package:flutter/material.dart';
import 'package:footie_chicks/models/player.dart';
import 'package:footie_chicks/blocs/provider.dart';

class RosterSlotWidget extends StatelessWidget {
  final Player player;
 
  const RosterSlotWidget({Key key, this.player}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
        return  LongPressDraggable<Player>(
                  hapticFeedbackOnStart: true,
                  data: this.player,
                  feedback: Icon(Icons.person),
                  child:Container(
                    margin: EdgeInsets.all(5),
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      gradient: getPlayerColor(Theme.of(context)),
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.all(Radius.elliptical(15, 15))),
                    child: Column(
                          children:[
                            Text(player?.name ?? ""),
                            getPlayerCurrentTimeWidget(context),
                            getPlayerTotalTimeWidget(context),
                          ]),
                ));
      //});
  }
  
  getPlayerCurrentTimeWidget(context){
    return StreamBuilder(
          stream: BlocProvider.of(context).gameTimerStream.stream,
          builder: (context, AsyncSnapshot<Duration> snapshot) {
            var currentPlayTime =  BlocProvider.of(context).currentRoster.players[player.id]?.playTimeCurrent;

            return Text( "Current: " + (currentPlayTime / 60).floor().toString() + ":" + (currentPlayTime % 60).toString(), style: Theme.of(context).textTheme.caption);
          });
  }

  getPlayerTotalTimeWidget(context){
      return StreamBuilder(
            stream: BlocProvider.of(context).gameTimerStream.stream,
            builder: (context, AsyncSnapshot<Duration> snapshot) {
              var totalPlayTime =  BlocProvider.of(context).currentRoster.players[player.id]?.playTimeTotal;
              return Text("Total: " + (totalPlayTime / 60).floor().toString() + ":" + (totalPlayTime %60).toString(), style: Theme.of(context).textTheme.caption,);
            });
    }


  getPlayerColor(ThemeData theme){    
    if(player?.currentPosition != null){
        return LinearGradient(colors:[theme.primaryColorDark, theme.primaryColorLight] ); 
    }
    else
      return LinearGradient(colors:[theme.primaryColorLight, theme.secondaryHeaderColor] );
  }
}
