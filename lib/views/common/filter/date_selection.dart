import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateSelection extends StatefulWidget {
  final TextEditingController controller;
  final Function(DateTime? start, DateTime? end) fct;

  const DateSelection({super.key, required this.controller, required this.fct});

  @override
  State<DateSelection> createState() => _DateSelectionState();
}

class _DateSelectionState extends State<DateSelection> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final DateTimeRange? picked = await showDateRangePicker(
          context: context,
          firstDate: DateTime.now(),
          lastDate: DateTime(2101),
          initialDateRange: DateTimeRange(
            start: DateTime.now(),
            end: DateTime.now().add(const Duration(days: 1)),
          ),
          locale: const Locale('fr', 'FR'),
        );

        if (picked != null && picked.start != picked.end) {
          final String formattedStart =
              DateFormat('dd/MM/yyyy').format(picked.start);
          final String formattedEnd =
              DateFormat('dd/MM/yyyy').format(picked.end);
          setState(() {
            widget.fct(picked.start, picked.end);
            widget.controller.text = '$formattedStart - $formattedEnd';
          });
        }
      },
      child: IgnorePointer(
        child: TextFormField(
          controller: widget.controller,
          readOnly: true,
          decoration: InputDecoration(
            suffixIcon: Icon(Icons.calendar_today),
            labelText: 'Date de la mission',
            border: OutlineInputBorder(),
          ),
        ),
      ),
    );
  }
}
