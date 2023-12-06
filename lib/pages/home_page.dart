import 'package:flutter/material.dart';
import 'package:quotesgenerator/components/button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String quote;

  @override
  Widget build(BuildContext context) {
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
      drawer: const Drawer(
        backgroundColor: Colors.cyan,
        child: Column(children: [
          DrawerHeader(
              child: Icon(
            Icons.quora_outlined,
            color: Colors.white,
            size: 140,
          )),
          ListTile(
            leading: Icon(
              Icons.home,
              color: Colors.white,
              size: 40,
            ),
            title: Text(
              "Home",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          ListTile(
            leading: Icon(
              Icons.favorite,
              color: Colors.white,
              size: 40,
            ),
            title: Text(
              "Favorites",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            ),
          )
        ]),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(child: Text(quote)),
          Row(
            children: [
              Button(text: "get quote", onPressed: getQuote),
              Button(text: "add to favorites", onPressed: addToFavorites)
            ],
          )
        ],
      ),
    );
  }
}
