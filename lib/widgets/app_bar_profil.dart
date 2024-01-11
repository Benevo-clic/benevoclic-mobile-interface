import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:namer_app/cubit/volunteer/volunteer_cubit.dart';
import 'package:namer_app/models/volunteer_model.dart';
import 'package:namer_app/views/volunteers/profil/update_profil_volunteer.dart';

import '../cubit/association/association_cubit.dart';
import '../cubit/association/association_state.dart';
import '../cubit/volunteer/volunteer_state.dart';
import '../models/association_model.dart';
import '../type/rules_type.dart';
import '../views/associtions/profil/update_profil_association.dart';
import '../views/common/profiles/parameters/parameters.dart';

class AppBarProfile extends StatelessWidget {
  Association? association;
  Volunteer? volunteer;

  AppBarProfile({super.key, this.association, this.volunteer});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return AppBar(
      elevation: 0,
      backgroundColor: Color.fromRGBO(255, 153, 85, 1),
      leading: IconButton(
        icon: Image.asset(
          'assets/logo.png',
          width: width * .11,
          height: height * .07,
        ),
        onPressed: () {},
      ),
      actions: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey[300],
          ),
          width: 30,
          child: IconButton(
            icon: SvgPicture.asset(
              "assets/icons/pencil.svg",
              height: height * .02,
              color: Colors.black,
            ),
            onPressed: () {
              if (association != null) {
                BlocProvider.of<AssociationCubit>(context).changeState(
                    AssociationUpdatingState(associationModel: association!));
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UpdateProfileAssociation(
                      association: association!,
                    ),
                  ),
                );
              } else if (volunteer != null) {
                BlocProvider.of<VolunteerCubit>(context).changeState(
                    VolunteerUpdatingState(volunteerModel: volunteer!));
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UpdateProfileVolunteer(
                      volunteer: volunteer!,
                    ),
                  ),
                );
              }
            },
          ),
        ),
        SizedBox(
          width: 5,
        ),
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey[300],
          ),
          width: 30,
          child: IconButton(
            padding: EdgeInsets.zero,
            icon: Icon(Icons.settings, color: Colors.black),
            onPressed: () {
              if (association != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ParametersView(
                      rule: RulesType.USER_ASSOCIATION,
                      association: association,
                    ),
                  ),
                );
              } else if (volunteer != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ParametersView(
                      rule: RulesType.USER_VOLUNTEER,
                      volunteer: volunteer,
                    ),
                  ),
                );
              }
            },
          ),
        ),
        SizedBox(
          width: 15,
        ),
      ],
    );
  }
}
