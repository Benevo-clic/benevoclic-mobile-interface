import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:namer_app/cubit/volunteer/volunteer_cubit.dart';
import 'package:namer_app/cubit/volunteer/volunteer_state.dart';
import 'package:namer_app/util/color.dart';
import 'package:namer_app/widgets/abstract_container2.dart';

class AssociationsSub extends StatelessWidget {
  final List assos = ["asso1", "asso2"];

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
              Text("${state.volunteer!.myAssociations!.length} associations",
                  textAlign: TextAlign.start,
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
                child: ListView.builder(
                  itemCount: state.volunteer!.myAssociations!.length,
                  itemBuilder: (context, index) {
                    return AssociationCard(
                        asso: state.volunteer!.myAssociations![index]);
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

class AssociationCard extends StatelessWidget {
  final dynamic asso;

  const AssociationCard({super.key, this.asso});
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
