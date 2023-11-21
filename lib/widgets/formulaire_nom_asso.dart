import 'package:flutter/material.dart';

class FormNomAsso extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Form(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        FormulaireAsso()
      ],
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

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color.fromRGBO(249, 148, 85, 1),
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: Colors.brown, width: 2)),
      padding: EdgeInsets.all(25),
      width: MediaQuery.of(context).size.width * .85,
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
              fillColor: Colors.grey.shade400,
              prefixIcon: Icon(Icons.account_circle),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
              hintText: 'Email',
            ),
          ),
          SizedBox(
            height: 10,
          ),
          
          SizedBox(
            height: 5,
          ),
          TextButton(
            onPressed: () {},
            child: Text(
              "Mot de passe oublié ?",
              style: TextStyle(
                  decoration: TextDecoration.underline, color: Colors.black),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            width: MediaQuery.sizeOf(context).width * 0.60,
            padding: EdgeInsets.only(),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(150, 62, 96, 1),
              ),
              onPressed: () async {
                
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
