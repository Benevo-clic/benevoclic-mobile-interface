import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:namer_app/cubit/announcement/announcement_state.dart';
import 'package:namer_app/models/filter_announcement_model.dart';
import 'package:namer_app/util/color.dart';
import 'package:namer_app/views/common/filter/date_selection.dart';
import 'package:namer_app/views/common/filter/enum_tri.dart';
import 'package:namer_app/views/common/filter/widget/check_box.dart';
import 'package:namer_app/views/common/filter/widget/filter_Item_widget.dart';
import 'package:namer_app/views/common/filter/widget/radio_section.dart';
import 'package:namer_app/views/common/filter/widget/slider_heures.dart';

import '../../../cubit/announcement/announcement_cubit.dart';
import '../../../models/announcement_model.dart';
import '../../../widgets/app_bar_filter.dart';

class FilterView extends StatefulWidget {
  Function(List<Announcement>?) onAnnouncementsChanged;
  String? idAssociation;

  //
  FilterView(
      {super.key, required this.onAnnouncementsChanged, this.idAssociation});

  @override
  State<StatefulWidget> createState() {
    return _FilterView();
  }
}

class _FilterView extends State<FilterView> {
  TrierPar groupTri = TrierPar.recent;
  double hour = 0;
  TextEditingController controller = TextEditingController();
  DateTime date = DateTime.now();
  late List<Checked> valuesList;

  late List<String> values;
  FilterAnnouncement filter = FilterAnnouncement();
  List<Announcement> announcements = [];
  Timer _debounce = Timer(Duration(milliseconds: 1), () {});

  @override
  void initState() {
    super.initState();
    valuesList = [
      Checked("Avant 12:00", checked: false),
      Checked("12:00 - 18:00", checked: false),
      Checked("Après 18:00", checked: false),
    ];
    values = [];
  }

  void getFilter() {
    filter.sortBy =
        groupTri == TrierPar.recent ? "lePlusRecent" : "lePlusAncien";
    filter.hours = hour.toInt();
    filter.startDate = selectedStartDate != null
        ? DateFormat('dd/MM/yyyy').format(selectedStartDate!)
        : null;
    filter.endDate = selectedEndDate != null
        ? DateFormat('dd/MM/yyyy').format(selectedEndDate!)
        : null;
    filter.timeOfDay = values;

    setState(() {
      filter = filter;
    });
  }

  changeMissionTime(valuesListParam) {
    if (valuesListParam.name == "Avant 12:00") {
      valuesList
          .where((element) => element.name == "Avant 12:00")
          .first
          .checked = valuesListParam.checked;
      valuesListParam.checked
          ? values.add("Avant 12:00")
          : values.remove("Avant 12:00");
    } else if (valuesListParam.name == "12:00 - 18:00") {
      valuesList
          .where((element) => element.name == "12:00 - 18:00")
          .first
          .checked = valuesListParam.checked;
      valuesListParam.checked
          ? values.add("12:00 - 18:00")
          : values.remove("12:00 - 18:00");
    } else if (valuesListParam.name == "Après 18:00") {
      valuesList
          .where((element) => element.name == "Après 18:00")
          .first
          .checked = valuesListParam.checked;
      valuesListParam.checked
          ? values.add("Après 18:00")
          : values.remove("Après 18:00");
    }
    setState(() {
      valuesList = valuesList;
      values = values;
    });
  }

  changeHour(hourParam) {
    setState(() {
      hour = hourParam;
    });
  }

  changeFilter(filter) {
    setState(() {
      groupTri = filter;
    });
  }

  TextEditingController dateController = TextEditingController();
  DateTime? selectedStartDate;
  DateTime? selectedEndDate;

  void onDateSelected(DateTime? start, DateTime? end) {
    selectedStartDate = start;
    selectedEndDate = end;
    if (start != null && end != null) {
      final String formattedStart = DateFormat('dd/MM/yyyy').format(start);
      final String formattedEnd = DateFormat('dd/MM/yyyy').format(end);
      setState(() {
        dateController.text = '$formattedStart - $formattedEnd';
      });
    }
  }

  void resetFilters() {
    setState(() {
      groupTri = TrierPar.recent;
      hour = 0;
      controller.clear();
      selectedStartDate = null;
      selectedEndDate = null;
      valuesList =
          valuesList.map((e) => Checked(e.name, checked: false)).toList();
      values.clear();
      filter = FilterAnnouncement(); // Réinitialiser le filtre
    });
  }

  Future<void> _searchAnnouncement(List<Announcement> announcement) async {
    try {
      if (_debounce.isActive) _debounce.cancel();
      _debounce = Timer(Duration(milliseconds: 500), () async {
        widget.onAnnouncementsChanged(announcement);
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    getFilter();
    if (widget.idAssociation != null && widget.idAssociation != '') {
      BlocProvider.of<AnnouncementCubit>(context)
          .findAnnouncementByAssociationAndType(filter);
    } else {
      BlocProvider.of<AnnouncementCubit>(context)
          .findAnnouncementAfterFilter(filter);
    }

    return BlocConsumer<AnnouncementCubit, AnnouncementState>(
        listener: (context, state) {
      if (state is AnnouncementLoadedStateAfterFilter) {
          _searchAnnouncement(state.announcements);
          if (widget.idAssociation == null || widget.idAssociation == '') {
            announcements = state.announcements.where((element) {
              return element.isVisible == true;
            }).toList();
          } else {
            announcements = state.announcements;
          }
      }
    }, builder: (context, state) {
      return Scaffold(
        appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.height * 0.15),
          child: AppBarFilter(
            idAssociation: widget.idAssociation,
            onReset: resetFilters,
          ),
        ),
        body: ListView(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
          children: [
            FilterItem(
              content: RadioSection(
                  fct: (value) => changeFilter(value), tri: groupTri),
              title: "Filter",
            ),
            SizedBox(
              height: 5,
            ),
            FilterItem(
              title: "Durée de la mission",
              content: SliderHoursState(
                fct: (value) => changeHour(value),
                currentValue: hour,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            FilterItem(
                title: "",
                content: DateSelection(
                  controller: controller,
                  fct: (start, end) => onDateSelected(start, end),
                )),
            SizedBox(
              height: 5,
            ),
            FilterItem(
              title: "Heure de la mission",
              content: CheckBoxWidget(
                fct: changeMissionTime,
                valuesList: valuesList,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.07,
            ),
          ],
        ),
        floatingActionButton: Padding(
          padding: EdgeInsets.all(0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width *
                1, // Set the width to 90% of the screen width
            child: FloatingActionButton.extended(
              onPressed: () {},
              label: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "${announcements.length} missions trouvées",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: AA4D4F,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      getFilter();
                      Navigator.pop(context);
                    },
                    child: Text(
                      "voir les missions",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  )
                ],
              ),
              backgroundColor: orange,
              // Set your preferred background color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                    0), // Set the border radius for the button
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation
            .centerFloat, // This positions the FAB at the bottom center
      );
    });
  }
}
