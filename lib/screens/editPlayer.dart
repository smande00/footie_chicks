import 'package:flutter/material.dart';
import '../blocs/provider.dart';
import '../models/player.dart';
import '../blocs/provider.dart';


class EditPlayer extends StatelessWidget {

  final Player player;

  const EditPlayer({this.player});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of(context);
    final nameTextController = TextEditingController(text:player.name);
    final numberTextController = TextEditingController(text:player.number?.toString());
    
    

    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Player"),        
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      floatingActionButton: IconButton(
        icon:Icon(Icons.save), 
        onPressed: (){
          player.name = nameTextController.text;
          bloc.updateRosterPlayer(player);
          Navigator.pop(context);
        },),

      body: Column(
        children: [
          TextField(controller:nameTextController, 
            decoration: InputDecoration(hintText: 'Player Name'), 
            onSubmitted:(newName){
              player.name = newName;
              },),
          TextField(controller:numberTextController,
           decoration: InputDecoration(hintText: 'Player Number'), 
           onSubmitted:(newNumber){player.number = int.tryParse(newNumber) ?? 0;},
           keyboardType: TextInputType.number)
        ])
    );
  }
}
