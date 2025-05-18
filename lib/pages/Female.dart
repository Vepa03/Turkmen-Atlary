import 'package:flutter/material.dart';
import 'dart:convert'; 
import 'package:flutter/services.dart' show rootBundle; 

class Female extends StatefulWidget {
  const Female({super.key});

  @override
  State<Female> createState() => _FemaleState();
}

class _FemaleState extends State<Female> {
  Set<int> favorites = {};

  void favorite_uytget(int index){
    setState(() {
      if (favorites.contains(index)){
        favorites.remove(index);
      } else{
        favorites.add(index);
      }
    });
  }

  List<dynamic> girl_names = [];
  @override
  void initState() {
    super.initState();
    loadJson();
  }

  Future<void> loadJson() async {
    final String response = await rootBundle.loadString("lib/assets/names/girl_names.json");
    final data  = await json.decode(response);
    setState(() {
      girl_names = data;
    });
  }
  @override
  Widget build(BuildContext context) {
  var height = MediaQuery.of(context).size.height;
  var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: ListView.builder(
          itemCount: girl_names.length,
          itemBuilder: (context, index){
            return GestureDetector(
              onTap: (){
                  showDialog(
                    context: context, 
                    builder: (_) =>AlertDialog(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset("lib/assets/images/gyz.png", width: width*0.2, height: height*0.1,),
                          Text(girl_names[index]["name"], style: TextStyle(fontSize: width*0.06, fontWeight: FontWeight.bold),),
                        ],
                      ),
                      content: Text(girl_names[index]["meaning"],style: TextStyle(fontSize: width*0.04,)),
                    ));
                },
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: Card(
                  child: Container(
                    height: height*0.07,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset("lib/assets/images/gyz.png"),
                        ),
                        Text(girl_names[index]["name"], style: TextStyle(fontSize: width*0.05, fontWeight: FontWeight.bold),),
                        GestureDetector(
                          onTap: (){
                            favorite_uytget(index);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                            child: Icon(favorites.contains(index) ? Icons.favorite : Icons.favorite_border_outlined ,
                            color: favorites.contains(index) ? Colors.red : Colors.black,),
                          ),
                        )
                      ],
                    )
                    
                  ),
                ),
              ),
            );
          })
      ),
    );
  }
}