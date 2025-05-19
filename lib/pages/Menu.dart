import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  List<Map<String, dynamic>> allNames = [];
  List<Map<String, dynamic>> filteredNames = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadAllNames();
  }

  Future<void> loadAllNames() async {
    final String boys = await rootBundle.loadString("lib/assets/names/boy_names.json");
    final String girls = await rootBundle.loadString("lib/assets/names/girl_names.json");

    final List<Map<String, dynamic>> boyList = List<Map<String, dynamic>>.from(json.decode(boys));
    final List<Map<String, dynamic>> girlList = List<Map<String, dynamic>>.from(json.decode(girls));

    final all = [
      ...boyList.map((e) => {...e, "gender": "male"}),
      ...girlList.map((e) => {...e, "gender": "female"}),
    ];

    all.sort((a, b) => a['name'].toString().toLowerCase().compareTo(b['name'].toString().toLowerCase()));

    setState(() {
      allNames = all;
      filteredNames = List.from(all);
    });
  }

  void filterSearch(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredNames = List.from(allNames);
      });
      return;
    }

    final filtered = allNames.where((name) {
      final n = name['name'].toString().toLowerCase();
      return n.contains(query.toLowerCase());
    }).toList();

    setState(() {
      filteredNames = filtered;
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
          child: Column(
            children: [
              // 🔍 Arama Alanı
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: searchController,
                  onChanged: filterSearch,
                  decoration: InputDecoration(
                    hintText: "Gözleg...",
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
                  ),
                ),
              ),
              // 📋 Liste
              Expanded(
                child: ListView.builder(
                  itemCount: filteredNames.length,
                  itemBuilder: (context, index) {
                    final item = filteredNames[index];
                    final name = item['name'];
                    final meaning = item['meaning'];
                    final gender = item['gender'];
          
                    return GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: Row(
                              children: [
                                Image.asset(
                                  gender == 'male'
                                      ? "lib/assets/images/erkek.png"
                                      : "lib/assets/images/gyz.png",
                                  width: width * 0.2,
                                  height: height * 0.1,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  name[0].toUpperCase() + name.substring(1).toLowerCase(),
                                  style: TextStyle(fontSize: width * 0.06, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            content: Text(meaning, style: TextStyle(fontSize: width * 0.04)),
                          ),
                        );
                      },
                      child: Card(
                        child: Container(
                          height: height * 0.07,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Image.asset(
                                  gender == 'male'
                                      ? "lib/assets/images/erkek.png"
                                      : "lib/assets/images/gyz.png",
                                ),
                              ),
                              Text(
                                name[0].toUpperCase() + name.substring(1).toLowerCase(),
                                style: TextStyle(fontSize: width * 0.05, fontWeight: FontWeight.bold),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                child: Icon(Icons.arrow_forward_ios),
                              ),
                            ],
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
      ),
    );
  }
}
