import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

enum ContactOption { call, sms, email }

class ContactAssociationWidget extends StatelessWidget {
  final String? phoneNumber;
  final String? email;

  ContactAssociationWidget({super.key, this.phoneNumber, this.email});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        final RenderBox button = context.findRenderObject() as RenderBox;
        final Offset buttonPosition = button.localToGlobal(Offset.zero);
        final Size buttonSize = button.size;

        // Calculer la position pour le menu contextuel
        final RelativeRect menuPosition = RelativeRect.fromLTRB(
          buttonPosition.dx,
          buttonPosition.dy,
          buttonPosition.dx + buttonSize.width,
          buttonPosition.dy + buttonSize.height,
        );

        // Afficher le menu contextuel
        showMenu<ContactOption>(
          context: context,
          position: menuPosition,
          items: [
            const PopupMenuItem<ContactOption>(
              value: ContactOption.call,
              child: Text('Appeler'),
            ),
            const PopupMenuItem<ContactOption>(
              value: ContactOption.sms,
              child: Text('Envoyer un SMS'),
            ),
            const PopupMenuItem<ContactOption>(
              value: ContactOption.email,
              child: Text('Envoyer un email'),
            ),
          ],
          elevation: 8.0,
        ).then<void>((ContactOption? selectedItem) async {
          if (selectedItem == ContactOption.call) {
            final Uri phoneLaunchUri0 = Uri(scheme: 'tel', path: phoneNumber!);

            if (await canLaunchUrl(phoneLaunchUri0)) {
              await launchUrl(phoneLaunchUri0);
            } else {
              print('Could not launch $phoneNumber');
            }
          } else if (selectedItem == ContactOption.sms) {
            final Uri phoneLaunchUri = Uri(scheme: 'sms', path: phoneNumber!);

            if (await canLaunchUrl(phoneLaunchUri)) {
              await launchUrl(phoneLaunchUri);
            } else {
              print('Could not launch $phoneNumber');
            }
          } else if (selectedItem == ContactOption.email) {
            final Uri emailLaunchUri = Uri(
              scheme: 'mailto',
              path: email!,
            );

            if (await canLaunchUrl(emailLaunchUri)) {
              await launchUrl(emailLaunchUri);
            } else {
              print('Could not launch $email');
            }
          }
        });
      },
      style: TextButton.styleFrom(
        backgroundColor: Color.fromRGBO(235, 126, 26, 1),
        padding: EdgeInsets.all(0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: Colors.black, width: 1),
        ),
      ),
      child: Text(
        "Nous contacter",
        style: TextStyle(
            color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
      ),
    );
  }
}
