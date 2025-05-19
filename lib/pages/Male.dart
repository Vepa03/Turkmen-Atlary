import 'package:flutter/material.dart';
import 'dart:convert'; 
import 'package:flutter/services.dart' show rootBundle;
import 'package:learn/FavoriteProvider.dart';
import 'package:provider/provider.dart'; 

class Male extends StatefulWidget {
  const Male({super.key});

  @override
  State<Male> createState() => _MaleState();
}

class _MaleState extends State<Male> {
  Set<int> favorites = {};
  List<Map<String, dynamic>> boy_names = [];
  List<Map<String, dynamic>> filtered_names = [];
  TextEditingController searchController = TextEditingController();

  void favorite_uytget(int index) {
    setState(() {
      if (favorites.contains(index)) {
        favorites.remove(index);
      } else {
        favorites.add(index);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    loadJson();
  }

  Future<void> loadJson() async {
    final String response = await rootBundle.loadString("lib/assets/names/boy_names.json");
    final List<dynamic> rawData = json.decode(response);
    final List<Map<String, dynamic>> data = List<Map<String, dynamic>>.from(rawData);

    data.sort((a, b) => a['name'].toString().toLowerCase().compareTo(b['name'].toString().toLowerCase()));

    setState(() {
      boy_names = data;
      filtered_names = List.from(data);
    });
  }

  void filterSearchResults(String query) {
    if (query.isEmpty) {
      setState(() {
        filtered_names = List.from(boy_names);
      });
      return;
    }

    final results = boy_names.where((name) {
      final nameLower = name['name'].toString().toLowerCase();
      return nameLower.contains(query.toLowerCase());
    }).toList();

    setState(() {
      filtered_names = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: searchController,
                onChanged: filterSearchResults,
                decoration: InputDecoration(
                  hintText: "Gozleg ...",
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filtered_names.length,
                itemBuilder: (context, index) {
                  final name = filtered_names[index]["name"];
                  final meaning = filtered_names[index]["meaning"];
                  return GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: Row(
                            children: [
                              Image.asset("lib/assets/images/erkek.png", width: width * 0.2, height: height * 0.1),
                              Text(name[0].toString().toUpperCase()+ name.toString().substring(1).toLowerCase(), style: TextStyle(fontSize: width * 0.06, fontWeight: FontWeight.bold)),
                            ],
                          ),
                          content: Text(meaning, style: TextStyle(fontSize: width * 0.04)),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Card(
                        child: Container(
                          height: height * 0.07,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset("lib/assets/images/erkek.png"),
                              ),
                              Text(name[0].toString().toUpperCase() + name.toString().substring(1).toLowerCase(), style: TextStyle(fontSize: width * 0.05, fontWeight: FontWeight.bold)),
                              GestureDetector(
                                onTap: () {
                                  final name = filtered_names[index]["name"];
                                  context.read<FavoriteProvider>().toggleFavorite(name, "male");
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                  child: Icon(
                                    context.watch<FavoriteProvider>().isFavorite(name) ? Icons.favorite : Icons.favorite_border_outlined,
                                    color: context.watch<FavoriteProvider>().isFavorite(name) ? Colors.red : Theme.of(context).iconTheme.color,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
