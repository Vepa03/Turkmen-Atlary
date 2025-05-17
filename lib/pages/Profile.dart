import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 81, 170, 243),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: height * .25,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage("lib/assets/images/background.png")
              )
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Hello ,\nWelcome ", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold), textAlign: TextAlign.left, ),
                customSizedBox(),
                TextField(
                  decoration: customInputdecoration("Username"),
                ),
                customSizedBox(),
                TextField(
                  decoration: customInputdecoration("Password"),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget customSizedBox()=> SizedBox(
    height: 20,
  );
  InputDecoration customInputdecoration(String hintText) {
    return InputDecoration(
      hintText: hintText,
      enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(
      color: Colors.black
        )
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.grey
        )
      )
    );
  }
}