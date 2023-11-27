import 'package:flutter/material.dart';
import 'package:namer_app/color/color.dart';

class Annonces extends StatelessWidget {
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
                    Expanded(child: Center(child: Container(
                      decoration: BoxDecoration(
                        
                      ),
                      child: Text("Search"),))),
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
                  ItemAnnonce(),
                  SizedBox(
                    height: 10,
                  ),
                  ItemAnnonce(),
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

class ItemAnnonce extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: marron, width: 2)),
        child: Column(
          children: [
            Row(
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
                      Text("Asso"),
                      SizedBox(height: 5),
                    ],
                  ),
                
                ),
                Expanded(child: Icon(Icons.settings_rounded),)
              ],
            ),
          ],
        ));
  }
}
