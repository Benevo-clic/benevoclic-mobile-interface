import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:namer_app/views/associtions/publish/publish_association_views.dart';

void main() {
  testWidgets('Test views, HomePage', (tester) async {
    await tester.pumpWidget(MaterialApp(home: PublishAnnouncement()));

    expect(find.text("Titre de l'annonce"), findsOneWidget);
    expect(find.text("Description"), findsOneWidget);
    expect(find.text("Nombre de bénévoles"), findsOneWidget);
    expect(find.text("Nombre d'heures"), findsOneWidget);
  });
}
