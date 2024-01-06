import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../cubit/announcement/announcement_cubit.dart';

class AppBarFilter extends StatelessWidget {
  String? idAssociation;
  final VoidCallback? onReset;

  AppBarFilter({super.key, this.idAssociation, this.onReset});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      width: MediaQuery.of(context).size.width,
      height: 100,
      decoration: BoxDecoration(
        color: Color.fromRGBO(255, 153, 85, 1),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 0,
            blurRadius: 10,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  if (idAssociation != null && idAssociation != '') {
                    BlocProvider.of<AnnouncementCubit>(context)
                        .getAllAnnouncementByAssociation(idAssociation!);
                  } else {
                    BlocProvider.of<AnnouncementCubit>(context)
                        .getAllAnnouncements();
                  }
                  Navigator.pop(context);
                },
                icon: SvgPicture.asset(
                  "assets/icons/cancel.svg",
                  color: Colors.white,
                  height: MediaQuery.of(context).size.height * 0.04,
                ), // Définissez la taille de l'icône
              ),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                    side: BorderSide(color: Colors.black87),
                  ),
                ),
                onPressed: () {
                  if (onReset != null) onReset!();
                },
                child: Text(
                  "Tout effacer",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
