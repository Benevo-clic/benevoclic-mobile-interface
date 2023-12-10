import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Counter increments smoke test', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: Item(mot: "oui"),
      ),
    ));

    expect(find.text("oui"), findsOneWidget);
  });

  /*testWidgets('test de la premiere page', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(body: Home_page()),
    ));

    expect(find.text("Association"), findsOneWidget);
  });*/

  test('test', () {
    var u = User("bonjour");
    expect(u.getName(), "bonjour");
  });
}

class User {
  var name = "";

  User(String nameParam) {
    name = nameParam;
  }

  String getName() {
    return name;
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
