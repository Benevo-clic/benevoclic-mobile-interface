import 'package:flutter/material.dart';
import 'package:namer_app/widgets/content_widget.dart';

import '../../../widgets/app_bar_widget.dart';
import 'widgets/detail_messages.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
            MediaQuery.of(context).size.height * 0.15), // Hauteur personnalisée
        child: AppBarWidget(contexts: context, label: 'Messages'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(20),
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => DetailMessages()));
                    },
                    child: Item()),
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
    return ContentWidget(
        content: Row(
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