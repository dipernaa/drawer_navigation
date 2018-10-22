import 'package:flutter/material.dart';
import 'package:drawer_navigation/pages/contact_us.dart';
import 'package:drawer_navigation/pages/events.dart';

class DrawerItem {
  String title;
  Widget body;
  DrawerItem(this.title, this.body);
}

class Home extends StatefulWidget {
  final drawerItems = [
    new DrawerItem('Events', Events()),
    new DrawerItem('Contact Us', ContactUs())
  ];

  @override
  HomeState createState() => new HomeState();
}

class HomeState extends State<Home> {
  DrawerItem _currentScreen;

  @override
  initState() {
    super.initState();
    _currentScreen = widget.drawerItems[0];
  }

  _onSelectItem(DrawerItem item) {
    setState(() => _currentScreen = item);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    var drawerTiles = <Widget>[
      DrawerHeader(
        child: Text('Drawer Navigation'),
        decoration: BoxDecoration(
          color: Colors.amber[200],
        ),
      )
    ];

    for (var i = 0; i < widget.drawerItems.length; i += 1) {
      drawerTiles.add(
        new ListTile(
          title: new Text(widget.drawerItems[i].title),
          selected: _currentScreen.title == widget.drawerItems[i].title,
          onTap: () => _onSelectItem(widget.drawerItems[i]),
        )
      );
    }

    return new Scaffold(
      appBar: new AppBar(
        title: new Text(_currentScreen.title),
        backgroundColor: Colors.amber[200],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: drawerTiles,
        ),
      ),
      body: _currentScreen.body
    );
  }
}
