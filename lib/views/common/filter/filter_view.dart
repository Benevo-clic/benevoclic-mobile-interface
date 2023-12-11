import 'package:flutter/material.dart';
import 'package:namer_app/util/color.dart';
import 'package:namer_app/views/common/filter/enum_tri.dart';
import 'package:namer_app/views/common/filter/widget/radio_section.dart';



class FilterView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FilterView();
  }
}

class _FilterView extends State<FilterView> {
  Tri groupTri = Tri.recent;

  changeFilter(filter) {
    setState(() {
      groupTri = filter;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(groupTri);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: orange,
        actions: [
          Expanded(child: Icon(Icons.close)),
          Expanded(child: Icon(Icons.cleaning_services_rounded))
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(30),
        children: [
          FilterItem(
            content: RadioSection(
                fct: (value) => changeFilter(value), tri: groupTri),
            title: "Filter",
            fct: () {},
          )
        ],
      ),
    );
  }
}

class FilterItem extends StatelessWidget {
  final String title;
  final Widget content;
  final fct;

  const FilterItem(
      {super.key,
      required this.title,
      required this.fct,
      required this.content});
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.sizeOf(context).width * 0.8,
        color: Colors.grey,
        child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Text(title),
                content,
              ],
            )));
  }
}

