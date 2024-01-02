import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:namer_app/cubit/association/association_cubit.dart';
import 'package:namer_app/cubit/association/association_state.dart';
import 'package:namer_app/util/color.dart';
import 'package:namer_app/views/volunteers/profil/associations_view.dart';
import 'package:namer_app/widgets/abstract_container2.dart';

class MembersView extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AssociationCubit, AssociationState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: orange,
            iconTheme: IconThemeData(color: Colors.white),
          ),
          body: Padding(
            padding: const EdgeInsets.all(25.0),
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
              SearchBar(
                leading: Icon(Icons.search, color: Colors.black),
              ),
              SizedBox(
                height: 15,
              ),
              Text("${state.association!.volunteers!.length} bénévoles",
                  textAlign: TextAlign.start,
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
                child: ListView.builder(
                  itemCount: state.association!.volunteers!.length,
                  itemBuilder: (context, index) {
                    return AssociationCard(
                        asso: state.association!.volunteers![index]);
                  },
                ),
              ))
            ]),
          ),
        );
      },
    );
  }
}

class MembersCard extends StatelessWidget {
  final dynamic asso;

  const MembersCard({super.key, this.asso});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: AbstractContainer2(
          content: Row(
        children: [
          Expanded(child: Icon(Icons.ac_unit)),
          Expanded(child: Text(asso)),
          ElevatedButton(
            onPressed: () {},
            child: Text("Abonner", maxLines: 1),
          ),
        ],
      )),
    );
  }
}
