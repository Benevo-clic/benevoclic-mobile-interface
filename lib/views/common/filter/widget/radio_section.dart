import 'package:flutter/material.dart';
import 'package:namer_app/util/color.dart';
import 'package:namer_app/views/common/filter/enum_tri.dart';

class RadioSection extends StatelessWidget {
  final TrierPar tri;
  final Function(TrierPar) fct;

  RadioSection({super.key, required this.tri, required this.fct});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Trier par',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ),
        RadioButton(
          fct: fct,
          tri: tri,
          name: "A proximité",
          triValue: TrierPar.proximite,
        ),
        RadioButton(
          fct: fct,
          tri: tri,
          name: "Le plus récent",
          triValue: TrierPar.recent,
        ),
        RadioButton(
          fct: fct,
          tri: tri,
          name: "Le plus ancien",
          triValue: TrierPar.ancient,
        ),
      ],
    );
  }
}

class RadioButton extends StatelessWidget {
  final TrierPar tri;
  final Function(TrierPar) fct;
  final String name;
  final TrierPar triValue;

  RadioButton({
    super.key,
    required this.tri,
    required this.fct,
    required this.name,
    required this.triValue,
  });

  @override
  Widget build(BuildContext context) {
    return RadioListTile<TrierPar>(
      title: Text(name),
      value: triValue,
      groupValue: tri,
      onChanged: (TrierPar? value) {
        if (value != null) {
          fct(value);
        }
      },
      controlAffinity: ListTileControlAffinity.trailing,
      activeColor: AA4D4F,
    );
  }
}
