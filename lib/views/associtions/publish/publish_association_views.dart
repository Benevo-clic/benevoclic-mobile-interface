import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:namer_app/cubit/announcement/announcement_cubit.dart';
import 'package:namer_app/models/location_model.dart';
import 'package:namer_app/util/globals.dart' as globals;
import 'package:namer_app/views/associtions/publish/widgets/location_form_autocomplete_widget.dart';

import '../../../cubit/announcement/announcement_state.dart';
import '../../../models/announcement_model.dart';
import '../../../widgets/app_bar_widget.dart';
import '../../../widgets/image_picker_announcement.dart';
import '../../common/authentification/login/widgets/customTextFormField_widget.dart';
import '../navigation_association.dart';

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
  LocationModel? location;
  FocusNode? focusNode;
  Uint8List? _imageCover;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FocusNode _addressFocusNode = FocusNode();
  final TextEditingController _addressController = TextEditingController();

  DateTime currentDate = DateTime.now();
  late String _dateEvent;

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
    _addressFocusNode.dispose();
    _addressController.dispose();
    _formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    location = LocationModel(
      address: "",
      latitude: 0,
      longitude: 0,
    );
    _addressFocusNode.addListener(_handleAddressFocusChange);
    BlocProvider.of<AnnouncementCubit>(context)
        .changeState(AnnouncementInitialState());
  }

  void _handleAddressFocusChange() async {
    if (_addressFocusNode.hasFocus) {
      LocationModel? selectedLocation = await ShowInputAutocomplete(context);
      if (selectedLocation != null) {
        _addressController.text = selectedLocation.address;
      }
    }
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

    @override
    void dispose() {
      super.dispose();
    }

    if (selectedDate != null) {
      TimeOfDay initialTime = TimeOfDay.now();
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

        _dateEventController.text =
            DateFormat('dd/MM/yyyy HH:mm').format(finalDateTime);
        return _dateEventController.text;
      } else {
        return "Heure non valide. Veuillez sélectionner une heure future.";
      }
    }
    return currentDate.toString();
  }

  void _onPublishButtonPressed(AnnouncementState state) {
    try {
      Announcement announcement = Announcement(
        description: _descriptionController.text,
        dateEvent: _dateEvent,
        nbHours: int.parse(_nbHoursController.text),
        nbPlaces: int.parse(_nbPlacesController.text),
        type: _typeController.text,
        datePublication:
            DateFormat('dd/MM/yyyy').format(DateTime.now()).split(' ')[0],
        location: LocationModel(
          address: _addressController.text,
          latitude: 0,
          longitude: 0,
        ),
        labelEvent: _titleController.text,
        idAssociation: "615f1e9b1a560d0016a6b0a5",
      );
      print(_imageCover);
      if (_imageCover != null) {
        announcement.image = base64Encode(_imageCover!);
      } else {
        announcement.image = "https://via.placeholder.com/150";
      }
      print(announcement.image);
      print(_formKey.currentState!.validate());
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        print(announcement.toJson());
        BlocProvider.of<AnnouncementCubit>(context)
            .createAnnouncement(announcement);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("L'annonce a été créée avec succès"),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => NavigationAssociation()),
        );
      }
    } catch (e) {
      print(e);
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                "Une erreur s'est produite lors de la création de l'annonce"),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return BlocConsumer<AnnouncementCubit, AnnouncementState>(
      listener: (context, state) {
        if (state is AnnouncementUploadedPictureState) {
          _imageCover = state.image;
        }

        if (state is AnnouncementErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  "Une erreur s'est produite lors de la création de l'annonce"),
            ),
          );
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            Scaffold(
              resizeToAvoidBottomInset: true,
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(
                    MediaQuery.of(context).size.height *
                        0.15), // Hauteur personnalisée
                child: AppBarWidget(
                    contexts: context, label: 'Publier une annonce'),
              ),
              body: Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 10),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: width * 0.05),
                          child: Text(
                            'Commençons par l\'essentiel',
                            style: TextStyle(
                              fontSize: width * 0.05,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: width * 0.05),
                          child: Text(
                            'Une bonne description c’est le meilleur moyen pour que vos futurs bénévoles voient votre annonce.',
                            style: TextStyle(
                              fontSize: width * 0.04,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        _infoAnnouncement(context, state),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    right: 20,
                    child: ElevatedButton(
                      onPressed: () => _onPublishButtonPressed(state),
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromRGBO(235, 126, 26, 1),
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(20),
                      ),
                      child: Icon(Icons.publish_rounded),
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
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Card(
        margin: const EdgeInsets.all(10),
        shadowColor: Colors.grey,
        elevation: 10,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
            side: BorderSide(color: Color.fromRGBO(235, 126, 26, 1))),
        color: Colors.white.withOpacity(0.8),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: width * .8,
                  height: height * .25,
                  child: Card(
                    margin: const EdgeInsets.all(5),
                    shadowColor: Colors.white,
                    elevation: 10,
                    color: Colors.white,
                    child: Padding(
                        padding: EdgeInsets.all(05),
                        child: ImagePickerAnnouncement()),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
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
                  width: width * 0.8,
                  height: height * 0.12,
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
                        return ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                "La date de l'événement ne peut pas être inférieure à la date actuelle"),
                          ),
                        );
                      }
                      setState(() {
                        _dateEvent = value.toString();
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
                  onSaved: (value) {},
                  validator: (value) {
                    var regex = RegExp(r"^(1[0-9]|2[0-4]|[1-9])$");
                    if (value == null || !regex.hasMatch(value.toString())) {
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
                  onSaved: (value) {},
                  validator: (value) {
                    RegExp regex = RegExp(r'^\d+$');
                    if (!regex.hasMatch(value.toString()) || value == null) {
                      return "Le nombre de bénévoles n'est pas valide";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                _buildAddressField(),
                SizedBox(
                  height: 10,
                ),
                CustomTextFormField(
                  controller: _descriptionController,
                  hintText: "Description de l'annonce (50 mots maximum)",
                  keyboardType: TextInputType.multiline,
                  maxLine: height * 0.44 ~/ 50,
                  obscureText: false,
                  prefixIcons: false,
                  onSaved: (value) {},
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
      ),
    );
  }

  Widget _buildAddressField() {
    double width = MediaQuery.of(context).size.width;

    return SizedBox(
      width: width * 0.8,
      child: TextFormField(
        controller: _addressController,
        keyboardType: TextInputType.streetAddress,
        decoration: InputDecoration(
          fillColor: Colors.white.withOpacity(0.5),
          filled: true,
          prefixIcon: Icon(
            Icons.location_on,
            color: Colors.black54,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide.none,
          ),
          hintText: "Adresse de l'événement",
          hintStyle: TextStyle(color: Colors.black54),
          errorStyle: TextStyle(
            color: Colors.red[300],
            overflow: TextOverflow.visible,
          ),
        ),
      ),
    );
  }
}
