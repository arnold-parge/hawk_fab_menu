import 'package:flutter/material.dart';
import 'package:hawk_fab_menu/hawk_fab_menu.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hawk Fab Menu Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(),
    );
  }
}

/// [StatefulWidget] is used only for [HawkFabMenuController] which is used
/// to toggle the menu from other than dedicated button. If you don't have this
/// usecase, then you can even use [StatelessWidget].
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  HawkFabMenuController hawkFabMenuController = HawkFabMenuController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hawk Fab Menu Demo'),
        actions: [
          IconButton(
            onPressed: () {
              hawkFabMenuController.toggleMenu();
            },
            icon: const Icon(Icons.replay_outlined),
          ),
        ],
      ),
      body: HawkFabMenu(
        icon: AnimatedIcons.menu_arrow,
        fabColor: Colors.yellow,
        iconColor: Colors.green,
        hawkFabMenuController: hawkFabMenuController,
        items: [
          HawkFabMenuItem(
            label: 'Menu 1',
            ontap: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Menu 1 selected')),
              );
            },
            icon: const Icon(Icons.home),
            color: Colors.red,
            labelColor: Colors.blue,
          ),
          HawkFabMenuItem(
            label: 'Menu 2',
            ontap: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Menu 2 selected')),
              );
            },
            icon: const Icon(Icons.comment),
            labelColor: Colors.white,
            labelBackgroundColor: Colors.blue,
          ),
          HawkFabMenuItem(
            label: 'Menu 3 (default)',
            ontap: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Menu 3 selected')),
              );
            },
            icon: const Icon(Icons.add_a_photo),
          ),
        ],
        body: const Center(
          child: Text('Center of the screen'),
        ),
      ),
    );
  }
}
