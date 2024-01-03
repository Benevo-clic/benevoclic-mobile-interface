import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  final myController = TextEditingController();
  final dynamic fct;

  SearchBarWidget({super.key, this.fct});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextField(
        controller: myController,
        cursorColor: Color.fromRGBO(30, 29, 29, 1.0),
        decoration: InputDecoration(
          hintText: 'Rechercher',
          fillColor: Colors.grey[200],
          filled: true,
          contentPadding: EdgeInsets.all(0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Colors.white,
              width: 1,
            ),
          ),
          prefixIcon: Icon(
            Icons.search,
            size: 15,
          ),
        ),
      ),
    );
  }
}
