import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:namer_app/cubit/announcement/announcement_cubit.dart';

import '../cubit/announcement/announcement_state.dart';

class ImagePickerAnnouncement extends StatefulWidget {
  final Uint8List? image;

  const ImagePickerAnnouncement({super.key, this.image});

  @override
  State<ImagePickerAnnouncement> createState() =>
      _ImagePickerAnnouncementState();
}

class _ImagePickerAnnouncementState extends State<ImagePickerAnnouncement> {
  Uint8List? _image;
  File? selectedIMage;
  final _imagePicker = ImagePicker();
  final _imageCropper = ImageCropper();

  Future<CroppedFile?> _cropImage(
          {required XFile file,
          CropStyle cropStyle = CropStyle.rectangle}) async =>
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
                ? Container(
                    width: MediaQuery.of(context).size.width * .8,
                    height: MediaQuery.of(context).size.height * .3,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: MemoryImage(_image!),
                        fit: BoxFit
                            .cover, // Adapte l'image à la taille du conteneur
                      ),
                    ),
                  )
                : Container(
                    width: MediaQuery.of(context).size.width * .8,
                    height: MediaQuery.of(context).size.height * .3,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage("https://via.placeholder.com/150"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
            Positioned(
                bottom: 190, // Ajustez la position selon vos besoins
                right: -0, // Ajustez la position selon vos besoins
                child: IconButton(
                  onPressed: () {
                    showImagePickerOption(context);
                  },
                  icon: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const Icon(
                        Icons.camera_alt,
                        color: Colors.black,
                        size: 20,
                      )),
                )),
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
                      BlocProvider.of<AnnouncementCubit>(context).changeState(
                          AnnouncementUploadedPictureState(image: _image));
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
        BlocProvider.of<AnnouncementCubit>(context)
            .changeState(AnnouncementUploadedPictureState(image: _image));
      },
    );
    Navigator.of(context).pop();
  }
}
