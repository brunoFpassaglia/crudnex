import 'package:crudnex/blocs/auth/auth_bloc.dart';
import 'package:crudnex/blocs/auth/auth_events.dart';
import 'package:crudnex/ui/color_palete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive/hive.dart';

class AppWidget extends StatefulWidget {
  @override
  _AppWidgetState createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  final AuthBloc authBloc = Modular.get<AuthBloc>();

  @override
  void initState() {
    super.initState();
    authBloc.add(AppStarted());
  }

  @override
  void dispose() {
    authBloc.close();
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: darkThemeData,
      initialRoute: '/',
    ).modular();
  }
}
