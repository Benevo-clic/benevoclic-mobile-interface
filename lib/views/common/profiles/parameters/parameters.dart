import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:namer_app/type/rules_type.dart';
import 'package:namer_app/views/common/profiles/parameters/widget/parameters_card.dart';
import 'package:namer_app/views/common/profiles/widget/pop_dialog.dart';
import 'package:namer_app/views/volunteers/profil/parameter/phone_number.dart';
import 'package:namer_app/widgets/content_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../cubit/announcement/announcement_cubit.dart';
import '../../../../cubit/announcement/announcement_state.dart';
import '../../../../cubit/involved_associations/involved_association_cubit.dart';
import '../../../../cubit/user/user_cubit.dart';
import '../../../../main.dart';
import '../../../../models/association_model.dart';
import '../../../../models/volunteer_model.dart';
import '../../../../repositories/google/auth_repository.dart';
import '../../../../widgets/app_bar_back.dart';

class ParametersView extends StatelessWidget {
  RulesType rule;
  Association? association;
  Volunteer? volunteer;

  ParametersView({required this.rule, this.association, this.volunteer});

  Widget _buildContentText(BuildContext context) {
    String text = '';

    if (rule == RulesType.USER_ASSOCIATION) {
      text =
          'Cette fonctionnalité sera disponible prochainement. Restez à l\'écoute!';
    } else if (rule == RulesType.USER_VOLUNTEER) {
      text =
          'Cette fonctionnalité sera disponible prochainement. Restez à l\'écoute!';
    }

    return Text(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.15),
        child: AppBarBackWidgetFct(
          fct: (value) => {
            if (context == null)
              {BlocProvider.of<InvolvedAssociationCubit>(context).initState("")}
            else
              {
                Navigator.pop(context),
              }
          },
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(15),
        children: [
          ContentWidget(
              content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: ParameterCard(
                    title: "Préférence",
                    icon: Icon(Icons.info),
                    content: Column(
                      children: [
                        ParameterLine(
                            title: "Informations personnelles",
                            fct: (context) => {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        if (rule == RulesType.USER_VOLUNTEER) {
                                          return PopDialog(
                                            content: _buildContentText(context),
                                          );
                                        } else {
                                          return PopDialog(
                                            content: _buildContentText(context),
                                          );
                                        }
                                      })
                                }),
                        Divider(
                          color: Colors.white,
                        ),
                        ParameterLine(
                            title: "Notifications",
                            fct: (context) => {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return PopDialog(
                                            content:
                                                _buildContentText(context));
                                      })
                                }),
                        Divider(
                          color: Colors.white,
                        ),
                        ParameterLine(
                            title: "Langue (Français)", fct: (value) => {}),
                        Divider(
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            color: Colors.white,
          ),
          ContentWidget(
              content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: ParameterCard(
                    title: "Connexion et Sécurité",
                    icon: Icon(Icons.shield_rounded),
                    content: Column(
                      children: [
                        ParameterLine(
                            title: "Mot de passe",
                            fct: (context) => {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return PopDialog(
                                            content:
                                                _buildContentText(context));
                                      })
                                }),
                        SizedBox(
                          height: 15,
                        ),
                        ParameterLine(
                            title: "Numéro de téléphone",
                            fct: (context) => {
                                  showDialog(
                                      context: context,
                                      builder: ((context) {
                                        if (rule == RulesType.USER_VOLUNTEER) {
                                          return PopDialog(
                                              content: PhoneDialog());
                                        } else {
                                          return PopDialog(
                                              content:
                                                  _buildContentText(context));
                                        }
                                      }))
                                }),
                        SizedBox(
                          height: 15,
                        ),
                        ParameterLine(
                            title: "E-mail",
                            fct: (context) => {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return PopDialog(
                                            content:
                                                _buildContentText(context));
                                      }),
                                }),
                        SizedBox(
                          height: 15,
                        ),
                        ParameterLine(
                            title: "Sécurité de compte", fct: (value) => {}),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Divider(
            color: Colors.white,
          ),
          ContentWidget(
              content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: ParameterCard(
                    title: "Aide",
                    icon: Icon(Icons.question_mark_outlined),
                    content: Column(
                      children: [
                        ParameterLine(
                            title: "Informations légales", fct: (value) => {}),
                        SizedBox(
                          height: 15,
                        ),
                        InkWell(
                          onTap: (() async {
                            if (rule == RulesType.USER_VOLUNTEER) {
                              BlocProvider.of<UserCubit>(context)
                                  .disconnect()
                                  .then((_) async =>
                                      await AuthRepository().signOut());

                              BlocProvider.of<AnnouncementCubit>(context)
                                  .changeState(AnnouncementInitialState());

                              final SharedPreferences preferences =
                                  await SharedPreferences.getInstance();
                              preferences.setBool('Volunteer', false);
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MyApp(),
                                ),
                              );
                            }
                            if (rule == RulesType.USER_ASSOCIATION) {
                              BlocProvider.of<UserCubit>(context)
                                  .disconnect()
                                  .then((_) async =>
                                      await AuthRepository().signOut());
                              BlocProvider.of<AnnouncementCubit>(context)
                                  .changeState(AnnouncementInitialState());

                              final SharedPreferences preferences =
                                  await SharedPreferences.getInstance();
                              preferences.setBool('Association', false);
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MyApp(),
                                ),
                              );
                            }
                          }),
                          child: Row(
                            children: [
                              Expanded(child: Text("Me déconnecter")),
                              Expanded(
                                  flex: 0,
                                  child: Icon(Icons.arrow_forward_ios_rounded)),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
