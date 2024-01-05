import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:namer_app/util/color.dart';
import 'package:namer_app/views/common/filter/date_selection.dart';
import 'package:namer_app/views/common/filter/enum_tri.dart';
import 'package:namer_app/views/common/filter/widget/check_box.dart';
import 'package:namer_app/views/common/filter/widget/filter_Item_widget.dart';
import 'package:namer_app/views/common/filter/widget/radio_section.dart';
import 'package:namer_app/views/common/filter/widget/slider_heures.dart';

import '../../../widgets/app_bar_filter.dart';

class FilterView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FilterView();
  }
}

class _FilterView extends State<FilterView> {
  TrierPar groupTri = TrierPar.recent;
  double hour = 1;
  TextEditingController controller = TextEditingController();
  DateTime date = DateTime.now();
  List<Checked> valuesList = [
    Checked("Avant 12:00", checked: false),
    Checked("12:00 - 18:00", checked: false),
    Checked("Après 18:00", checked: false),
  ];

  changeMissionTime(valuesListParam) {
    if (valuesListParam.name == "Avant 12:00") {
      valuesList
          .where((element) => element.name == "Avant 12:00")
          .first
          .checked = valuesListParam.checked;
    } else if (valuesListParam.name == "12:00 - 18:00") {
      valuesList
          .where((element) => element.name == "12:00 - 18:00")
          .first
          .checked = valuesListParam.checked;
    } else if (valuesListParam.name == "Après 18:00") {
      valuesList
          .where((element) => element.name == "Après 18:00")
          .first
          .checked = valuesListParam.checked;
    }
    setState(() {});
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.15),
        child: AppBarFilter(),
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
                  "12 missions trouvées",
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
  }
}
