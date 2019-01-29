import "./player.dart";

class Roster{
  String name;
  Map<int,Player> players;
  Roster({this.name, this.players});

  /*Player getByName(String name){
    Player result = null;
    players.forEach((p){
      if(p.name == name){
        result = p;
      }
    });
    return result;
  }*/
}
