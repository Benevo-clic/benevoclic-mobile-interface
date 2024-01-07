import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:namer_app/cubit/association/association_cubit.dart';
import 'package:namer_app/cubit/association/association_state.dart';
import 'package:namer_app/models/association_model.dart';
import 'package:namer_app/type/rules_type.dart';
import 'package:namer_app/util/color.dart';
import 'package:namer_app/util/phone_number_verification.dart';
import 'package:namer_app/widgets/abstract_container2.dart';
import 'package:namer_app/widgets/title_with_icon.dart';

class ModifProfilAsso extends StatelessWidget {
  final Association association;

  const ModifProfilAsso({super.key, required this.association});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.white, size: 45),
            backgroundColor: orange,
            actions: []),
        body: 
        BlocConsumer<AssociationCubit, AssociationState>(
          listener: (context, state) {},
          builder: (context, state) {
            print(state);
            if( state is AssociationConnexion){
              return listview(context, association);
            }else{
              return Text('');
            }
  }));}
  }


listview(BuildContext context, Association association) {
  String email = "";
  String bio = "";
  String phone = "";
  String address = "";

  final _formKey = GlobalKey<FormState>();
  return ListView(padding: EdgeInsets.all(25), children: [
    Form(
        key: _formKey,
        child: Column(
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
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: MyImagePicker(
                    rulesType: RulesType.USER_ASSOCIATION,
                    association: association,
                  ),
                ),
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
                      title: "Biographie",
                      icon: Icon(Icons.account_box_rounded)),
                  Divider(
                    height: 25,
                    color: Colors.white,
                  ),
                  TextFormField(
                    initialValue: association.bio,
                    onSaved: (value) {
                      bio = value.toString();
                    },
                    validator: (value) {
                      bio = value.toString();
                      return null;
                    },
                    decoration: InputDecoration(
                        hintStyle: TextStyle(color: Colors.grey),
                        hintText: "${association.bio}",
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
                    initialValue: association.address,
                    onSaved: (value) {
                      address = value.toString();
                    },
                    validator: (value) {
                      address = value.toString();
                      return null;
                    },
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.location_on_outlined),
                        hintStyle: TextStyle(color: Colors.grey),
                        hintText: association.address,
                        border: UnderlineInputBorder()),
                  ),
                  Divider(
                    height: 25,
                    color: Colors.white,
                  ),
                  TextFormField(
                    initialValue: association.email,
                    onSaved: (value) {
                      email = value.toString();
                    },
                    validator: (value) {
                      email = value.toString();
                      return null;
                    },
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.mail),
                        hintStyle: TextStyle(color: Colors.grey),
                        hintText: "${association.email}",
                        border: UnderlineInputBorder()),
                  ),
                  Divider(
                    height: 25,
                    color: Colors.white,
                  ),
                  TextFormField(
                    initialValue: association.phone,
                    onSaved: (value) {
                      phone = value.toString();
                    },
                    validator: (value) {
                      var phoneParam = PhoneVerification(value.toString());
                      if (phoneParam.security()) {
                        phone = value.toString();
                        return null;
                      } else {
                        return phoneParam.message;
                      }
                    },
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.phone_android),
                        hintStyle: TextStyle(color: Colors.grey),
                        hintText: association.phone,
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
            Association associationUpdate = Association(
                name: association.name,
                phone: phone,
                address: address,
                bio: bio,
                city: association.city,
                email: association.email,
                imageProfile: association.imageProfile,
                postalCode: association.postalCode,
                type: '');

            BlocProvider.of<AssociationCubit>(context)
                .updateAssociation(associationUpdate);
            BlocProvider.of<AssociationCubit>(context)
                .stateInfo(associationUpdate);

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
  final Association association;

  const MyImagePicker(
      {super.key, this.image, this.rulesType, required this.association});

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
          BlocProvider.of<AssociationCubit>(context).updateAssociation(
              Association(
                  type: '',
                  name: widget.association.name,
                  phone: widget.association.phone,
                  address: widget.association.address,
                  bio: widget.association.bio,
                  city: widget.association.city,
                  email: widget.association.email,
                  imageProfile: base64Encode(_image!),
                  postalCode: widget.association.postalCode,
                  announcement: widget.association.announcement,
                  verified: widget.association.verified,
                  volunteers: widget.association.volunteers,
                  volunteersWaiting: widget.association.volunteersWaiting));
          BlocProvider.of<AssociationCubit>(context).stateInfo(Association(
              type: '',
              name: widget.association.name,
              phone: widget.association.phone,
              address: widget.association.address,
              bio: widget.association.bio,
              city: widget.association.city,
              email: widget.association.email,
              imageProfile: base64Encode(_image!),
              postalCode: widget.association.postalCode,
              announcement: widget.association.announcement,
              verified: widget.association.verified,
              volunteers: widget.association.volunteers,
              volunteersWaiting: widget.association.volunteersWaiting));
        } else {}
      },
    );
    Navigator.of(context).pop();
  }
}
