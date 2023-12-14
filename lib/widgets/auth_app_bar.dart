import 'package:flutter/material.dart';

import '../views/navigation_no_indentify.dart';

class AuthAppBar extends StatelessWidget {
  const AuthAppBar({super.key, required this.contexts});

  final BuildContext contexts;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(contexts).size.width,
        height: 140,
        child: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: SafeArea(
            child: Row(
              children: [
                Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(contexts);
                        },
                        icon: Icon(
                          Icons.arrow_circle_left_sharp,
                          color: Color.fromRGBO(170, 77, 79, 1),
                          size: MediaQuery.of(contexts).size.height * .05,
                        ),
                      ),
                    )),
                Expanded(
                  flex: 1,
                  child: Image.asset(
                    "assets/logo.png",
                    height: MediaQuery.of(context).size.height * .05 * 2,
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: IconButton(
                        onPressed: () {
                          Navigator.push(
                              contexts,
                              MaterialPageRoute(
                                  builder: (contexts) =>
                                      NavigationNoIndentify()));
                        },
                        icon: Icon(Icons.cancel,
                            color: Color.fromRGBO(170, 77, 79, 1),
                            size: MediaQuery.of(contexts).size.height * .05),
                      ),
                    ))
              ],
            ),
          ),
        ));
  }
}
