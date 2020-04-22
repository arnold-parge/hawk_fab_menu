# hawk_fab_menu
## A floating action button menu that will pop up small fabs on top
---
## Example

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