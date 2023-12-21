import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:namer_app/cubit/association/association_cubit.dart';
import 'package:namer_app/type/rules_type.dart';

import '../cubit/association/association_state.dart';
import '../cubit/volunteer/volunteer_cubit.dart';
import '../cubit/volunteer/volunteer_state.dart';

class MyImagePicker extends StatefulWidget {
  final Uint8List? image;
  final RulesType? rulesType;

  const MyImagePicker({super.key, this.image, this.rulesType});

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
          BlocProvider.of<AssociationCubit>(context)
              .changeState(AssociationPictureState(imageProfile: _image));
        } else {
          BlocProvider.of<VolunteerCubit>(context)
              .changeState(VolunteerPictureState(imageProfile: _image));
        }
      },
    );
    Navigator.of(context).pop();
  }
}
