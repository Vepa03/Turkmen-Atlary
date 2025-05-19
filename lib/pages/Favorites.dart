import 'package:flutter/material.dart';
import 'package:learn/FavoriteProvider.dart';
import 'package:provider/provider.dart';

class Favorites extends StatelessWidget {
  const Favorites({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    final favorites = context.watch<FavoriteProvider>().favorites.toList();

    return Scaffold(
      body: ListView.builder(
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          final favorite = favorites[index] as Map<String, String>;
          final name = favorite['name']!;
          final gender = favorite['gender']!;

          return Padding(
            padding: const EdgeInsets.all(10.0),
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
                      style: TextStyle(
                        fontSize: width * 0.05,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Icon(Icons.favorite, color: Colors.red),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
