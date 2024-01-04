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

class MembersView extends StatelessWidget {
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
                        Row(
                          children: [
                            Button(
                                text: "Tous",
                                color: Colors.black,
                                fct: () {},
                                backgroundColor: Colors.grey.shade400),
                            Button(
                                text: "Récents",
                                color: Colors.black,
                                fct: () {},
                                backgroundColor: Colors.grey.shade200),
                            Expanded(child: Text("")),
                            Expanded(
                                flex: 1,
                                child: IconButton(
                                    onPressed: () {
                                      print("ajout");
                                    },
                                    icon: Icon(Icons.add)))
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
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
                            return MembersCard(benevole: benevoles[index]);
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

class MembersCard extends StatelessWidget {
  final dynamic benevole;

  const MembersCard({super.key, this.benevole});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: AbstractContainer2(
          content: Row(
        children: [
          Expanded(flex: 0, child: Icon(Icons.ac_unit)),
          SizedBox(
            width: 10,
          ),
          Expanded(flex: 1, child: Text(benevole)),
          Button(
            backgroundColor: marron,
            color: Colors.black,
            fct: () {
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
            text: "Supprimer",
          )
        ],
      )),
    );
  }
}
