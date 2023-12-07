import 'package:flutter/material.dart';
import 'package:quotesgenerator/pages/favorites_page.dart';

import 'package:quotesgenerator/pages/quotes_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    Widget body = QuotesPage();

    if (_selectedIndex == 1) {
      body = FavoritesPage();
    }
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          toolbarHeight: 80,
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 6, 169, 191),
          title: const Text(
            "quotify",
            style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                letterSpacing: 2),
          ),
        ),
        drawer: Drawer(
          backgroundColor: Colors.cyan,
          child: Column(children: [
            const DrawerHeader(
                child: Icon(
              Icons.format_quote_outlined,
              color: Colors.white,
              size: 140,
            )),
            ListTile(
              onTap: () {
                setState(() {
                  _selectedIndex = 0;
                });
                Navigator.of(context).pop();
              },
              leading: const Icon(
                Icons.home,
                color: Colors.white,
                size: 30,
              ),
              title: const Text(
                "Home",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ListTile(
              onTap: () {
                setState(() {
                  _selectedIndex = 1;
                });
                Navigator.of(context).pop();
              },
              leading: const Icon(
                Icons.favorite,
                color: Colors.white,
                size: 30,
              ),
              title: const Text(
                "Favorites",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
            )
          ]),
        ),
        body: body);
  }
}
