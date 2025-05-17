import 'package:flutter/material.dart';
import 'dart:convert'; 
import 'package:flutter/services.dart' show rootBundle; 

class Male extends StatefulWidget {
  const Male({super.key});

  @override
  State<Male> createState() => _MaleState();
}

class _MaleState extends State<Male> {

  List<dynamic> boy_names = [];
  @override
  void initState() {
    super.initState();
    loadJson();
  }

  Future<void> loadJson() async {
    final String response = await rootBundle.loadString("lib/assets/names/boy_names.json");
    final data  = await json.decode(response);
    setState(() {
      boy_names = data;
    });
  }
  @override
  Widget build(BuildContext context) {
  var height = MediaQuery.of(context).size.height;
  var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: ListView.builder(
          itemCount: boy_names.length,
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
                          Image.asset("lib/assets/images/erkek.png", width: width*0.2, height: height*0.1,),
                          Text(boy_names[index]["name"], style: TextStyle(fontSize: width*0.06, fontWeight: FontWeight.bold),),
                        ],
                      ),
                      content: Text(boy_names[index]["meaning"],style: TextStyle(fontSize: width*0.04,)),
                    ));
                },
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: Card(
                  child: Container(
                    height: height*0.07,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset("lib/assets/images/erkek.png"),
                        ),
                        SizedBox(width: width*0.05,),
                        Text(boy_names[index]["name"], style: TextStyle(fontSize: width*0.05, fontWeight: FontWeight.bold),)
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