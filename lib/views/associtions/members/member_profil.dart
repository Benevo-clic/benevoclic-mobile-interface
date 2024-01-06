import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:namer_app/cubit/members/members_cubit.dart';
import 'package:namer_app/models/volunteer_model.dart';
import 'package:namer_app/views/common/profiles/widget/section_profil.dart';
import 'package:namer_app/widgets/abstract_container2.dart';
import 'package:namer_app/widgets/app_bar_back.dart';
import 'package:namer_app/widgets/container3.dart';
import 'package:namer_app/widgets/title_with_icon.dart';

class MemberProfil extends StatelessWidget {
  final Volunteer volunteer;

  const MemberProfil({super.key, required this.volunteer});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(children: [
                AppBarBackWidgetFct(
            fct: (value) =>
                BlocProvider.of<MembersCubit>(context).initState(value)),
                Icon(
          Icons.pie_chart_outline_sharp,
          size: MediaQuery.sizeOf(context).height * 0.2,
                ),
                SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.03,
                ),
                Container3(
            content: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "${volunteer.firstName} ${volunteer.lastName}",
                textAlign: TextAlign.center,
              ),
              Text("${volunteer.myAssociations} associations")
            ],
          ),
                )),
                SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.03,
                ),
                AbstractContainer2(content: Text(volunteer.bio ?? "aucune bio")),
                SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.03,
                ),
                AbstractContainer2(
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleWithIcon(
                  title: "Informations", icon: Icon(Icons.location_city)),
              Divider(
                height: 25,
                color: Colors.white,
              ),
              Section(
                  text: volunteer.address ?? "no address",
                  icon: Icon(Icons.location_on_outlined)),
              Divider(
                height: 25,
                color: Colors.white,
              ),
              Section(
                  text: volunteer.email ?? "no email", icon: Icon(Icons.mail)),
              Divider(
                height: 25,
                color: Colors.white,
              ),
              Section(text: volunteer.phone, icon: Icon(Icons.phone_android)),
            ],
          ),
                ),
                SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.03,
                ),
                AbstractContainer2(
            content: TitleWithIcon(
          icon: Icon(Icons.text_snippet_outlined),
          title: "Annones",
                )),
              ]),
        ));
  }
}
