# hawk_fab_menu
A floating action button menu that will pop up small fabs on top


## Example:

```dart
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text(this.title),
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
```

<img src="https://raw.githubusercontent.com/arnold-parge/hawk_fab_menu/master/example/hawk menu demo 2.gif" width="250" />

### PS 
- PRs are welcome
- Please raise issues on https://github.com/arnold-parge/hawk_fab_menu.
- Open for suggestions ❤️