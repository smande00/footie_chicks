import 'package:flutter/material.dart';
import 'bloc.dart';
export 'bloc.dart';

class BlocProvider extends InheritedWidget {
  final bloc = Bloc();

  BlocProvider({Key key, Widget child}) : super(key: key, child: child);

  bool updateShouldNotify(_) => true;

  static Bloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(BlocProvider) as BlocProvider).bloc;
  }
}