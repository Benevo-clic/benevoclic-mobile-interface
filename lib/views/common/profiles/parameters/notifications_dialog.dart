import 'package:flutter/material.dart';
import 'package:namer_app/widgets/switch_button.dart';
import 'package:namer_app/widgets/title_with_icon.dart';
import 'package:namer_app/widgets/title_with_switch.dart';

class NotificationsDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NotificationsState();
  }
}

class _NotificationsState extends State<NotificationsDialog> {
  final _formKey = GlobalKey<FormState>();

  bool messages = false;
  bool newAnnouncment = false;
  bool expirationAnnouncement = false;
  bool completeMission = false;
  bool newAdhesion = false;
  bool volunteerAccepted = false;

  @override
  Widget build(BuildContext context) {
    changeNewMessages(bool value) {
      setState(() {
        messages = value;
      });
    }

    changeNewAnnouncement(bool value) {
      setState(() {
        newAnnouncment = value;
      });
    }

    changeAnnouncement(bool value) {
      setState(() {
        expirationAnnouncement = value;
      });
    }

    changeCompleteMission(bool value) {
      setState(() {
        completeMission = value;
      });
    }

    changeNewAdhesion(bool value) {
      setState(() {
        newAdhesion = value;
      });
    }

    changeVolunteerAccepted(bool value) {
      setState(() {
        volunteerAccepted = value;
      });
    }

    return Column(children: [
      TitleWithIcon(
          title: "Notifications", icon: Icon(Icons.notification_important)),
      Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: 25,
              ),
              TitleWithSwitch(
                  content: SwitchButton(
                    value: messages,
                    fct: changeNewMessages,
                  ),
                  text: "Nouveaux messages"),
              TitleWithSwitch(
                  content: SwitchButton(
                    value: newAnnouncment,
                    fct: changeNewAnnouncement,
                  ),
                  text: "Mise en ligne des annonces"),
              TitleWithSwitch(
                  content: SwitchButton(
                    value: expirationAnnouncement,
                    fct: changeAnnouncement,
                  ),
                  text: "Expiration des annonces"),
              TitleWithSwitch(
                  content: SwitchButton(
                    value: completeMission,
                    fct: changeCompleteMission,
                  ),
                  text: "Annoncer lorsqu'une mission est complète"),
              TitleWithSwitch(
                  content: SwitchButton(
                    value: newAdhesion,
                    fct: changeNewAdhesion,
                  ),
                  text: "Annoncer les demandes d'adhésion"),
              TitleWithSwitch(
                  content: SwitchButton(
                    value: volunteerAccepted,
                    fct: changeVolunteerAccepted,
                  ),
                  text: "Annoncer lorqu'un benevole accepte une mission"),
            ],
          ))
    ]);
  }
}
