import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:namer_app/services/auth.dart';
import 'package:namer_app/widgets/fiche_annonce.dart';
import 'package:namer_app/util/globals.dart' as globals;

class ListeAnnonces extends StatelessWidget {
  var token =
      "eyJhbGciOiJSUzI1NiIsImtpZCI6ImE2YzYzNTNmMmEzZWMxMjg2NTA1MzBkMTVmNmM0Y2Y0NTcxYTQ1NTciLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vYmVuZXZvY2xpYy02MTJiZSIsImF1ZCI6ImJlbmV2b2NsaWMtNjEyYmUiLCJhdXRoX3RpbWUiOjE3MDA1NzI4MjYsInVzZXJfaWQiOiJEMHplcVpiVnlVUGc1WW5GR3c2cjBGcWwzYzQyIiwic3ViIjoiRDB6ZXFaYlZ5VVBnNVluRkd3NnIwRnFsM2M0MiIsImlhdCI6MTcwMDU3Mjg0NSwiZXhwIjoxNzAwNTc2NDQ1LCJlbWFpbCI6Imdlb2ZmcmV5aGVybWFuX3BlcnNvQGhvdG1haWwuY29tIiwiZW1haWxfdmVyaWZpZWQiOnRydWUsImZpcmViYXNlIjp7ImlkZW50aXRpZXMiOnsiZW1haWwiOlsiZ2VvZmZyZXloZXJtYW5fcGVyc29AaG90bWFpbC5jb20iXX0sInNpZ25faW5fcHJvdmlkZXIiOiJwYXNzd29yZCJ9fQ.jS1hfceIRUCa9J_dbxSBE-2GdhDXaILqC6bka6gU5tHuxKn4UKtnjhwYzi19GlreOwx52E7_FDb5a7cjGERHC_zIqbRO3Y2nhHgsSX-a0hytZqihgF-DKLNPXe1fgVjVdPVaaI_o4o12tsz-o7Cd9fpK-nCTKceseOVjAdjW3uKqRQbbHxQQqwh0yc-gZoY5yD6nbWBonb6LMPjwGPa41I_jkYHUXb_5MMnAEJehb_MRahU-8tf2nSPDCUDgbNuB_DWjc4JN_o0ZiRY5ccHDGDmRi48rTZO5LygujPnMbgfG8fx7VB-envmsk2mOfvhXtL1AnqV9NwyparalbfoOKA";

  Future<Response> response() async {
    String id = globals.id;
    print(id);

    var params = {
      "rule": {"id": "string", "rulesType": "ADMIN"},
      "firstName": "string",
      "lastName": "string",
      "bio": "string",
      "email": "string",
      "phone": "string",
      "address": "string",
      "city": "string",
      "postalCode": "string",
      "country": "string",
      "birthDayDate": "string",
      "verified": true,
      "username": "string",
      "password": "string",
      "authorities": [
        {"authority": "string"}
      ],
      "accountNonExpired": true,
      "accountNonLocked": true,
      "credentialsNonExpired": true,
      "enabled": true
    };

    var dio = Dio();

    var response = await dio.post(
        "http://192.168.1.17:8080/api/v1/volunteers/createVolunteer",
        options: Options(headers: {
          "Authorization": "Bearer $id",
          "Accept": "*/*",
          "Content-Type": "application/json",
        }),
        data: jsonEncode(params));

    //print(response);

    return response;
  }

  @override
  Widget build(Object context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/background2.png"), fit: BoxFit.cover)),
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Annonce(),
          Text("oui"),
          Text("oui"),
          Text("oui"),
          Text("oui"),
          Text("oui"),
          TextButton(
              onPressed: () {
                response();

                /*Response res = api() as Response;
                print(res);*/
              },
              child: Text("api"))
        ],
      ),
    );
  }
}
