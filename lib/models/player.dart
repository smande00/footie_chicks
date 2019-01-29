import 'formation_position.dart';

class Player {
  
  int id;  

  String name;
  int number;
  
  int playTimeTotal = 0;
  int playTimeCurrent = 0;
  FormationPosition currentPosition;
  
  Player({this.name, this.id});

}