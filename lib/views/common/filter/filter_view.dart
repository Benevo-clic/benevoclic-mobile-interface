import 'package:flutter/material.dart';
import 'package:namer_app/util/color.dart';
import 'package:namer_app/views/common/filter/enum_tri.dart';
import 'package:namer_app/views/common/filter/widget/check_box.dart';
import 'package:namer_app/views/common/filter/widget/date_selection.dart';
import 'package:namer_app/views/common/filter/widget/radio_section.dart';
import 'package:namer_app/views/common/filter/widget/slider_heures.dart';

class FilterView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FilterView();
  }
}

class _FilterView extends State<FilterView> {
  Tri groupTri = Tri.recent;
  double hour = 1;
  TextEditingController controller = TextEditingController();
  DateTime date = DateTime.now();
  List<Checked> valuesList = [
    Checked("Avant 12:00", checked: false),
    Checked("12:00 - 18:00", checked: false),
    Checked("Après 18:00", checked: false),
  ];

  changeMissionTime(valuesListParam) {
    setState(() {
      //valuesList = valuesListParam;
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

  changeDate(dateParam) {
    setState(() {
      date = dateParam;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(valuesList[0].name);
    print(valuesList[0].checked);
    print(valuesList[1].name);
    print(valuesList[1].checked);
    print(valuesList[2].name);
    print(valuesList[2].checked);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: orange,
        actions: [
          Expanded(child: Icon(Icons.close)),
          Expanded(child: Icon(Icons.cleaning_services_rounded))
        ],
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
              title: "Date de la mission",
              content: DateSelection(
                controller: controller,
                fct: changeDate,
              )),
          SizedBox(
            height: 5,
          ),
          FilterItem(
              title: "Heure de la mission",
              content: CheckBoxWidget(
                fct: changeMissionTime,
                valuesList: valuesList,
              ))
        ],
      ),
    );
  }
}

class FilterItem extends StatelessWidget {
  final String title;
  final Widget content;

  const FilterItem({super.key, required this.title, required this.content});
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(2),
          color: Color.fromRGBO(200, 200, 200, 0.4),
        ),
        width: MediaQuery.sizeOf(context).width * 0.8,
        child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  textAlign: TextAlign.start,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                content,
              ],
            )));
  }
}
