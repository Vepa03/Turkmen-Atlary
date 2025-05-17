import 'package:flutter/material.dart';
import 'package:learn/pages/Profile.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int saylanan_index = 0;
  static const List<Widget> option = <Widget>[
    Text("data 1"),
    Text("data 2"),
    Text("data 3")
  ];

  void _onitemTapped(int index){
    setState(() {
      saylanan_index = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Program")),
        elevation: 2,
        actions: [
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Profile()));
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image.asset("lib/assets/images/admin.png"),
            ),
          )
        ],
      ),

      drawer: Drawer(
        child: Column(
          children: [
            Image.asset("lib/assets/images/admin.png"),
            Column(
              children: [
                ListTile(
                  leading: Icon(Icons.abc, color: Colors.black,),
                  title: Text("Birinji"),
                  onTap: (){

                  },
                ),
                ListTile(
                  leading: Icon(Icons.abc_rounded, color: Colors.black,),
                  title: Text("Ikinji"),
                  onTap: (){
                    
                  },
                )
              ],
            )
          ],
        ),
      ),

      body: Center(child: option.elementAt(saylanan_index),),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 2,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.abc, color: const Color.fromARGB(255, 195, 57, 57),), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.abc,color: const Color.fromARGB(255, 147, 40, 40),), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.abc, color: const Color.fromARGB(255, 130, 40, 40),), label: ""),
        ],
        currentIndex: saylanan_index,
        selectedItemColor: const Color.fromARGB(255, 0, 0, 0),
        onTap: _onitemTapped,
        ),
    );
  }
}