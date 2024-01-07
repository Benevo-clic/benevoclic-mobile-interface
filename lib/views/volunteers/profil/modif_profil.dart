import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:namer_app/cubit/association/association_cubit.dart';
import 'package:namer_app/cubit/volunteer/volunteer_cubit.dart';
import 'package:namer_app/cubit/volunteer/volunteer_state.dart';
import 'package:namer_app/models/association_model.dart';
import 'package:namer_app/models/volunteer_model.dart';
import 'package:namer_app/type/rules_type.dart';
import 'package:namer_app/util/color.dart';
import 'package:namer_app/util/phone_number_verification.dart';
import 'package:namer_app/widgets/abstract_container2.dart';
import 'package:namer_app/widgets/title_with_icon.dart';

class ModifProfil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.white, size: 45),
            backgroundColor: orange,
            actions: []),
        body: BlocConsumer<VolunteerCubit, VolunteerState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is VolunteerInfo) {
              Volunteer volunteer = state.volunteer;
              return listview(context, volunteer);
            } else {
              return listview(
                  context,
                  Volunteer(
                      firstName: "firstName",
                      lastName: "lastName",
                      phone: "phone",
                      birthDayDate: "birthDayDate"));
            }
          },
        ));
  }
}

listview(BuildContext context, Volunteer volunteer) {
  String _email = "";
  String _bio = "";
  String _phone = "";
  String _address = "";

  final _formKey = GlobalKey<FormState>();
  return ListView(padding: EdgeInsets.all(25), children: [
    Form(
        key: _formKey,
        child: Column(
          children: [
            Stack(
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
                        side:
                            BorderSide(color: Color.fromRGBO(235, 126, 26, 1))),
                    color: Colors.white.withOpacity(0.8),
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: MyImagePicker(
                          rulesType: RulesType.USER_VOLUNTEER,
                          volunteer: volunteer),
                    ),
                  ),
                )
              ],
            ),
            Divider(
              height: 25,
              color: Colors.white,
            ),
            AbstractContainer2(
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TitleWithIcon(
                      title: "Biographie",
                      icon: Icon(Icons.account_box_rounded)),
                  Divider(
                    height: 25,
                    color: Colors.white,
                  ),
                  TextFormField(
                    initialValue: volunteer.bio,
                    onSaved: (value) {
                      _bio = value.toString();
                    },
                    validator: (value) {
                      _bio = value.toString();
                      return null;
                    },
                    decoration: InputDecoration(
                        hintStyle: TextStyle(color: Colors.grey),
                        hintText: "${volunteer.bio}",
                        border: UnderlineInputBorder()),
                  ),
                ],
              ),
            ),
            Divider(
              height: 25,
              color: Colors.white,
            ),
            AbstractContainer2(
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TitleWithIcon(
                      title: "Informations", icon: Icon(Icons.location_city)),
                  Divider(
                    height: 25,
                    color: Colors.white,
                  ),
                  TextFormField(
                    initialValue: volunteer.address,
                    onSaved: (value) {
                      _address = value.toString();
                    },
                    validator: (value) {
                      _address = value.toString();
                      return null;
                    },
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.location_on_outlined),
                        hintStyle: TextStyle(color: Colors.grey),
                        hintText: volunteer.address,
                        border: UnderlineInputBorder()),
                  ),
                  Divider(
                    height: 25,
                    color: Colors.white,
                  ),
                  TextFormField(
                    initialValue: volunteer.email,
                    onSaved: (value) {
                      _email = value.toString();
                    },
                    validator: (value) {
                      _email = value.toString();
                      return null;
                    },
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.mail),
                        hintStyle: TextStyle(color: Colors.grey),
                        hintText: "${volunteer.email}",
                        border: UnderlineInputBorder()),
                  ),
                  Divider(
                    height: 25,
                    color: Colors.white,
                  ),
                  TextFormField(
                    initialValue: volunteer.phone,
                    onSaved: (value) {
                      _phone = value.toString();
                    },
                    validator: (value) {
                      var phoneParam = PhoneVerification(value.toString());
                      if (phoneParam.security()) {
                        _phone = value.toString();
                        return null;
                      } else {
                        return phoneParam.message;
                      }
                    },
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.phone_android),
                        hintStyle: TextStyle(color: Colors.grey),
                        hintText: volunteer.phone,
                        border: UnderlineInputBorder()),
                  ),
                ],
              ),
            ),
            Divider(
              height: 25,
              color: Colors.white,
            ),
          ],
        )),
    Divider(
      height: 25,
      color: Colors.white,
    ),
    ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            print(_email);
            print(_bio);
            print(_phone);
            print(_address);
            Volunteer volunteerUpdate = Volunteer(
                firstName: volunteer.firstName,
                lastName: volunteer.lastName,
                phone: _phone,
                birthDayDate: volunteer.birthDayDate,
                address: _address,
                bio: _bio,
                city: volunteer.city,
                email: volunteer.email,
                imageProfile: volunteer.imageProfile,
                postalCode: volunteer.postalCode);
            BlocProvider.of<VolunteerCubit>(context)
                .volunteerState(volunteerUpdate);
            BlocProvider.of<VolunteerCubit>(context)
                .updateVolunteer(volunteerUpdate);

            Navigator.pop(context);
          } else {
            print("erreur");
          }
        },
        child: Text("Modifier"))
  ]);
}

class MyImagePicker extends StatefulWidget {
  final Uint8List? image;
  final RulesType? rulesType;
  final Volunteer volunteer;

  const MyImagePicker(
      {super.key, this.image, this.rulesType, required this.volunteer});

  @override
  State<MyImagePicker> createState() => _MyImagePickerState();
}

class _MyImagePickerState extends State<MyImagePicker> {
  Uint8List? _image;
  File? selectedIMage;
  final _imagePicker = ImagePicker();
  final _imageCropper = ImageCropper();

  Future<CroppedFile?> _cropImage(
          {required XFile file,
          CropStyle cropStyle = CropStyle.circle}) async =>
      await _imageCropper.cropImage(
        cropStyle: cropStyle,
        sourcePath: file.path,
        compressQuality: 100,
      );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Center(
        child: Stack(
          children: [
            _image != null
                ? CircleAvatar(
                    radius: 100, backgroundImage: MemoryImage(_image!))
                : const CircleAvatar(
                    radius: 100,
                    backgroundImage: NetworkImage(
                        "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png"),
                  ),
            Positioned(
              bottom: -0,
              left: 140,
              child: IconButton(
                onPressed: () {
                  showImagePickerOption(context);
                },
                icon: SvgPicture.asset(
                  'assets/icons/Ellipse 116.svg',
                  height: 20,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void showImagePickerOption(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      builder: (builder) {
        return Padding(
          padding: const EdgeInsets.all(18.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 4.5,
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      _pickImage(context, ImageSource.gallery);
                    },
                    child: const SizedBox(
                      child: Column(
                        children: [
                          Icon(
                            Icons.image,
                            size: 70,
                          ),
                          Text("Galerie")
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      _pickImage(context, ImageSource.camera);
                    },
                    child: const SizedBox(
                      child: Column(
                        children: [
                          Icon(
                            Icons.camera_alt,
                            size: 70,
                          ),
                          Text("Camera")
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      _image = null;

                      Navigator.of(context).pop();
                    },
                    child: const SizedBox(
                      child: Column(
                        children: [
                          Icon(
                            Icons.delete,
                            size: 70,
                          ),
                          Text("Supprimer")
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future _pickImage(BuildContext context, ImageSource source) async {
    final returnImage =
        await _imagePicker.pickImage(source: source, imageQuality: 100);
    if (returnImage == null) return;
    final croppedFile = await _cropImage(file: returnImage);
    if (croppedFile == null) return;

    setState(
      () {
        selectedIMage = File(croppedFile.path);
        _image = File(croppedFile.path).readAsBytesSync(); // <-- here
        if (widget.rulesType == RulesType.USER_ASSOCIATION) {
        } else {
          BlocProvider.of<VolunteerCubit>(context).updateVolunteer(Volunteer(
              firstName: widget.volunteer.firstName,
              lastName: widget.volunteer.lastName,
              phone: widget.volunteer.phone,
              birthDayDate: widget.volunteer.birthDayDate,
              address: widget.volunteer.address,
              bio: widget.volunteer.bio,
              city: widget.volunteer.city,
              email: widget.volunteer.email,
              imageProfile: base64Encode(_image!),
              myAssociations: widget.volunteer.myAssociations,
              myAssociationsWaiting: widget.volunteer.myAssociationsWaiting,
              postalCode: widget.volunteer.postalCode));
          BlocProvider.of<VolunteerCubit>(context).volunteerState(Volunteer(
              firstName: widget.volunteer.firstName,
              lastName: widget.volunteer.lastName,
              phone: widget.volunteer.phone,
              birthDayDate: widget.volunteer.birthDayDate,
              address: widget.volunteer.address,
              bio: widget.volunteer.bio,
              city: widget.volunteer.city,
              email: widget.volunteer.email,
              imageProfile: base64Encode(_image!),
              myAssociations: widget.volunteer.myAssociations,
              myAssociationsWaiting: widget.volunteer.myAssociationsWaiting,
              postalCode: widget.volunteer.postalCode));
        }
      },
    );
    Navigator.of(context).pop();
  }
}
