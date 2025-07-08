import 'package:flutter/material.dart';
import 'dart:convert'; 
import 'package:flutter/services.dart' show rootBundle;
import 'package:learn/FavoriteProvider.dart';
import 'package:provider/provider.dart'; 

class Female extends StatefulWidget {
  const Female({super.key});

  @override
  State<Female> createState() => _FemaleState();
}

class _FemaleState extends State<Female> {
  Set<int> favorites = {};
  List<Map<String, dynamic>> girl_names = [];
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
    final String response = await rootBundle.loadString("lib/assets/names/girl_names.json");
    final List<dynamic> rawData = json.decode(response);
    final List<Map<String, dynamic>> data = List<Map<String, dynamic>>.from(rawData);

    data.sort((a, b) => a['name'].toString().toLowerCase().compareTo(b['name'].toString().toLowerCase()));

    setState(() {
      girl_names = data;
      filtered_names = List.from(data);
    });
  }

  void filterSearchResults(String query) {
    if (query.isEmpty) {
      setState(() {
        filtered_names = List.from(girl_names);
      });
      return;
    }

    final results = girl_names.where((name) {
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
                  hintText: "Gözleg...",
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
                              Image.asset("lib/assets/images/gyz.png", width: width * 0.2, height: height * 0.1),
                              Text(name, style: TextStyle(fontSize: width * 0.06, fontWeight: FontWeight.bold)),
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
                                child: Image.asset("lib/assets/images/gyz.png"),
                              ),
                              Text(name, style: TextStyle(fontSize: width * 0.05, fontWeight: FontWeight.bold)),
                              GestureDetector(
                                onTap: () {
                                  final name = filtered_names[index]["name"];
                                  context.read<FavoriteProvider>().toggleFavorite(name, 'female');
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
