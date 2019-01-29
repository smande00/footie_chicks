import 'package:flutter/material.dart';
import 'roster_slot.dart';
import 'game_field_row.dart';
import 'package:footie_chicks/models/formation.dart';

import 'package:footie_chicks/blocs/provider.dart';

class GameFieldWidget extends StatelessWidget {
  
  final Formation formation;
  const GameFieldWidget({Key key, this.formation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return 
      Column(children: [
        Expanded(
            child: 
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildFormation(context),
                  Container(
                      constraints: BoxConstraints(minWidth: 150, maxWidth: 150),
                      child: _buildRosterList(context))
        ])),
      
    ]);
  }

  Widget _buildFormation(BuildContext context) {
    return Flexible(
        child: Column(
          children:[
            Expanded( child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: formation.formationRows
                      .map((row) => GameFieldRowWidget(
                            positions: row.positions
                            
                          ))
                      .toList()))),
            _buildTimerRow(context),
            ]));
  }

  Widget _buildTimerRow(BuildContext context) {
    final bloc= BlocProvider.of(context);
    return 
        StreamBuilder(
          stream: bloc.gameTimerStream.stream,
          builder: (context, AsyncSnapshot<Duration> snapshot) {
            return Container(
              constraints: BoxConstraints(minHeight: 60),
              child: Row(
                children: [
                           bloc.isTimerRunning() ? IconButton(icon:Icon(Icons.pause), onPressed:(){bloc.stopTimer();}) : 
                           IconButton(icon:Icon(Icons.play_arrow), onPressed:(){bloc.startTimer();},),  
                           Text(snapshot.hasData ? (snapshot.data.inMinutes.toString() + ":" + (snapshot.data.inSeconds % 60).toString()) : "0")]));
          });
  }

  
  
  StreamBuilder _buildRosterList(context) {
    final bloc = BlocProvider.of(context);
    return 
      StreamBuilder(
        stream:bloc.assignmentStream.stream,
        builder: (context,AsyncSnapshot<void> snapshot){
          return
           StreamBuilder(
            stream: bloc.rosterUpdateStream.stream,
            builder: (context, AsyncSnapshot<void> snapshot) {
              return ListView.builder(
                itemCount: bloc.currentRoster != null ? bloc.currentRoster.players.length : 0,
                itemBuilder: (context, index) {
                  var playerList = bloc.currentRoster.players.values.toList();
                  playerList.sort((p1,p2){
                      if(p1.currentPosition!=null && p2.currentPosition == null) 
                        return -1;
                      else if(p2.currentPosition != null && p1.currentPosition == null)
                        return 1;
                      else 
                        return 0;
                  });
                  return RosterSlotWidget(player: playerList[index]);
                },
              );
            });
        });
  
     

    }    
  }
