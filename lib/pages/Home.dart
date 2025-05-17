import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:learn/pages/AboutUs.dart';
import 'package:learn/pages/Female.dart';
import 'package:learn/pages/Male.dart';
import 'package:learn/pages/Menu.dart';
import 'package:lottie/lottie.dart';
import 'package:share_plus/share_plus.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int saylanan_index = 0;
  static const List<Widget> option = <Widget>[
    Menu(),
    Male(),
    Female(),
    Text("data 4"),
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
        title: Center(child: Text("Turkmen Adam Atlary")),
        elevation: 2,

      ),

      drawer: Drawer(
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
                    leading: Icon(Icons.share, color: Colors.black,),
                    title: Text("Share"),
                    onTap: (){
                      SharePlus.instance.share(
                      ShareParams(uri: Uri.parse("https://babayev.vercel.app/?fbclid=PAZXh0bgNhZW0CMTEAAaf91ZS4QuX1NuzO1LNAZBAZe2u3utUZa0PpwS_uWKeKTljvFkN2jTd5DYfAww_aem_1GklYLWmJx06H6GYsUgCRQ")),
                    );
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.info_outline, color: Colors.black,),
                    title: Text("Biz Hakynda"),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> Aboutus()));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.dark_mode_outlined, color: Colors.black,),
                    title: Text("Gundiz"),
                    onTap: (){
                      
                    },
                  ),
                  Divider(color: Colors.black,),
                  ListTile(
                    leading: Icon(Icons.exit_to_app, color: Colors.black,),
                    title: Text("Cykalga"),
                    onTap: (){
                      SystemNavigator.pop();
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
          BottomNavigationBarItem(icon: Icon(Icons.home_filled, color: const Color.fromARGB(255, 0, 0, 0),), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.male,color: const Color.fromARGB(255, 0, 0, 0),), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.female, color: const Color.fromARGB(255, 0, 0, 0),), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border_outlined, color: const Color.fromARGB(255, 0, 0, 0),), label: ""),
        ],
        currentIndex: saylanan_index,
        selectedItemColor: const Color.fromARGB(255, 0, 0, 0),
        onTap: _onitemTapped,
        ),
    );
  }
}