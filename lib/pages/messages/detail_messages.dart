import 'package:flutter/material.dart';
import 'package:namer_app/color/color.dart';
import 'package:namer_app/widgets/background.dart';

class DetailMessages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Background(
        widget: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
              Expanded(
                child: ListView(
                  padding: EdgeInsets.fromLTRB(10, 25, 10, 0),
                  children: [
                    ItemMessage(text: "ouiegvznfzeknmvfzefbvuzbfeyvyu"),
                    ItemMessage2(text: "fzfefz"),
                    ItemMessage(text: "ouiegvznfzeknmvfzefbvuzbfeyvyu"),
                    ItemMessage2(text: "fzfefz"),
                    ItemMessage(text: "ouiegvznfzeknmvfzefbvuzbfeyvyu"),
                    ItemMessage2(text: "fzfefz"),
                    ItemMessage(text: "ouiegvznfzeknmvfzefbvuzbfeyvyu"),
                    ItemMessage2(text: "fzfefz"),
                    ItemMessage(text: "ouiegvznfzeknmvfzefbvuzbfeyvyu"),
                    ItemMessage2(text: "fzfefz"),
                    ItemMessage(text: "ouiegvznfzeknmvfzefbvuzbfeyvyu"),
                    ItemMessage2(text: "fzfefz"),
                    ItemMessage(text: "ouiegvznfzeknmvfzefbvuzbfeyvyu"),
                    ItemMessage2(text: "fzfefz"),
                    ItemMessage(text: "ouiegvznfzeknmvfzefbvuzbfeyvyu"),
                    ItemMessage2(text: "fzfefz"),
                  ],
                ),
              ),
              Expanded(
                flex: 0,
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: SendMessage(),
                ),
              ),
              SizedBox(
                height: 15,
              )
            ],
          ),
          appBar: AppBar(
            backgroundColor: orange,
            actions: [],
          ),
        ),
        image: "assets/background1.png");
  }
}

class SendMessage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Text("")),
        Expanded(
            child: TextFormField(
          textAlign: TextAlign.left,
          decoration: InputDecoration(
              hintStyle: TextStyle(
                color: Colors.black,
              ),
              border: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(2),
                  borderSide: BorderSide(color: orange)),
              hintText: "Entrez votre message"),
        )),
        Expanded(child: Icon(Icons.send)),
      ],
    );
  }
}

class ItemMessage extends StatelessWidget {
  final String text;

  const ItemMessage({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            flex: 0,
            child: Image.asset(
              "assets/logo.png",
              height: 50,
            )),
        Expanded(
            child: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.red.shade200),
          child: Text(text),
        )),
        Expanded(
          child: Text(""),
        )
      ],
    );
  }
}

class ItemMessage2 extends StatelessWidget {
  final String text;

  const ItemMessage2({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(""),
        ),
        Expanded(
            child: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.red.shade200),
          child: Text(text),
        )),
        Expanded(
            flex: 0,
            child: Image.asset(
              "assets/logo.png",
              height: 50,
            )),
      ],
    );
  }
}
