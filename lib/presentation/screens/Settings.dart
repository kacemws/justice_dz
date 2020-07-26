import 'package:flutter/material.dart';
import 'package:justice_dz/presentation/tools/CustomDrawer.dart';

class Settings extends StatefulWidget {
  static final route = "/settings";
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Justice DZ"),
        centerTitle: true,
        elevation: 3,
      ),
      drawer: CustomDrawer(),
    );
  }
}