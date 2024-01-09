import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:namer_app/cubit/association/association_cubit.dart';
import 'package:namer_app/cubit/association/association_state.dart';
import 'package:namer_app/models/association_model.dart';
import 'package:namer_app/widgets/app_bar_back.dart';

import '../../../models/location_model.dart';
import '../../../widgets/updating_profil_picture.dart';
import '../../common/authentification/login/widgets/customTextFormField_widget.dart';
import '../../common/authentification/signup/bio.dart';
import '../../common/authentification/signup/info_address.dart';
import '../navigation_association.dart';

class UpdateProfile extends StatefulWidget {
  final Association association;

  UpdateProfile({super.key, required this.association});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  Uint8List? image;
  late String _bio = "";
  late LocationModel location;

  late TextEditingController _nameAssociation = TextEditingController();
  late TextEditingController _typeAssociation = TextEditingController();

  final TextEditingController _phone = TextEditingController();

  @override
  void dispose() {
    _nameAssociation.dispose();
    _typeAssociation.dispose();
    _phone.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _nameAssociation.text = widget.association.name;
    _typeAssociation.text = widget.association.type;
    _phone.text = widget.association.phone;
    _bio = widget.association.bio!;
    location = widget.association.location!;
  }

  late final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _handleBioChanges(String? bio) async {
    setState(() {
      _bio = bio!;
    });
  }

  void _handleAddressFocusChanges(LocationModel? locationModel) async {
    setState(() {
      location = locationModel!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.15),
        child: AppBarBackWidget(),
      ),
      body: BlocConsumer<AssociationCubit, AssociationState>(
        listener: (context, state) {
          if (state is AssociationPictureState) {
            image = state.imageProfile;
            widget.association.imageProfile = base64Encode(image!);
            BlocProvider.of<AssociationCubit>(context).changeState(
                AssociationUpdatingState(associationModel: widget.association));
          }
          if (state is AssociationEditingState) {}
        },
        builder: (context, state) {
          if (state is AssociationLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is AssociationUpdatingState) {
            image = base64Decode(state.associationModel.imageProfile!);
            return _buildWidgetUpdate(context, widget.association);
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Widget _buildWidgetUpdate(BuildContext context, Association association) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            height: 20,
          ),
          Center(
            child: UpdatingProfilPicture(
              image: image,
            ),
          ),
          _infoAssociation(context),
          BioSignup(
            onBioChanged: _handleBioChanges,
            bio: association.bio,
          ),
          InfoAddress(
            handleAddressFocusChange: _handleAddressFocusChanges,
            address: association.location!.address,
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                Association associationUpdate = Association(
                    name: _nameAssociation.text,
                    phone: _phone.text,
                    location: location,
                    bio: _bio,
                    email: association.email,
                    imageProfile: base64Encode(image!),
                    type: _typeAssociation.text);

                BlocProvider.of<AssociationCubit>(context)
                    .updateAssociation(associationUpdate);

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NavigationAssociation()));
              } else {
                print("erreur");
              }
            },
            child: Text("Modifier"),
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }

  Widget _infoAssociation(BuildContext context) {
    return Stack(
      children: [
        Card(
          margin: const EdgeInsets.all(30),
          shadowColor: Colors.grey,
          elevation: 10,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
              side: BorderSide(color: Color.fromRGBO(235, 126, 26, 1))),
          color: Colors.white.withOpacity(0.8),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
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
                        controller: _nameAssociation,
                        hintText: "Nom de l'association",
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
                      CustomTextFormField(
                        controller: _typeAssociation,
                        hintText: "Type d'association",
                        icon: Icons.abc,
                        keyboardType: TextInputType.name,
                        obscureText: false,
                        prefixIcons: true,
                        maxLine: 1,
                        onSaved: (value) {},
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Le type d'association n'est pas valide";
                          } else if (RegExp(r'^[0-9]').hasMatch(value)) {
                            return "Le prénom ne doit pas commencer par un chiffre";
                          } else if (value.length > 50) {
                            return "Le prénom ne doit pas dépasser 50 caractères";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomTextFormField(
                        controller: _phone,
                        hintText: "Téléphone",
                        icon: Icons.phone,
                        keyboardType: TextInputType.phone,
                        obscureText: false,
                        prefixIcons: true,
                        onSaved: (value) {},
                        validator: (value) {
                          var regex = RegExp(r"^(0|\+33|0033)[1-9][0-9]{8}$");
                          if (value == null ||
                              !regex.hasMatch(value.toString())) {
                            return "Votre numéro de téléphone n'est pas valide";
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
      ],
    );
  }

//
// listview(BuildContext context, Association association) {
//   String email = "";
//   String bio = "";
//   String phone = "";
//   String address = "";
//
//   final _formKey = GlobalKey<FormState>();
//   return ListView(padding: EdgeInsets.all(25), children: [
//     Form(
//         key: _formKey,
//         child: Column(
//           children: [
//             SizedBox(
//               height: 20,
//             ),
//             SizedBox(
//               width: MediaQuery.of(context).size.width * .9,
//               height: MediaQuery.of(context).size.height * .35,
//               child: Card(
//                 margin: const EdgeInsets.all(5),
//                 shadowColor: Colors.grey,
//                 elevation: 10,
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(25),
//                     side: BorderSide(color: Color.fromRGBO(235, 126, 26, 1))),
//                 color: Colors.white.withOpacity(0.8),
//                 child: Padding(
//                   padding: EdgeInsets.all(15),
//                   child: MyImagePicker(
//                     rulesType: RulesType.USER_ASSOCIATION,
//                     association: association,
//                   ),
//                 ),
//               ),
//             ),
//             Divider(
//               height: 25,
//               color: Colors.white,
//             ),
//             ContentWidget(
//               content: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   TitleWithIcon(title: "Bio", icon: Icon(Icons.location_city)),
//                   Divider(
//                     height: 25,
//                     color: Colors.white,
//                   ),
//                   TextFormField(
//                     initialValue: association.bio,
//                     onSaved: (value) {
//                       bio = value.toString();
//                     },
//                     validator: (value) {
//                       bio = value.toString();
//                       return null;
//                     },
//                     decoration: InputDecoration(
//                         prefixIcon: Icon(Icons.location_on_outlined),
//                         hintStyle: TextStyle(color: Colors.grey),
//                         hintText: association.bio,
//                         border: UnderlineInputBorder()),
//                   ),
//                 ],
//               ),
//             ),
//             Divider(
//               height: 25,
//               color: Colors.white,
//             ),
//             ContentWidget(
//               content: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   TitleWithIcon(
//                       title: "Informations", icon: Icon(Icons.location_city)),
//                   Divider(
//                     height: 25,
//                     color: Colors.white,
//                   ),
//                   TextFormField(
//                     initialValue: association.location?.address,
//                     onSaved: (value) {
//                       address = value.toString();
//                     },
//                     validator: (value) {
//                       address = value.toString();
//                       return null;
//                     },
//                     decoration: InputDecoration(
//                         prefixIcon: Icon(Icons.location_on_outlined),
//                         hintStyle: TextStyle(color: Colors.grey),
//                         hintText: association.location!.address,
//                         border: UnderlineInputBorder()),
//                   ),
//                   Divider(
//                     height: 25,
//                     color: Colors.white,
//                   ),
//                   TextFormField(
//                     initialValue: association.email,
//                     onSaved: (value) {
//                       email = value.toString();
//                     },
//                     validator: (value) {
//                       email = value.toString();
//                       return null;
//                     },
//                     decoration: InputDecoration(
//                         prefixIcon: Icon(Icons.mail),
//                         hintStyle: TextStyle(color: Colors.grey),
//                         hintText: "${association.email}",
//                         border: UnderlineInputBorder()),
//                   ),
//                   Divider(
//                     height: 25,
//                     color: Colors.white,
//                   ),
//                   TextFormField(
//                     initialValue: association.phone,
//                     onSaved: (value) {
//                       phone = value.toString();
//                     },
//                     validator: (value) {
//                       var phoneParam = PhoneVerification(value.toString());
//                       if (phoneParam.security()) {
//                         phone = value.toString();
//                         return null;
//                       } else {
//                         return phoneParam.message;
//                       }
//                     },
//                     decoration: InputDecoration(
//                         prefixIcon: Icon(Icons.phone_android),
//                         hintStyle: TextStyle(color: Colors.grey),
//                         hintText: association.phone,
//                         border: UnderlineInputBorder()),
//                   ),
//                 ],
//               ),
//             ),
//             Divider(
//               height: 25,
//               color: Colors.white,
//             ),
//           ],
//         )),
//     Divider(
//       height: 25,
//       color: Colors.white,
//     ),
//     ElevatedButton(
//         onPressed: () {
//           if (_formKey.currentState!.validate()) {
//             Association associationUpdate = Association(
//                 name: association.name,
//                 phone: phone,
//                 location: association.location,
//                 bio: bio,
//                 city: association.city,
//                 email: association.email,
//                 imageProfile: association.imageProfile,
//                 postalCode: association.postalCode,
//                 type: '');
//
//             BlocProvider.of<AssociationCubit>(context)
//                 .updateAssociation(associationUpdate);
//             BlocProvider.of<AssociationCubit>(context)
//                 .stateInfo(associationUpdate);
//
//             Navigator.pop(context);
//           } else {
//             print("erreur");
//           }
//         },
//         child: Text("Modifier"))
//   ]);
// }
//
// class MyImagePicker extends StatefulWidget {
//   final Uint8List? image;
//   final RulesType? rulesType;
//   final Association association;
//
//   const MyImagePicker(
//       {super.key, this.image, this.rulesType, required this.association});
//
//   @override
//   State<MyImagePicker> createState() => _MyImagePickerState();
// }
//
// class _MyImagePickerState extends State<MyImagePicker> {
//   Uint8List? _image;
//   File? selectedIMage;
//   final _imagePicker = ImagePicker();
//   final _imageCropper = ImageCropper();
//
//   Future<CroppedFile?> _cropImage(
//           {required XFile file,
//           CropStyle cropStyle = CropStyle.circle}) async =>
//       await _imageCropper.cropImage(
//         cropStyle: cropStyle,
//         sourcePath: file.path,
//         compressQuality: 100,
//       );
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       child: Center(
//         child: Stack(
//           children: [
//             _image != null
//                 ? CircleAvatar(
//                     radius: 100, backgroundImage: MemoryImage(_image!))
//                 : const CircleAvatar(
//                     radius: 100,
//                     backgroundImage: NetworkImage(
//                         "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png"),
//                   ),
//             Positioned(
//               bottom: -0,
//               left: 140,
//               child: IconButton(
//                 onPressed: () {
//                   showImagePickerOption(context);
//                 },
//                 icon: SvgPicture.asset(
//                   'assets/icons/Ellipse 116.svg',
//                   height: 20,
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
//
//   void showImagePickerOption(BuildContext context) {
//     showModalBottomSheet(
//       backgroundColor: Colors.white,
//       context: context,
//       builder: (builder) {
//         return Padding(
//           padding: const EdgeInsets.all(18.0),
//           child: SizedBox(
//             width: MediaQuery.of(context).size.width,
//             height: MediaQuery.of(context).size.height / 4.5,
//             child: Row(
//               children: [
//                 Expanded(
//                   child: InkWell(
//                     onTap: () {
//                       _pickImage(context, ImageSource.gallery);
//                     },
//                     child: const SizedBox(
//                       child: Column(
//                         children: [
//                           Icon(
//                             Icons.image,
//                             size: 70,
//                           ),
//                           Text("Galerie")
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: InkWell(
//                     onTap: () {
//                       _pickImage(context, ImageSource.camera);
//                     },
//                     child: const SizedBox(
//                       child: Column(
//                         children: [
//                           Icon(
//                             Icons.camera_alt,
//                             size: 70,
//                           ),
//                           Text("Camera")
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: InkWell(
//                     onTap: () {
//                       _image = null;
//
//                       Navigator.of(context).pop();
//                     },
//                     child: const SizedBox(
//                       child: Column(
//                         children: [
//                           Icon(
//                             Icons.delete,
//                             size: 70,
//                           ),
//                           Text("Supprimer")
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   Future _pickImage(BuildContext context, ImageSource source) async {
//     final returnImage =
//         await _imagePicker.pickImage(source: source, imageQuality: 100);
//     if (returnImage == null) return;
//     final croppedFile = await _cropImage(file: returnImage);
//     if (croppedFile == null) return;
//
//     setState(
//       () {
//         selectedIMage = File(croppedFile.path);
//         _image = File(croppedFile.path).readAsBytesSync(); // <-- here
//         if (widget.rulesType == RulesType.USER_ASSOCIATION) {
//           BlocProvider.of<AssociationCubit>(context).updateAssociation(
//               Association(
//                   type: '',
//                   name: widget.association.name,
//                   phone: widget.association.phone,
//                   location: widget.association.location,
//                   bio: widget.association.bio,
//                   city: widget.association.city,
//                   email: widget.association.email,
//                   imageProfile: base64Encode(_image!),
//                   postalCode: widget.association.postalCode,
//                   announcement: widget.association.announcement,
//                   verified: widget.association.verified,
//                   volunteers: widget.association.volunteers,
//                   volunteersWaiting: widget.association.volunteersWaiting));
//           BlocProvider.of<AssociationCubit>(context).stateInfo(Association(
//               type: '',
//               name: widget.association.name,
//               phone: widget.association.phone,
//               location: widget.association.location,
//               bio: widget.association.bio,
//               city: widget.association.city,
//               email: widget.association.email,
//               imageProfile: base64Encode(_image!),
//               postalCode: widget.association.postalCode,
//               announcement: widget.association.announcement,
//               verified: widget.association.verified,
//               volunteers: widget.association.volunteers,
//               volunteersWaiting: widget.association.volunteersWaiting));
//         } else {}
//       },
//     );
//     Navigator.of(context).pop();
//   }
// }
}
