import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:namer_app/widgets/fiche_annonce.dart';
import 'package:namer_app/util/globals.dart' as globals;

class ListeAnnonces extends StatelessWidget {
  
   //"eyJhbGciOiJSUzI1NiIsImtpZCI6ImE2YzYzNTNmMmEzZWMxMjg2NTA1MzBkMTVmNmM0Y2Y0NTcxYTQ1NTciLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vYmVuZXZvY2xpYy02MTJiZSIsImF1ZCI6ImJlbmV2b2NsaWMtNjEyYmUiLCJhdXRoX3RpbWUiOjE3MDA1ODE3MTksInVzZXJfaWQiOiJTNFlZQ29rOWw2ZHJjOFBJbjQyTGZzdnJ5YlYyIiwic3ViIjoiUzRZWUNvazlsNmRyYzhQSW40Mkxmc3ZyeWJWMiIsImlhdCI6MTcwMDU4MTcxOSwiZXhwIjoxNzAwNTg1MzE5LCJlbWFpbCI6ImFib3ViYWthcnNpcmlraTA2MEBnbWFpbC5jb20iLCJlbWFpbF92ZXJpZmllZCI6ZmFsc2UsImZpcmViYXNlIjp7ImlkZW50aXRpZXMiOnsiZW1haWwiOlsiYWJvdWJha2Fyc2lyaWtpMDYwQGdtYWlsLmNvbSJdfSwic2lnbl9pbl9wcm92aWRlciI6InBhc3N3b3JkIn19.Xyx1BNkXrDCH8V09qgKjyerBAPN2v9VNRqbiGnP46jdXNNtKmX_Z2ZJ1S-dk935hpBtOBjYFmMZak8Ud_AtUtCoLyJGcGsS2ZKVlHhCerB2BobkaMQSM0A9wEowvPmd1UdDqvyZ9_d870ULQTsbSKClbflxpJR07IsxpGZJP8uJxSzqPAjGz3e_x0_lTNgCIBT084oCEJPCj8GLY4Fs2MWrpf5YC2euUOkARV5Gr1GQHgdr_YfAjNfL1N9zWBK8UO-1IeSGMLwqmU7cgb8gHsP18-A0pr2-yeusRGNBfBWnfNZhhdiHrgN-r-xfwipMVdlynHhm8huDLSVAU50K_kQ";

  Future<void> response() async {
    String token = globals.id;
    String id =
        "eyJhbGciOiJSUzI1NiIsImtpZCI6IjBlNzJkYTFkZjUwMWNhNmY3NTZiZjEwM2ZkN2M3MjAyOTQ3NzI1MDYiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiI4NTMyNDMzMDg0NTItYmppanU2cmRkczFkdnY0cnNtMm9wNGJkaHNuNGszYjAuYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiI4NTMyNDMzMDg0NTItZHBmOWtwbTFnMmx2Mm9mZjZ2ZzluZXEwY2xncWgyb3EuYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMDEyMTc3NjAwMzU4NDE2NjA4ODEiLCJlbWFpbCI6Imdlb2ZmcmV5aGVybWFuMTkwMjk5OEBnbWFpbC5jb20iLCJlbWFpbF92ZXJpZmllZCI6dHJ1ZSwibmFtZSI6Imdlb2ZmcmV5IGhlcm1hbiIsInBpY3R1cmUiOiJodHRwczovL2xoMy5nb29nbGV1c2VyY29udGVudC5jb20vYS9BQ2c4b2NKa2pLT0RXUUx5SXVHNTBCTTVUQ0FKVVh4QnNUT2g2Y3R3LV9FNWQ2X3A9czk2LWMiLCJnaXZlbl9uYW1lIjoiZ2VvZmZyZXkiLCJmYW1pbHlfbmFtZSI6Imhlcm1hbiIsImxvY2FsZSI6ImZyIiwiaWF0IjoxNzAwODEzNDMxLCJleHAiOjE3MDA4MTcwMzF9.g1CXdDE4Umhtvt1nfNOiRiAUFOUXx1SYCNwfpc6aPLluvwnQ8Yf172FH1H_wTuTLNok3Dx3Mbn8lQMA2Y_lmoVIh0GDgC4hDa7wdkePNkgZGaJ0q2ID-pmdKs0rRR0M0n-x4dvRWkVW-oZ84EevGdnQOTN-KitFk9xvb6FPeEwQxBtnkjxEg3oVtlfU6UcdxA5EhSkb8ov_tSuEvQTmSfSCAy7qQca1ZchpdW0y";
    print(token);

    var params = {
      "rule": {
    "id": "string",
    "rulesType": "ADMIN"
  },
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

    var response2 = await dio.post(
        "http://192.168.1.17:8080/api/v1/volunteers/createVolnteer",
        options: Options(headers: {
          "Authorization": "Bearer $token",
          "Content-Type" : "application/json",
          "rules": "USER_VOLUNTEER",
        }),
        //data: jsonEncode(params)
        );

    // var response = dio.get(
    //     "http://192.168.173.241:8080/api/v1/ads/allAds",
    //     options: Options(headers: {
    //       "Authorization": "Bearer $token",
    //       "Content-Type" : "application/json",
    //     }),
    //     );

    Response r = await response2;
    print(r.data);
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
              },
              child: Text("api"))
        ],
      ),
    );
  }
}
