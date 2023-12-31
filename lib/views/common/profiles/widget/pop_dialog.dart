import 'package:flutter/material.dart';

class PopDialog extends StatelessWidget {
  final dynamic content;

  const PopDialog({super.key, this.content});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: SizedBox(
            width: MediaQuery.sizeOf(context).width * 0.95,
            child: Container(
              width: MediaQuery.sizeOf(context).width * 0.95,
              child: SimpleDialog(
                  title: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 35, 0, 35),
                      child: content)),
            )),
      ),
    );
  }
}
