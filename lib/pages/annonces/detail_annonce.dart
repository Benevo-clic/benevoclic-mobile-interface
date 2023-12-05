import 'package:flutter/material.dart';
import 'package:namer_app/util/color.dart';
import 'package:namer_app/widgets/abstract_container.dart';
import 'package:namer_app/widgets/button.dart';

class DetailAnnonce extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Container(
            height: 200,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/annonce.png"),
                    fit: BoxFit.cover)),
            child: Row(children: [
              Expanded(
                  child: IconButton(
                      color: Colors.white,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.backspace))),
              Expanded(child: Text("")),
              Expanded(child: Text(""))
            ])),
        SizedBox(
          height: 15,
        ),
        InfosMission(),
        SizedBox(
          height: 15,
        ),
        Bio(text: "feevgzvgerkmvgznbz kzngvozv,gnpznvgzvgrngvpf"),
        SizedBox(
          height: 15,
        ),
        Asso()
      ]),
    );
  }
}

class InfosMission extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width * 0.85,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: orange, width: 2)),
      child: Column(
        children: [
          Row(children: [Expanded(child: Text("Distribution alimentaire"))]),
          Row(
            children: [
              Expanded(
                  child: Button(
                text: "Contacter",
                color: Colors.white,
                backgroundColor: orange,
                fct: () => a(5),
              )),
              Expanded(child: Text("")),
              Expanded(
                  child: Button(
                text: "Participer",
                color: Colors.white,
                backgroundColor: marron,
                fct: () => a(5),
              )),
            ],
          ),
        ],
      ),
    );
  }
}

a(int b) {
  print(b);
}

class Bio extends StatelessWidget {
  final String text;

  Bio({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(15),
        width: MediaQuery.sizeOf(context).width * 0.85,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: orange, width: 2)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [Text("Bio"), SizedBox(height: 5), Text(text)],
        ));
  }
}

class Asso extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AbstractContainer(
        content: Row(
      children: [
        Expanded(
          child: Image.asset(
            "assets/logo.png",
            height: 80,
          ),
        ),
        Expanded(child: Text("Nom asso")),
        Expanded(
          child: Button(
              backgroundColor: Colors.green,
              color: Colors.white,
              fct: () => {},
              text: "Adhérer"),
        )
      ],
    ));
  }
}
