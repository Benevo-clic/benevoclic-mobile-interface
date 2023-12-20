import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:namer_app/cubit/announcement/announcement_cubit.dart';
import 'package:namer_app/util/globals.dart' as globals;

import '../../../cubit/announcement/announcement_state.dart';
import '../../../widgets/app_bar_back_widget.dart';
import '../../common/authentification/login/widgets/customTextFormField_widget.dart';

class PublishAnnouncement extends StatefulWidget {
  PublishAnnouncement({super.key});

  @override
  State<StatefulWidget> createState() {
    return _PublishAnnouncement();
  }
}

class _PublishAnnouncement extends State<PublishAnnouncement> {
  List<String> announcementType = globals.announcementType;
  String? selectedItem = globals.announcementType[0];
  String? selectedOption;
  String? _dateEvent;
  String? _nbHours;
  String? _nbPlaces;
  String? _description;
  String? _title;
  String? _type;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  DateTime currentDate = DateTime.now();
  TextEditingController dateController = TextEditingController();

  // Déclaration des TextEditingController
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateEventController = TextEditingController();
  final TextEditingController _nbHoursController = TextEditingController();
  final TextEditingController _nbPlacesController = TextEditingController();
  final TextEditingController _typeController =
      TextEditingController(); // Si nécessaire

  @override
  void dispose() {
    // Dispose des contrôleurs
    _titleController.dispose();
    _descriptionController.dispose();
    _dateEventController.dispose();
    _nbHoursController.dispose();
    _nbPlacesController.dispose();
    _typeController.dispose();
    super.dispose();
  }

  bool _isWordCountValid(String text) {
    int wordCount =
        text.split(RegExp(r'\s+')).where((word) => word.isNotEmpty).length;
    return wordCount <= 50;
  }

  Future<String> _selectDate(BuildContext context) async {
    DateTime currentDate = DateTime.now();
    DateTime firstAllowedDate = currentDate;
    DateTime lastAllowedDate = currentDate.add(Duration(days: 30));

    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: firstAllowedDate,
      lastDate: lastAllowedDate,
    );

    if (selectedDate != null) {
      TimeOfDay initialTime = TimeOfDay.now();
      // Si la date sélectionnée est aujourd'hui, l'heure initiale est l'heure actuelle, sinon minuit.
      if (selectedDate.day != currentDate.day ||
          selectedDate.month != currentDate.month ||
          selectedDate.year != currentDate.year) {
        initialTime = TimeOfDay(hour: 0, minute: 0);
      }

      TimeOfDay? selectedTime = await showTimePicker(
        context: context,
        initialTime: initialTime,
      );

      if (selectedTime != null) {
        if (selectedDate.day == currentDate.day &&
            selectedDate.month == currentDate.month &&
            selectedDate.year == currentDate.year &&
            (selectedTime.hour < currentDate.hour ||
                (selectedTime.hour == currentDate.hour &&
                    selectedTime.minute < currentDate.minute))) {
          return "Heure non valide. Veuillez sélectionner une heure future.";
        }

        final DateTime finalDateTime = DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
          selectedTime.hour,
          selectedTime.minute,
        );

        dateController.text =
            DateFormat('dd/MM/yyyy HH:mm').format(finalDateTime);
        return dateController.text;
      } else {
        return "Heure non valide. Veuillez sélectionner une heure future.";
      }
    }
    return currentDate.toString();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AnnouncementCubit, AnnouncementState>(
      builder: (context, state) {
        return Stack(
          children: [
            Scaffold(
              resizeToAvoidBottomInset: false,
              body: Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AppBarBackWidget(contexts: context),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30, right: 30),
                          child: Text(
                            'Commençons par l\'essentiel',
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width * .05,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30, right: 30),
                          child: Text(
                            'Une bonne description c’est le meilleur moyen pour que vos futurs bénévoles voient votre annonce.',
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width * .03,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        _infoAnnouncement(context, state),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      color: Color.fromRGBO(235, 126, 26, 1),
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: ElevatedButton(
                        onPressed: () {
                          print(_titleController.text);
                          print(_typeController.text);
                          print(_dateEventController.text);
                          print(_nbHoursController.text);
                          print(_nbPlacesController.text);
                          print(_descriptionController.text);
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            // BlocProvider.of<AnnouncementCubit>(context)
                            //     .createAnnouncement(
                            //         _descriptionController.text);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.grey.shade400,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(05),
                          ),
                          fixedSize: Size(
                            MediaQuery.of(context).size.width * 0.1,
                            MediaQuery.of(context).size.height * 0.03,
                          ),
                        ),
                        child: Text('Publier',
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width * .05,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ) // GoogleFonts.roboto(
                            //   textStyle: TextStyle(  ),
                            ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _infoAnnouncement(BuildContext context, state) {
    return Stack(
      children: [
        SizedBox(
          height: 20,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 1.8,
          height: MediaQuery.of(context).size.height * 15,
          child: Card(
            margin: const EdgeInsets.all(20),
            shadowColor: Colors.grey,
            elevation: 10,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
                side: BorderSide(color: Color.fromRGBO(235, 126, 26, 1))),
            color: Colors.white.withOpacity(0.8),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomTextFormField(
                          controller: _titleController,
                          hintText: "Titre de l'annonce",
                          icon: Icons.abc,
                          keyboardType: TextInputType.name,
                          obscureText: false,
                          prefixIcons: true,
                          onSaved: (value) {},
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Le nom de votre association n'est pas valide";
                            } else if (RegExp(r'^[0-9]').hasMatch(value)) {
                              return "Le nom ne doit pas commencer par un chiffre";
                            } else if (value.length > 30) {
                              return "Le nom ne doit pas dépasser 50 caractères";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: MediaQuery.of(context).size.height * 0.12,
                          child: SingleChildScrollView(
                            child: DropdownButtonFormField<String>(
                              isExpanded: true,
                              decoration: InputDecoration(
                                fillColor: Colors.white.withOpacity(0.5),
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  borderSide: BorderSide.none,
                                ),
                                hintText: "Type de l'annonce",
                                hintStyle: TextStyle(color: Colors.black54),
                                errorStyle: TextStyle(
                                  color: Colors.red[300],
                                  overflow: TextOverflow.visible,
                                ),
                              ),
                              items: announcementType.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    overflow: TextOverflow.fade,
                                    softWrap: false,
                                    maxLines: 1,
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                if (newValue == 'Autre') {
                                  setState(() {
                                    selectedOption = newValue;
                                    _typeController.text = "";
                                  });
                                } else {
                                  setState(() {
                                    selectedOption = newValue;
                                    _typeController.text = newValue.toString();
                                  });
                                }
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Le type d'association n'est pas valide";
                                }
                                // Add other validations as needed
                                return null;
                              },
                            ),
                          ),
                        ),
                        if (selectedOption == 'Autre')
                          CustomTextFormField(
                            controller: _typeController,
                            hintText: "Autre type d'annonce",
                            icon: Icons.abc,
                            keyboardType: TextInputType.name,
                            obscureText: false,
                            prefixIcons: true,
                            onSaved: (value) {},
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Le nom de votre association n'est pas valide";
                              } else if (RegExp(r'^[0-9]').hasMatch(value)) {
                                return "Le nom ne doit pas commencer par un chiffre";
                              } else if (value.length > 30) {
                                return "Le nom ne doit pas dépasser 50 caractères";
                              }
                              return null;
                            },
                          ),
                        if (selectedOption == 'Autre')
                          SizedBox(
                            height: 10,
                          ),
                        CustomTextFormField(
                          controller: _dateEventController,
                          hintText: "Date et heure de l'événement",
                          icon: Icons.date_range,
                          obscureText: false,
                          prefixIcons: true,
                          maxLine: 1,
                          keyboardType: TextInputType.none,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "La date de l'événement n'est pas valide";
                            }
                            return null;
                          },
                          datepicker: () {
                            _selectDate(context).then((value) {
                              if (value == currentDate.toString()) {
                                return ScaffoldMessenger.of(context)
                                    .showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        "La date de l'événement ne peut pas être inférieure à la date actuelle"),
                                  ),
                                );
                              }
                              setState(() {
                                _dateEventController.text = value.toString();
                              });
                            });
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomTextFormField(
                          controller: _nbHoursController,
                          hintText: "Nombre d'heures",
                          icon: Icons.timer,
                          keyboardType: TextInputType.number,
                          obscureText: false,
                          prefixIcons: true,
                          onSaved: (value) {
                          },
                          validator: (value) {
                            var regex = RegExp(r"^(1|2[0-4])$");
                            if (value == null ||
                                !regex.hasMatch(value.toString())) {
                              return "Le nombre d'heures n'est pas valide";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomTextFormField(
                          controller: _nbPlacesController,
                          hintText: "Nombre de bénévoles",
                          icon: Icons.people_outline_outlined,
                          keyboardType: TextInputType.number,
                          obscureText: false,
                          prefixIcons: true,
                          onSaved: (value) {
                          },
                          validator: (value) {
                            if (value == null) {
                              return "Le nombre d'heures n'est pas valide";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomTextFormField(
                          controller: _descriptionController,
                          hintText:
                              "Description de l'annonce (50 mots maximum)",
                          keyboardType: TextInputType.multiline,
                          maxLine:
                              MediaQuery.of(context).size.height * 0.44 ~/ 50,
                          obscureText: false,
                          prefixIcons: false,
                          onSaved: (value) {
                          },
                          validator: (value) {
                            if (value != null && !_isWordCountValid(value)) {
                              return "votre description ne doit pas dépasser 50 mots";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 10,
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
