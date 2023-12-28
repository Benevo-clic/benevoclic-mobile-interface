import 'package:flutter/material.dart';

class MoreActionAnnouncement extends StatefulWidget {
  const MoreActionAnnouncement({super.key});

  @override
  State<MoreActionAnnouncement> createState() => _MoreActionAnnouncementState();
}

class _MoreActionAnnouncementState extends State<MoreActionAnnouncement> {
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
            child: Column(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {},
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
                    onTap: () {},
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
                      Navigator.pop(context);
                    },
                    child: const SizedBox(
                      child: Column(
                        children: [
                          Icon(
                            Icons.close,
                            size: 70,
                          ),
                          Text("Annuler")
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

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
