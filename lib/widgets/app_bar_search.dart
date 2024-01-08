import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppBarSearch extends StatefulWidget {
  final BuildContext contexts;
  final String? label;
  final Function(String) onSearchChanged;

  AppBarSearch(
      {super.key,
      required this.contexts,
      this.label,
      required this.onSearchChanged});

  @override
  State<AppBarSearch> createState() => _AppBarSearchState();
}

class _AppBarSearchState extends State<AppBarSearch> {
  final TextEditingController _controller = TextEditingController();

  Timer _debounce = Timer(Duration(milliseconds: 1), () {});

  Future<void> _searchAnnouncement(String query) async {
    try {
      if (_debounce.isActive) _debounce.cancel();
      _debounce = Timer(Duration(milliseconds: 500), () async {
        if (query.isEmpty) return;
        print(query);
        widget.onSearchChanged(query);
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(widget.contexts).size.width;
    double height = MediaQuery.of(widget.contexts).size.height;
    double iconSize = 0.05 * (width < height ? width : height);
    // widget.onSearchChanged();
    return Container(
      width: width,
      height: height * .2,
      decoration: BoxDecoration(
        color: Color.fromRGBO(255, 153, 85, 1),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 0,
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Center(
                  child: Text(
                    widget.label ?? '',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        // Action pour le premier bouton
                      },
                      padding: EdgeInsets.only(bottom: 10),
                      icon: Image.asset(
                        'assets/logo.png',
                        width: width * .11,
                        height: height * .07,
                      ),
                    ),
                    SizedBox(
                      width: width * 0.719,
                      height: height * 0.05,
                      // Hauteur fixe, par exemple 40 pixels
                      child: TextFormField(
                        controller: _controller,
                        onChanged: (value) {
                          setState(() {
                            _searchAnnouncement(value);
                          });
                        },
                        cursorColor: Color.fromRGBO(30, 29, 29, 1.0),
                        decoration: InputDecoration(
                          hintText: 'Rechercher',
                          fillColor: Colors.grey[200],
                          filled: true,
                          contentPadding: EdgeInsets.all(0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 1,
                            ),
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            size: iconSize,
                          ),
                          suffixIcon: _controller.text.isNotEmpty
                              ? IconButton(
                                  icon: Icon(
                                    Icons.cancel,
                                    size: iconSize,
                                  ),
                                  padding: EdgeInsets.all(0),
                                  onPressed: () {
                                    _controller.clear();
                                    setState(() {});
                                  },
                                )
                              : null, // Pas d'icône quand le champ est vide
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        // Action pour le deuxième bouton
                      },
                      padding: EdgeInsets.only(bottom: 1, right: 10, top: 6),
                      icon: SvgPicture.asset(
                        'assets/icons/Filter.svg',
                        width: width * .011,
                        height: height * .047,
                      ),
                    ),
                  ],
                ),
                // Barre de recherche
              ],
            ),
          ),
        ),
      ),
    );
  }
}
