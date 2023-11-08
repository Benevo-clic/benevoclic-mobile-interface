import 'package:flutter/material.dart';

/// Flutter code sample for [NavigationBar].

void main() => runApp(const NavigationBarApp());

class NavigationBarApp extends StatelessWidget {
  const NavigationBarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: NavigationExample());
  }
}

class NavigationExample extends StatefulWidget {
  const NavigationExample({super.key});

  @override
  State<NavigationExample> createState() => _NavigationExampleState();
}

class _NavigationExampleState extends State<NavigationExample> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.amber[800],
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.business),
            label: 'Business',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.school),
            icon: Icon(Icons.school_outlined),
            label: 'School',
          ),
        ],
      ),
      body: <Widget>[
        Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/background2.png"),
                    fit: BoxFit.cover)),
            alignment: Alignment.center,
            child: annonce()),
        Container(
            color: Colors.green,
            alignment: Alignment.center,
            child: ListView(
              padding: const EdgeInsets.all(15),
              children: <Widget>[
                Container(
                  height: 50,
                  color: Colors.amber[600],
                  child: const Center(child: Text('Entry A')),
                ),
                Container(
                  height: 50,
                  color: Colors.amber[500],
                  child: const Center(child: Text('Entry B')),
                ),
                Item(mot: "moi")
              ],
            )),
        Container(
          color: Colors.blue,
          alignment: Alignment.center,
          child: const Text('Page 3'),
        ),
      ][currentPageIndex],
    );
  }
}

class Item extends StatelessWidget {
  final String mot;

  const Item({super.key, required this.mot});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50,
        color: Colors.amber[400],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.business),
            Text(mot),
          ],
        ));
  }
}

class annonce extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(height: 50),
      Text("Mon annonce",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
      SizedBox(height: 50),
      Container(
          width: MediaQuery.of(context).size.width * 0.65,
          height: MediaQuery.of(context).size.height * 0.70,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
                color: Colors.black, width: 3.0, style: BorderStyle.solid),
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: Column(children: [
            Container(
                width: 250,
                padding: EdgeInsets.all(15),
                child: Text("Une bonne annonce et hop c'est dans la poche !",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.orange.shade800,
                    ))),
            LineContent(titreSection: "nombre de benevoles"),
            LineContent(titreSection: "nombre d'heures de la mission"),
            LineContent(titreSection: "Date et heure de la mission"),
            LineContent(titreSection: "Localisation de la mission"),
          ])),
    ]);
  }
}


//abstract class
class LineContent extends StatelessWidget {
  final String titreSection;

  const LineContent({super.key, required this.titreSection});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white ,border: Border.all(color: Colors.grey.shade500) ),
          //width: MediaQuery.of(context).size.width * 0.3,
          padding: const EdgeInsets.all(6.0),
          child: Text(titreSection, textAlign: TextAlign.center,style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 13,
          )),
        )
      ],
    );
  }
}
