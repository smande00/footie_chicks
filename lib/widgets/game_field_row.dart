import 'dart:async';
import 'package:flutter/material.dart';
import 'package:footie_chicks/models/formation_position.dart';
import 'package:footie_chicks/models/player.dart';
import 'game_field_position.dart';
import 'package:footie_chicks/blocs/provider.dart';

class GameFieldRowWidget extends StatelessWidget {
  final List<FormationPosition> positions;
  const GameFieldRowWidget({Key key, this.positions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of(context);
    return StreamBuilder(
        stream: bloc.assignmentStream.stream,
        builder: (context, AsyncSnapshot<MapEntry> snapshot) {
          return Container(
          child:Row(
              children: positions
                  .map((position) => Expanded(
                      child: Center(
                          child: Draggable<Player>(
                              child: GameFieldPositionWidget(
                                position: position
                              ),
                              data: (bloc.getPlayerAtPosition(position) ?? null),
                              feedback: Icon(Icons.person),
                              childWhenDragging: GameFieldPositionWidget(   
                                  position: position)))))
                  .toList()));
       });
  }
}
