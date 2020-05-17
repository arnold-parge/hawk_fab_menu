# hawk_fab_menu
A floating action button menu that will pop up small fabs on top

## Installation

Add dependency in pubspec.yaml:
```
hawk_fab_menu: ^0.2.2
```

## Example:

```dart
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: HawkFabMenu(
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
```

<img src="https://raw.githubusercontent.com/arnold-parge/hawk_fab_menu/master/example/hawk menu demo.gif" width="250" />

### PS 
- PRs are welcome
- Please raise issues on https://github.com/arnold-parge/hawk_fab_menu.
- Open for suggestions ❤️