import 'package:flutter/material.dart';
import 'package:hawk_fab_menu/hawk_fab_menu.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hawk Fab Menu Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(title: 'Hawk Fab Menu Demo'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.title!),
      ),
      body: Builder(
        // builder is used only for the snackbar, if you don't want the snackbar you can remove
        // Builder from the tree
        builder: (BuildContext context) => HawkFabMenu(
          icon: AnimatedIcons.menu_arrow,
          fabColor: Colors.yellow,
          iconColor: Colors.green,
          items: [
            HawkFabMenuItem(
              label: 'Menu 1',
              ontap: () {
                Scaffold.of(context)..hideCurrentSnackBar();
                Scaffold.of(context).showSnackBar(
                  SnackBar(content: Text('Menu 1 selected')),
                );
              },
              icon: Icon(Icons.home),
              color: Colors.red,
              labelColor: Colors.blue,
            ),
            HawkFabMenuItem(
              label: 'Menu 2',
              ontap: () {
                Scaffold.of(context)..hideCurrentSnackBar();
                Scaffold.of(context).showSnackBar(
                  SnackBar(content: Text('Menu 2 selected')),
                );
              },
              icon: Icon(Icons.comment),
              labelColor: Colors.white,
              labelBackgroundColor: Colors.blue,
            ),
            HawkFabMenuItem(
              label: 'Menu 3 (default)',
              ontap: () {
                Scaffold.of(context)..hideCurrentSnackBar();
                Scaffold.of(context).showSnackBar(
                  SnackBar(content: Text('Menu 3 selected')),
                );
              },
              icon: Icon(Icons.add_a_photo),
            ),
          ],
          body: Center(
            child: Text('Center of the screen'),
          ),
        ),
      ),
    );
  }
}
