import 'package:flutter/material.dart';
import 'package:namer_app/util/get_format_date.dart';

class DateSelection extends StatelessWidget {
  final dynamic controller;
  final dynamic fct;

  const DateSelection({super.key, required this.controller, required this.fct});

  @override
  Widget build(BuildContext context) {
    return TextField(
        textAlign: TextAlign.center,
        controller: controller,
        readOnly: true,
        onTap: () async {
          DateTime? pickDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(Duration(days: 90)));
          controller.text = formatDate(pickDate!);
          fct(pickDate);
        });
  }
}
