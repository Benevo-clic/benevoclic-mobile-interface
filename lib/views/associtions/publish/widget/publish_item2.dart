import 'package:flutter/material.dart';
import 'package:namer_app/util/get_format_date.dart';
import 'package:namer_app/widgets/abstract_container.dart';

class PublishItem2 extends StatefulWidget {
  final String content;

  const PublishItem2({super.key, required this.content});

  @override
  State<StatefulWidget> createState() {
    return _PublishItem2();
  }
}

class _PublishItem2 extends State<PublishItem2> {
  DateTime? date;
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AbstractContainer3(content: Center(child: Text(widget.content))),
        AbstractContainer4(
            content: TextField(
          textAlign: TextAlign.center,
          controller: controller,
          readOnly: true,
          onTap: () async {
            DateTime? pickDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(Duration(days: 90)));
            controller.text = formatDate(pickDate);
            setState(() {
              date = pickDate;
            });
          },
        ))
      ],
    );
  }
}
