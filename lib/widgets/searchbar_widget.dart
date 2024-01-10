import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  final TextEditingController myController ;
  final dynamic fct;

  SearchBarWidget({super.key, this.fct, required this.myController});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(
        onChanged: fct,
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
          prefixIcon: IconButton(
              onPressed: () {
                //print(myController.text);
              },
              icon: Icon(Icons.search)),
        ),
      ),
    );
  }
}
