import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:namer_app/cubit/volunteer/volunteer_cubit.dart';
import 'package:namer_app/cubit/volunteer/volunteer_state.dart';
import 'package:namer_app/models/association_model.dart';
import 'package:namer_app/util/color.dart';
import 'package:namer_app/views/volunteers/associations/association_profil.dart';
import 'package:namer_app/widgets/abstract_container2.dart';
import 'package:namer_app/widgets/button.dart';
import 'package:namer_app/widgets/searchbar_widget.dart';

class AssociationsSub extends StatelessWidget {
  final List assos = ["association 1", "association 2"];

  TextEditingController myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VolunteerCubit, VolunteerState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: orange,
            iconTheme: IconThemeData(color: Colors.white),
          ),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                children: [
                  ElevatedButton(onPressed: () {}, child: Text("Tous")),
                  ElevatedButton(onPressed: () {}, child: Text("Récents"))
                ],
              ),
              SizedBox(
                height: 15,
              ),
              SearchBarWidget(myController: myController),
              SizedBox(
                height: 15,
              ),
              Text("${state.volunteer!.myAssociations!.length} associations",
                  textAlign: TextAlign.start,
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
                child: ListView.builder(
                  itemCount:
                      assos.length, //state.volunteer!.myAssociations!.length,
                  itemBuilder: (context, index) {
                    return AssociationCard(asso: assos[index]);
                  },
                ),
              )),
            ]),
          ),
        );
      },
    );
  }
}

class AssociationCard extends StatelessWidget {
  final dynamic asso;

  const AssociationCard({super.key, this.asso});
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
                          builder: (context) => AssociationProfil(
                                association: Association(
                                    name: "fefe", phone: "phone", type: "type"),
                              )));
                },
              )),
          SizedBox(
            width: 10,
          ),
          Expanded(flex: 1, child: Text(asso)),
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
