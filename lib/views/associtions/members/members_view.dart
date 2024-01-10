import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:namer_app/views/associtions/members/item_members.dart';
import 'package:namer_app/cubit/members/members_cubit.dart';
import 'package:namer_app/cubit/members/members_state.dart';
import 'package:namer_app/models/volunteer_model.dart';
import 'package:namer_app/views/associtions/members/member_profil.dart';
import 'package:namer_app/widgets/app_bar_back.dart';
import 'package:namer_app/widgets/button.dart';
import 'package:namer_app/widgets/searchbar_widget.dart';

class MembersView extends StatefulWidget {
  final List<Volunteer> volunteers;

  const MembersView({super.key, required this.volunteers});
  @override
  State<StatefulWidget> createState() {
    return _MembersViewState(volunteers: volunteers);
  }
}

class _MembersViewState extends State<MembersView> {
  List<Volunteer> volunteers;
  List<Volunteer> allVolunteers = [];
  TextEditingController myController = TextEditingController();

  _MembersViewState({required this.volunteers});

  @override
  Widget build(BuildContext context) {
    print(volunteers);
    return BlocConsumer<MembersCubit, MembersState>(
      listener: (context, state) {},
      builder: (context, state) {
        allVolunteers = state.volunteers;
        if (state is MembersAcceptedState) {
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
                                        BlocProvider.of<MembersCubit>(context)
                                            .membersToAccept("");
                                        print("ajout");
                                      },
                                      icon: Icon(Icons.add)))
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
                          Text("${volunteers.length} bénévoles",
                              textAlign: TextAlign.start,
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Expanded(
                              child: ListView.builder(
                            itemCount: volunteers.length,
                            itemBuilder: (context, index) {
                              return MembersCard(benevole: volunteers[index]);
                            },
                          ))
                        ]),
                  ),
                ),
              ],
            ),
          );
        } else if (state is MembersToAcceptState) {
          return Scaffold(
            body: Column(
              children: [
                AppBarBackWidgetFct(
                    fct: (value) => BlocProvider.of<MembersCubit>(context)
                        .initState(value)),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 20, 15, 5),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SearchBarWidget(
                              myController: myController, fct: search),
                          SizedBox(
                            height: 15,
                          ),
                          Text("${volunteers.length} bénévoles",
                              textAlign: TextAlign.start,
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Expanded(
                              child: ListView.builder(
                            itemCount: volunteers.length,
                            itemBuilder: (context, index) {
                              return MembersCardToAdd(
                                  benevole: volunteers[index]);
                            },
                          ))
                        ]),
                  ),
                ),
              ],
            ),
          );
        } else if (state is MembersLoadingState) {
          return CircularProgressIndicator();
        } else if (state is MembersDetailState) {
          return MemberProfil(
            volunteer: Volunteer(
                firstName: "firstName",
                lastName: "lastName",
                phone: "phone",
                birthDayDate: "irthDayDate"),
          );
        } else {
          return Text('');
        }
      },
    );
  }

  void search(String query) {
    final result = allVolunteers.where((volunteer) {
      final name = volunteer.firstName.toLowerCase();
      final input = query.toLowerCase();
      print(input);
      return name.contains(input);
    }).toList();

    print(result);
    setState(() => volunteers = result);
  }
}
