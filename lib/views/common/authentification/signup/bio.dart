import 'package:flutter/material.dart';

import '../login/widgets/customTextFormField_widget.dart';

class BioSignup extends StatefulWidget {
  final Function(String?) onBioChanged;
  String? bio = "";

  BioSignup({super.key, required this.onBioChanged, this.bio});

  @override
  State<BioSignup> createState() => _BioSignupState();
}

class _BioSignupState extends State<BioSignup> {
  late String _bio = "";
  late final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _descriptionController = TextEditingController();

  bool _isWordCountValid(String text) {
    int wordCount =
        text.split(RegExp(r'\s+')).where((word) => word.isNotEmpty).length;
    return wordCount <= 50;
  }

  @override
  void initState() {
    super.initState();
    _descriptionController.text = widget.bio!;
  }

  void _handleBioFocusChanges() async {
    setState(() {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        _bio = _descriptionController.text;
      } else {
        _bio = "";
      }
      widget.onBioChanged(_bio);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 20,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * .9,
          height: MediaQuery.of(context).size.height * .35,
          child: Card(
            margin: const EdgeInsets.all(5),
            shadowColor: Colors.grey,
            elevation: 10,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
                side: BorderSide(color: Color.fromRGBO(235, 126, 26, 1))),
            color: Colors.white.withOpacity(0.8),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 10, left: 20, right: 20, bottom: 10),
                  child: Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        CustomTextFormField(
                          controller: _descriptionController,
                          hintText:
                              "Entrez une description de vous jusqu'à 50 mots (facultatif)",
                          keyboardType: TextInputType.multiline,
                          maxLine:
                              MediaQuery.of(context).size.height * 0.44 ~/ 50,
                          obscureText: false,
                          prefixIcons: false,
                          onSaved: (value) {
                            _descriptionController.text = value.toString();
                            _bio = _descriptionController.text;
                          },
                          onChanged: (value) {
                            setState(() {
                              _handleBioFocusChanges();
                              _bio = _descriptionController.text;
                            });
                          },
                          validator: (value) {
                            if (value != null && !_isWordCountValid(value)) {
                              return "votre description ne doit pas dépasser 50 mots";
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox.fromSize(
                  size: const Size(0, 15),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
