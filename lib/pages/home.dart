import 'package:flutter/material.dart';
import 'package:drawer_navigation/pages/about.dart';
import 'package:drawer_navigation/pages/contact_us.dart';
import 'package:drawer_navigation/pages/events.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  MyHomePageState createState() => new MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  // Keep track of the page history internally! We'll start with "Contact Us" and
  // add or remove pages to this list.
  final _pageHistory = [PageHistoryItem(PageType.contactUs, null)];

  // Returns the correct body based on the selected page.
  Widget _pageToWidget(PageType page) {
    switch (page) {
      case PageType.about:
        return AboutPage();
      case PageType.events:
        return EventsPage();
      case PageType.contactUs:
      default:
        return ContactUsPage();
    }
  }

  void _pushPage(PageType page) {
    // Close the Drawer when someone selects a new Screen
    Navigator.pop(context);

    // If we're already on the Selected Page, do not navigate to it!
    if (_pageHistory.last.type == page) return;

    // Finally, add the history entry to our own Stack! This will allow us
    // to manage the navigation history.
    setState(() {
      int pageIndex;
      bool containsPage = false;
      for (int i = 0; i < _pageHistory.length && containsPage == false; i += 1) {
        containsPage = _pageHistory[i].type == page;

        if (containsPage) {
          pageIndex = i;
        }
      }

      if (containsPage) {
        for (int i = _pageHistory.length - 1; i > pageIndex; i -= 1) {
          PageHistoryItem removedPage = _pageHistory.elementAt(i);
          if (removedPage.historyEntry != null) {
            ModalRoute.of(context).removeLocalHistoryEntry(removedPage.historyEntry);
          }
        }
      } else {
        // Create a LocalHistoryEntry and add it to the current route. This
        // will allow us to run the `_popPage` function when someone taps on
        // the back button!
        final route = ModalRoute.of(context);
        final entry = LocalHistoryEntry(onRemove: _popPage);
        route.addLocalHistoryEntry(entry);

        _pageHistory.add(PageHistoryItem(page, entry));
      }
    });
  }

  // When someone taps on the Back Button, remove the last page from our list of pages!
  void _popPage() {
    setState(() {
      _pageHistory.removeLast();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sample')),
      // Render the body using the last entry in the History!
      body: _pageToWidget(_pageHistory.last.type),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Drawer Navigation'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(title: Text('Contact Us'), onTap: () => _pushPage(PageType.contactUs)),
            ListTile(title: Text('About'), onTap: () => _pushPage(PageType.about)),
            ListTile(title: Text('Events'), onTap: () => _pushPage(PageType.events)),
          ],
        ),
      ),
    );
  }
}

class PageHistoryItem {
  final PageType type;
  final LocalHistoryEntry historyEntry;

  PageHistoryItem(this.type, this.historyEntry);
}

enum PageType { about, contactUs, events }
