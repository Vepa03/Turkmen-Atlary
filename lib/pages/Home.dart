import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:learn/Provider.dart';
import 'package:learn/pages/AboutUs.dart';
import 'package:learn/pages/Favorites.dart';
import 'package:learn/pages/Female.dart';
import 'package:learn/pages/Male.dart';
import 'package:learn/pages/Menu.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool ikon= false;
  String tema_ady = "Gije";

  void ikno_uytget (){
    setState(() {
      ikon = !ikon;
    });
  }

  void tema_adyny (){
    setState(() {
      tema_ady = tema_ady == "Gije" ? "Gundiz" : "Gije";
    });
  }



  int saylanan_index = 0;
  static const List<Widget> option = <Widget>[
    Menu(),
    Male(),
    Female(),
    Favorites()
  ];

  void _onitemTapped(int index){
    setState(() {
      saylanan_index = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: Center(child: Text("Turkmen Adam Atlary", style: Theme.of(context).textTheme.titleLarge,)),
        elevation: 2,

      ),

      drawer: Drawer(
        backgroundColor: Theme.of(context).bottomAppBarTheme.color,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: width*0.5,
              height: height*0.3,
              child: Lottie.asset("lib/assets/images/drawer_animation.json")),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.share, color: Theme.of(context).iconTheme.color,),
                    title: Text("Share", style:  Theme.of(context).textTheme.titleMedium,),
                    onTap: (){
                      SharePlus.instance.share(
                      ShareParams(uri: Uri.parse("https://babayev.vercel.app/?fbclid=PAZXh0bgNhZW0CMTEAAaf91ZS4QuX1NuzO1LNAZBAZe2u3utUZa0PpwS_uWKeKTljvFkN2jTd5DYfAww_aem_1GklYLWmJx06H6GYsUgCRQ")),
                    );
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.info_outline, color: Theme.of(context).iconTheme.color),
                    title: Text("Biz Hakynda", style:  Theme.of(context).textTheme.titleMedium,),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> Aboutus()));
                    },
                  ),
                  ListTile(
                    leading: Icon(ikon ? Icons.wb_sunny_outlined : Icons.nightlight_outlined, color: Theme.of(context).iconTheme.color,),
                    title: Text(tema_ady, style:  Theme.of(context).textTheme.titleMedium,),
                    onTap: (){
                      ikno_uytget();
                      tema_adyny();
                      Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
                    },
                  ),
                  Divider(color: Colors.black,),
                  ListTile(
                    leading: Icon(Icons.exit_to_app, color: Theme.of(context).iconTheme.color),
                    title: Text("Cykalga", style:  Theme.of(context).textTheme.titleMedium,),
                    onTap: (){
                      if (Platform.isAndroid){
                        SystemNavigator.pop();
                      }else if (Platform.isIOS){
                        Navigator.of(context).pop();
                      }
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),

      body: Center(child: option.elementAt(saylanan_index),),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 2,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home_filled, color: Theme.of(context).iconTheme.color), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.male,color: Theme.of(context).iconTheme.color), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.female, color: Theme.of(context).iconTheme.color), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border_outlined, color: Theme.of(context).iconTheme.color), label: ""),
        ],
        currentIndex: saylanan_index,
        selectedItemColor: const Color.fromARGB(255, 0, 0, 0),
        onTap: _onitemTapped,
        ),
    );
  }
}