import 'dart:async';
import 'package:footie_chicks/models/roster.dart';
import 'package:footie_chicks/models/formation_position.dart';
import 'package:footie_chicks/models/player.dart';
import 'package:vibration/vibration.dart';

class Bloc {

  
  final StreamController<MapEntry> assignmentStream = StreamController<MapEntry>.broadcast();
  final StreamController<Duration> gameTimerStream = StreamController<Duration>.broadcast();
  final StreamController<void> rosterUpdateStream = StreamController<void>.broadcast();


  Roster currentRoster;

  Timer _gameTimer;
  final Stopwatch _gameWatch = Stopwatch();

  void updateRosterPlayer(Player player){
    currentRoster.players[player.id] = player;
    rosterUpdateStream.add(null);
  }
  void addPlayerToCurrentRoster(Player player){
    var sortedList = currentRoster.players.keys.toList();
    sortedList.sort();
    var lastId = sortedList.lastWhere((i)=>true, orElse: ()=> 0);
    player.id = lastId +1;

    currentRoster.players[player.id]= player;
    rosterUpdateStream.sink.add(null);
  }

  void assignPlayer(Player player, FormationPosition position) {

    if(player == null)
      return;

    var playerAtDroppedPosition = getPlayerAtPosition(position);
    if(playerAtDroppedPosition != null){
      playerAtDroppedPosition.currentPosition = player.currentPosition;
      playerAtDroppedPosition.playTimeCurrent = 0;
    }
    
    player.currentPosition = position;

    if(player.currentPosition == null){
      player.playTimeCurrent = 0;      
    }
    
    assignmentStream.sink.add(MapEntry(player, position));
    
    Vibration.vibrate();
    
   
  }

  Player getPlayerAtPosition(FormationPosition position){
    return currentRoster?.players?.values?.firstWhere( (player)=> player.currentPosition == position, orElse: ()=>null);
  }
  
  void deleteRosterPlayer(int id){    
    currentRoster.players.remove(id);
    rosterUpdateStream.sink.add(null);
  }

  void startTimer(){
    if (_gameTimer != null) 
      return;
    _gameTimer = Timer.periodic(Duration(seconds: 1), _onTick);
    _gameWatch.start();
  }

  void _onTick(Timer timer){
     currentRoster?.players?.forEach((key,value){
        if(value.currentPosition != null){
          value.playTimeCurrent ++;
          value.playTimeTotal ++;
        }
      });
      //TODO: we should make the subsitution timer / tired player warning configurable within the UI
      if(_gameWatch.elapsed.inSeconds % 300 == 0)
        Vibration.vibrate();
      gameTimerStream.sink.add(_gameWatch.elapsed);
  }

   void stopTimer() {
    _gameTimer?.cancel();
    _gameTimer = null;
     gameTimerStream.sink.add(_gameWatch.elapsed);
    _gameWatch.stop();
  }

  bool isTimerRunning(){
    if(_gameTimer == null)
       return false;
    return _gameTimer?.isActive;
  }

  void resetGameTimer(){
      stopTimer();
      _gameWatch.reset();
      gameTimerStream.sink.add(_gameWatch.elapsed);
  }

  void setRoster(Roster roster){
    currentRoster = roster;
    rosterUpdateStream.sink.add(null);
    assignmentStream.sink.add(null);
  }
 

  
}