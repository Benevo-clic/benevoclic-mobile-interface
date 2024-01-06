import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:namer_app/cubit/members/members_cubit.dart';
import 'package:namer_app/models/volunteer_model.dart';
import 'package:namer_app/util/color.dart';
import 'package:namer_app/views/associtions/members/member_profil.dart';
import 'package:namer_app/widgets/abstract_container2.dart';
import 'package:namer_app/widgets/button.dart';

class MembersCard extends StatelessWidget {
  final Volunteer benevole;

  const MembersCard({super.key, required this.benevole});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: AbstractContainer2(
          content: Row(
        children: [
          Expanded(
              flex: 0,
              child: IconButton(
                icon: Icon(Icons.ac_unit),
                onPressed: () {
                  /*Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MemberProfil(
                                volunteer: Volunteer(
                                    phone: "052525",
                                    birthDayDate: "",
                                    firstName: "geoffrey",
                                    lastName: "herman",
                                    address: "fczefezfez",
                                    bio: "vezfczfze",
                                    city: "fefe",
                                    email: "vezvz",
                                    imageProfile: "",
                                    myAssociations: [],
                                    postalCode: "",
                                    myAssociationsWaiting: []),
                              )));*/
                              BlocProvider.of<MembersCubit>(context)
                        .detail(benevole.id ?? "");
                },
              )),
          SizedBox(
            width: 10,
          ),
          Expanded(flex: 1, child: Text(benevole.firstName)),
          Button(
            backgroundColor: marron,
            color: Colors.black,
            fct: () {},
            text: "Supprimer",
          )
        ],
      )),
    );
  }
}

class MembersCardToAdd extends StatelessWidget {
  final Volunteer benevole;

  const MembersCardToAdd({super.key, required this.benevole});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: AbstractContainer2(
          content: Row(
        children: [
          Expanded(
              flex: 0,
              child: IconButton(
                icon: Icon(Icons.ac_unit),
                onPressed: () {

                  BlocProvider.of<MembersCubit>(context)
                        .detail(benevole.id ?? "");
                  /*Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MemberProfil(
                                volunteer: Volunteer(
                                    phone: "052525",
                                    birthDayDate: "",
                                    firstName: "geoffrey",
                                    lastName: "herman",
                                    address: "fczefezfez",
                                    bio: "vezfczfze",
                                    city: "fefe",
                                    email: "vezvz",
                                    imageProfile: "",
                                    myAssociations: [],
                                    postalCode: "",
                                    myAssociationsWaiting: []),
                              )));*/
                },
              )),
          SizedBox(
            width: 10,
          ),
          Column(
            children: [
              Text("${benevole.firstName} ${benevole.lastName}"),
              Row(
                children: [
                  Button(
                    backgroundColor: Colors.blue.shade800,
                    color: Colors.white,
                    fct: () {},
                    text: "Accepter",
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Button(
                    backgroundColor: marron,
                    color: Colors.white,
                    fct: () {},
                    text: "Refuser",
                  )
                ],
              ),
            ],
          ),
        ],
      )),
    );
  }
}
