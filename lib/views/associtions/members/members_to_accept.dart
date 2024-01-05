import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:namer_app/cubit/association/association_cubit.dart';
import 'package:namer_app/cubit/association/association_state.dart';
import 'package:namer_app/models/volunteer_model.dart';
import 'package:namer_app/util/color.dart';
import 'package:namer_app/views/associtions/members/member_profil.dart';
import 'package:namer_app/widgets/abstract_container2.dart';
import 'package:namer_app/widgets/app_bar_back.dart';
import 'package:namer_app/widgets/button.dart';
import 'package:namer_app/widgets/searchbar_widget.dart';

class MembersToAccept extends StatelessWidget {
  List<String> benevoles = ["bene 1", "bene 2"];

  TextEditingController myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AssociationCubit, AssociationState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: Column(
            children: [
              AppBarBackWidget(),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 20, 15, 5),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SearchBarWidget(myController: myController),
                        SizedBox(
                          height: 15,
                        ),
                        Text("${benevoles.length} bénévoles",
                            textAlign: TextAlign.start,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Expanded(
                            child: ListView.builder(
                          itemCount: benevoles.length,
                          itemBuilder: (context, index) {
                            return MembersCardToAdd(benevole: benevoles[index]);
                          },
                        ))
                      ]),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class MembersCardToAdd extends StatelessWidget {
  final dynamic benevole;

  const MembersCardToAdd({super.key, this.benevole});
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
                  Navigator.push(
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
                              )));
                },
              )),
          SizedBox(
            width: 10,
          ),
          Column(
            children: [
              Text(benevole),
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
