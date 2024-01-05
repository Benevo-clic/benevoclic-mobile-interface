import 'package:flutter/material.dart';

import '../../../../util/color.dart';

class CheckBoxWidget extends StatelessWidget {
  final dynamic fct;

  CheckBoxWidget({super.key, required this.fct});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: valuesList.map((valuesList) {
        return ListTile(
          title: Text(valuesList.name),
          trailing: CustomCheckbox(
            isChecked: valuesList.checked,
            onChanged: (value) {
              valuesList.checked = value!;
              fct(valuesList);
            },
          ),
          onTap: () {
            bool newValue = !valuesList.checked;
            valuesList.checked = newValue;
            fct(valuesList);
          },
        );
      }).toList(),
    );
  }
}

List<Checked> valuesList = [
  Checked("Avant 12:00", checked: false),
  Checked("12:00 - 18:00", checked: false),
  Checked("Après 18:00", checked: false),
];

class Checked {
  bool checked;
  final String name;

  Checked(this.name, {required this.checked});
}

class CustomCheckbox extends StatelessWidget {
  final bool isChecked;
  final ValueChanged<bool?> onChanged;

  const CustomCheckbox({
    Key? key,
    required this.isChecked,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged(!isChecked),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: AA4D4F, // Color for the border
            width: 2.0, // Width of the border
          ),
          borderRadius: BorderRadius.circular(4.0), // Rounded corners
        ),
        height: 24.0, // Height of the checkbox
        width: 24.0, // Width of the checkbox
        child: isChecked
            ? Icon(
                Icons.check, // The check icon
                size: 20.0, // Size of the check icon
                color: AA4D4F, // Color for the check icon
              )
            : null, // If not checked, we show nothing
      ),
    );
  }
}
