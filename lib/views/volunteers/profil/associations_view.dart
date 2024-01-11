import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:namer_app/cubit/involved_associations/involved_association_cubit.dart';
import 'package:namer_app/cubit/involved_associations/involved_association_state.dart';
import 'package:namer_app/models/association_model.dart';
import 'package:namer_app/util/color.dart';
import 'package:namer_app/views/volunteers/profil/association_profil.dart';
import 'package:namer_app/widgets/app_bar_back.dart';
import 'package:namer_app/widgets/button.dart';
import 'package:namer_app/widgets/content_widget.dart';
import 'package:namer_app/widgets/searchbar_widget.dart';

class AssociationsSub extends StatefulWidget {
  final List<Association> associations;

  const AssociationsSub({super.key, required this.associations});

  @override
  State<StatefulWidget> createState() {
    return _AssociationsSubState(associations: associations);
  }
}

class _AssociationsSubState extends State<AssociationsSub> {
  List<Association> associations;
  List<Association> allAssociations = [];
  TextEditingController myController = TextEditingController();

  _AssociationsSubState({required this.associations});

  @override
  Widget build(BuildContext context) {
    print(associations);
    return BlocConsumer<InvolvedAssociationCubit, InvolvedAssociationState>(
      listener: (context, state) {},
      builder: (context, state) {
        allAssociations = state.associations;
        if (state is InvolvedAssociationAcceptedState) {
          return Scaffold(
              body: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                              ElevatedButton(
                                  onPressed: () {}, child: Text("Tous")),
                              ElevatedButton(
                                  onPressed: () {}, child: Text("Récents"))
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          SearchBarWidget(
                              myController: myController, fct: search),
                          SizedBox(
                            height: 15,
                          ),
                          Text("${state.associations.length} associations",
                              textAlign: TextAlign.start,
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Expanded(
                              child: ListView.builder(
                            itemCount: associations.length,
                            itemBuilder: (context, index) {
                              return AssociationCard(
                                  association: associations[index]);
                            },
                          )),
                        ]),
                  ),
                ),
              ]));
        } else if (state is InvolvedAssociationDetailState) {
          return AssociationProfil(association: state.association);
        } else {
          return Text("");
        }
      },
    );
  }

  void search(String query) {
    final result = allAssociations.where((association) {
      final name = association.name.toLowerCase();
      final input = query.toLowerCase();
      print(input);
      return name.contains(input);
    }).toList();

    print(result);
    setState(() => associations = result);
  }
}

class AssociationCard extends StatelessWidget {
  final Association association;

  const AssociationCard({super.key, required this.association});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: ContentWidget(
          content: Row(
        children: [
          Expanded(
              flex: 0,
              child: IconButton(
                icon: Icon(Icons.ac_unit),
                onPressed: () {
                  BlocProvider.of<InvolvedAssociationCubit>(context)
                      .detail(association.id ?? "id");
                },
              )),
          SizedBox(
            width: 10,
          ),
          Expanded(flex: 1, child: Text(association.name)),
          Button(
            backgroundColor: marron,
            color: Colors.black,
            fct: () {},
            text: "Se désabonner",
          )
        ],
      )),
    );
  }
}
