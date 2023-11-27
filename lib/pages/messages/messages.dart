import 'package:flutter/material.dart';
import 'package:namer_app/color/color.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 170,
              child: Container(
                color: orange,
                child: Row(
                  children: [
                    Expanded(
                        child: Center(
                            child: Image.asset(
                      "assets/logo.png",
                      height: 70,
                    ))),
                    Expanded(child: Center(child: SearchBar())),
                    Expanded(
                        child: Center(child: Icon(Icons.manage_search_sharp))),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(20),
                children: [
                  Item(),
                  SizedBox(
                    height: 10,
                  ),
                  Item(),
                  SizedBox(
                    height: 10,
                  ),
                  Item(),
                  SizedBox(
                    height: 10,
                  ),
                  Item(),
                  SizedBox(
                    height: 10,
                  ),
                  Item(),
                  SizedBox(
                    height: 10,
                  ),
                  Item(),
                  SizedBox(
                    height: 10,
                  ),
                  Item(),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Item extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: marron, width: 2)),
        child: Row(
          children: [
            Expanded(
                flex: 0,
                child: Image.asset(
                  "assets/logo.png",
                  height: 50,
                )),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text("Benevole"),
                  SizedBox(height: 5),
                  Text(
                      "Vous avez un nouveau benevole.Vous avez un nouveau benevole")
                ],
              ),
            ),
          ],
        ));
  }
}
