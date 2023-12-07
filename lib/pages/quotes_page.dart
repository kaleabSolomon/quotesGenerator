import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:quotesgenerator/components/button.dart';

class QuotesPage extends StatefulWidget {
  const QuotesPage({super.key});

  @override
  State<QuotesPage> createState() => _QuotesPageState();
}

class _QuotesPageState extends State<QuotesPage> {
  late String quote = "";
  bool isLoading = false;
  List<String> favorites = [];

  @override
  void initState() {
    super.initState();
    loadFavorites();
  }

  void getQuote() async {
    setState(() {
      isLoading = true;
    });
    try {
      var apiUrl = Uri.parse("https://api.quotable.io/random");
      var response = await http.get(apiUrl);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        setState(() {
          quote = data['content'];
          isLoading = false;
        });
      } else {
        print('Request failed with status: ${response.statusCode}.');
        setState(() {
          isLoading = false;
        });
      }
    } catch (err) {
      print(err);
      setState(() {
        isLoading = false;
        quote = "could not get quotes";
      });
    }
  }

  void loadFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("favorites")) {
      setState(() {
        favorites = prefs.getStringList('favorites')!;
      });
    }
  }

  void saveToFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('favorites', favorites);
  }

  void addToFavorites() {
    if (!favorites.contains(quote) && quote.isNotEmpty) {
      setState(() {
        favorites.add(quote);
      });

      saveToFavorites();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("quotes added to favorites"),
        backgroundColor: Colors.green,
      ));
    } else if (quote.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("please get a quote first"),
        backgroundColor: Colors.red,
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("quote already in favorites"),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
            child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: isLoading
              ? const CircularProgressIndicator()
              : Text(quote,
                  style: GoogleFonts.lora(
                      textStyle: const TextStyle(
                          fontSize: 22,
                          fontStyle: FontStyle.italic,
                          color: Colors.black))),
        )),
        const SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Button(text: "get quote", onPressed: getQuote),
            Button(text: "add to favorites", onPressed: addToFavorites)
          ],
        )
      ],
    );
  }
}
