import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:namer_app/services/auth.dart';

class FormNomAsso extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Form(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [Center(child: FormulaireAsso())],
    ));
  }
}

class FormulaireAsso extends StatefulWidget {
  const FormulaireAsso({super.key});

  @override
  State<FormulaireAsso> createState() => _FormulaireAssoState();
}

class _FormulaireAssoState extends State<FormulaireAsso> {
  final myController = TextEditingController();

  var name;
  var address;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  var dio = Dio();

  //String token = AuthService().getToken();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .85,
      decoration: BoxDecoration(
          color: Color.fromRGBO(243, 243, 243, 1),
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: Colors.deepOrange, width: 2)),
      padding: EdgeInsets.all(25),
      child: Form(
        key: _formKey,
        child: Column(children: [
          TextFormField(
            validator: (value) {
              if (value!.isNotEmpty) {
                setState(() {
                  name = value;
                });
                return null;
              }
              return "il vous faut un nom";
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              prefixIcon: Icon(Icons.account_circle),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
              hintText: 'Nom de votre association',
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            validator: (value) {
              if (value!.isNotEmpty) {
                setState(() {
                  name = value;
                });
                return null;
              }
              return "ou se trouve votre association";
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              prefixIcon: Icon(Icons.home),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
              hintText: "Adresse de l'association",
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: MediaQuery.sizeOf(context).width * 0.60,
            padding: EdgeInsets.only(),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(150, 62, 96, 1),
              ),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  var params = {
                    "firstName": "benoit",
                    "lastName": "dupont",
                    "bio": "bonjour ...",
                    "email": "benoit@hotmail.com",
                    "phone": "0605040850",
                    "address": "gzgvre",
                    "city": "liverpool",
                    "postalCode": "59840",
                    "country": "france",
                    "birthDayDate": "0226",
                  };
                  var dataFromApi = await dio.post(
                      "localhost:8080/api/v1/volunteers/createVolunteer",
                      options: Options(headers: {
                        HttpHeaders.contentTypeHeader: "application/json",
                        //"Authorization": "Bearer $token"
                      }),
                      data: jsonEncode(params));
                  print(dataFromApi);
                }
              },
              child: const Text("Connexion",
                  style: TextStyle(color: Colors.white)),
            ),
          ),
        ]),
      ),
    );
  }
}
