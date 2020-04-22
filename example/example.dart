import 'package:flutter/material.dart';
import '../lib/hawk_fab_menu.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hawk Fab Menu Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Hawk Fab Menu Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: HawkFabMenu(
        blur: 5.0,
        items: [
          HawkFabMenuItem(
            label: 'Menu 1',
            ontap: () {},
            icon: Icon(Icons.home),
          ),
          HawkFabMenuItem(
            label: 'Menu 2',
            ontap: () {},
            icon: Icon(Icons.comment),
          ),
        ],
        body: Center(
          child: Text('Center of the screen'),
        ),
      ),
    );
  }
}
