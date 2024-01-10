import 'package:flutter/material.dart';

import '../../../../models/location_model.dart';
import '../../../../widgets/location_form_autocomplete_widget.dart';

class InfoAddress extends StatefulWidget {
  final Function(LocationModel?) handleAddressFocusChange;
  String? address = "";

  InfoAddress(
      {super.key, required this.handleAddressFocusChange, this.address});

  @override
  State<InfoAddress> createState() => _InfoAdressState();
}

class _InfoAdressState extends State<InfoAddress> {
  late LocationModel location;

  final FocusNode _addressFocusNode = FocusNode();
  final TextEditingController _addressController = TextEditingController();
  late final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _addressFocusNode.dispose();
  }

  @override
  void initState() {
    super.initState();
    location = LocationModel(
      address: "",
      latitude: 0,
      longitude: 0,
    );
    if (widget.address != null) {
      _addressController.text = widget.address!;
    }
    _addressFocusNode.addListener(onAddressFocusChange);
  }

  void onAddressFocusChange() async {
    if (_addressFocusNode.hasFocus) {
      LocationModel? selectedLocation = await ShowInputAutocomplete(context);
      setState(() {
        if (selectedLocation != null) {
          location = LocationModel(
            address: selectedLocation.address,
            latitude: selectedLocation.latitude,
            longitude: selectedLocation.longitude,
          );
          widget.handleAddressFocusChange(location);
          _addressController.text = selectedLocation.address;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
                      _buildAddressField(),
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
      ],
    );
  }

  Widget _buildAddressField() {
    double width = MediaQuery.of(context).size.width;

    return SizedBox(
      width: width * 0.8,
      child: TextFormField(
        focusNode: _addressFocusNode,
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
          hintText: "Votre adresse",
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
