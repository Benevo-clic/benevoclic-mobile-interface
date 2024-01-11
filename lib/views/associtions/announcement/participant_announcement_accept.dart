import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:namer_app/cubit/volunteer/volunteer_cubit.dart';
import 'package:namer_app/cubit/volunteer/volunteer_state.dart';
import 'package:namer_app/models/volunteer_model.dart';
import 'package:namer_app/views/associtions/announcement/participant_announcement_waiting.dart';

import '../../../cubit/announcement/announcement_cubit.dart';
import '../../../cubit/announcement/announcement_state.dart';
import '../../../models/announcement_model.dart';
import '../../../repositories/api/volunteer_repository.dart';
import '../../../util/color.dart';
import '../../../widgets/app_bar_back.dart';

class ParticipantAnnouncementAccept extends StatefulWidget {
  Announcement? announcement;

  ParticipantAnnouncementAccept({super.key, this.announcement});

  @override
  State<ParticipantAnnouncementAccept> createState() =>
      _ParticipantAnnouncementAcceptState();
}

class _ParticipantAnnouncementAcceptState
    extends State<ParticipantAnnouncementAccept> {
  final TextEditingController _controller = TextEditingController();
  VolunteerRepository _volunteerRepository = VolunteerRepository();

  @override
  void initState() {
    super.initState();
  }

  _toggleRefuse(Announcement announcement, String? idVolunteer) async {
    var isParticipant = announcement.volunteers!
        .map((e) => e.id)
        .toList()
        .contains(idVolunteer);
    if (isParticipant) {
      BlocProvider.of<AnnouncementCubit>(context)
          .unregisterAnnouncement(announcement.id, idVolunteer!);
    }

    setState(() {});
  }

  Future<List<Volunteer>> _processAnnouncements() async {
    await Future.delayed(Duration(milliseconds: 500));
    List<Volunteer> loadedVolunteer = [];

    for (var volunteer in widget.announcement!.volunteers!) {
      Volunteer volunteerLoaded =
          await _volunteerRepository.getVolunteer(volunteer.id);
      loadedVolunteer.add(volunteerLoaded);
    }

    return loadedVolunteer;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double iconSize = 0.05 * (width < height ? width : height);
    return BlocConsumer<AnnouncementCubit, AnnouncementState>(
      listener: (context, state) {
        if (state is AnnouncementLoadedStateWithoutAnnouncements) {
          widget.announcement = state.announcements.firstWhere(
              (element) => element.id == widget.announcement!.id,
              orElse: () => widget.announcement!);
        }
        if (state is AnnouncementRemovedParticipateState) {
          widget.announcement = state.announcement;
          BlocProvider.of<AnnouncementCubit>(context)
              .getAllAnnouncementByAssociation(
                  widget.announcement!.idAssociation!);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Column(
            children: [
              AppBarBackWidget(),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: SizedBox(
                        height: 25,
                        width: 90,
                        child: TextButton(
                          onPressed: () {
                            // BlocProvider.of<PageCubit>(context).setPage(3);
                            // Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Color.fromRGBO(217, 217, 217, 1),
                            padding: EdgeInsets.all(0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "Accepter",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                                decoration: TextDecoration.none,
                              ),
                            ),
                          ),
                        ),
                      )),
                  SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    height: 25,
                    width: 90,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation1, animation2) =>
                                ParticipantAnnouncementWaiting(
                              announcement: widget.announcement,
                            ),
                            transitionDuration: Duration(milliseconds: 1),
                            // Durée très courte
                            reverseTransitionDuration:
                                Duration(milliseconds: 1),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromRGBO(217, 217, 217, 1),
                        padding: EdgeInsets.all(0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "en attente",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: width * 0.9,
                height: height * 0.05,
                // Hauteur fixe, par exemple 40 pixels
                child: TextFormField(
                  controller: _controller,
                  onChanged: (value) {
                    setState(() {
                      print(value);
                    });
                  },
                  cursorColor: Color.fromRGBO(30, 29, 29, 1.0),
                  decoration: InputDecoration(
                    hintText: 'Rechercher',
                    fillColor: Colors.grey[200],
                    filled: true,
                    contentPadding: EdgeInsets.all(0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 1,
                      ),
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      size: iconSize,
                    ),
                    suffixIcon: _controller.text.isNotEmpty
                        ? IconButton(
                            icon: Icon(
                              Icons.cancel,
                              size: iconSize,
                            ),
                            padding: EdgeInsets.all(0),
                            onPressed: () {
                              _controller.clear();
                              setState(() {});
                            },
                          )
                        : null, // Pas d'icône quand le champ est vide
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                child: Text(
                  "${widget.announcement!.nbPlacesTaken} Demande(s) Acceptée(s)",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              BlocConsumer<VolunteerCubit, VolunteerState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is VolunteerLoadingState) {
                    return Center(child: CircularProgressIndicator());
                  }

                  return FutureBuilder<List<Volunteer>>(
                    future: _processAnnouncements(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return SpinKitFadingCircle(
                          itemBuilder: (BuildContext context, int index) {
                            return DecoratedBox(
                              decoration: BoxDecoration(
                                color: index.isEven ? Colors.red : marron,
                              ),
                            );
                          },
                        );
                      }
                      if (snapshot.hasError) {
                        return Center(
                            child:
                                Text('Erreur lors du chargement des annonces'));
                      }
                      if (!snapshot.hasData) {
                        return Center(child: Text('Aucune annonce disponible'));
                      }
                      final volunteer = snapshot.data!;
                      return _buildAnnouncementsList(volunteer);
                    },
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAnnouncementsList(List<Volunteer> volunteer) {
    return Expanded(
      child: ListView.builder(
        itemCount: volunteer.length,
        itemBuilder: (context, index) {
          return _buildListTile(volunteer[index]);
        },
      ),
    );
  }

  Widget _buildListTile(Volunteer volunteer) {
    return Container(
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.red,
          width: 1.0,
        ),
        borderRadius:
            BorderRadius.circular(10.0), // Bordure arrondie (optionnel)
      ),
      child: ListTile(
        leading: CircleAvatar(
          radius: 20,
          backgroundImage: AssetImage('assets/logo.png'),
          backgroundColor: Colors.transparent,
        ),
        title: Text(volunteer.firstName),
        trailing: TextButton(
          style: TextButton.styleFrom(
            primary: Colors.white,
            backgroundColor: Colors.red,
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            textStyle: TextStyle(
              fontSize: 12,
            ),
          ),
          onPressed: () {
            var isParticipant = widget.announcement!.volunteers!
                .map((e) => e.id)
                .toList()
                .contains(volunteer.id);
            if (isParticipant) {
              BlocProvider.of<AnnouncementCubit>(context)
                  .unregisterAnnouncement(
                      widget.announcement!.id, volunteer.id!);
            }
          },
          child: Text(
            'Supprimer',
            style: TextStyle(
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}
