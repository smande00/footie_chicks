import './formation_row.dart';
class Formation{
  int _id;
  String name;
  List<FormationRow> formationRows;

  Formation(this.name, this.formationRows);
  Formation.withId(this._id,this.name, this.formationRows);

  int get id => _id;
  
}