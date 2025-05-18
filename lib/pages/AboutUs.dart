import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Aboutus extends StatelessWidget {
  const Aboutus({super.key});
  
  static Map<String, Uri> social_Links = {
    "Instagram" : Uri.parse("https://www.instagram.com/vepa_babayef/"),
    "Twitter" : Uri.parse("https://x.com/vepaskaa"),
    "GitHub" : Uri.parse("https://github.com/Vepa03"),
    "Linkedin": Uri.parse("https://www.linkedin.com/in/vepa-babayev-273b22330/")
  };

  Future<void>_launchURL(BuildContext context, Uri url) async{
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Could not launch $url"))
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var height  = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Biz Hakynda", style: Theme.of(context).textTheme.titleLarge,)),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        actions: [
          PopupMenuButton(
            onSelected: (value){
              _launchURL(context, social_Links[value]!);
            },
            itemBuilder: (context)=>[
              PopupMenuItem(
                value: "Instagram",
                child: Row(
                  children: [
                    Image.asset("lib/assets/images/instagram.png", width: width*0.05,),
                    SizedBox(width: width*0.035,),
                    Text("Instagram", style: Theme.of(context).textTheme.titleMedium,)
                  ],
                ),
              ),
              PopupMenuItem(
                value: "Twitter",
                child: Row(
                  children: [
                    Image.asset("lib/assets/images/twitter.png", width: width*0.05,),
                    SizedBox(width: width*0.035,),
                    Text("Twitter", style: Theme.of(context).textTheme.titleMedium)
                  ],
                )
              ),
              PopupMenuItem(
                value: "GitHub",
                child: Row(children: [
                  Image.asset("lib/assets/images/github.png", width: width*0.05,),
                  SizedBox(width: width*0.035,),
                  Text("GitHub", style: Theme.of(context).textTheme.titleMedium)
                ],)
              ),
              PopupMenuItem(
                value: "Linkedin",
                child: Row(children: [
                  Image.asset("lib/assets/images/linkedin.png", width: width*0.05,),
                  SizedBox(width: width*0.035,),
                  Text("Linkedin", style: Theme.of(context).textTheme.titleMedium)
                ],)
              ),

            ])
        ],
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: width*0.3,
              height: height*0.3,
              child: Image.asset("lib/assets/images/about_us.png")
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: Text("Bu programma türkmen oglan we gyz atlarynyň manysyny düşündirýän ýörite niýetlenen maglumat çeşmesidir. Maksadymyz – halkymyzyň baý dil mirasyna, ýagny türkmen atlarynyň gelip çykyşyna we many taýdan mazmunyna has gowy düşünmäge ýardam bermekdir. Progarmmamyzy ulanmak arkaly siz dürli atlaryň näme many berýändigini öwrenip bilersiňiz. Şeýle hem, çagalaryňyza at saýlanyňyzda peýdaly maglumat tapyp bilersiňiz. Goşundy elmydama täzelenýär we has giňişleýin maglumat bilen baýlaşdyrylýar. Sizi türkmen medeniýetine bolan söýgimizi paýlaşmaga çagyrýarys! \n Eger bu programma barada haýsydyr bir teklibiňiz bar bolsa, bize habar bermegiňizi isleýäris - sizi diňlemäne şat bolarys. ",
              style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.center,),
            )
          ],
        ),
      ),
    );
  }
}