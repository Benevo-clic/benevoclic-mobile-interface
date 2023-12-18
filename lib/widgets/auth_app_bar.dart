import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:namer_app/views/home_view.dart';

import '../views/navigation_no_indentify.dart';

class AuthAppBar extends StatelessWidget {
  final bool? isLogin;

  const AuthAppBar({super.key, required this.contexts, this.isLogin});

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
                        if (isLogin != true) {
                          Navigator.pop(contexts);
                        } else {
                          Navigator.push(
                              contexts,
                              MaterialPageRoute(
                                  builder: (contexts) => HomeView()));
                        }
                      },
                      icon: SvgPicture.asset(
                        "assets/icons/arrow-left.svg",
                        height: MediaQuery.of(contexts).size.height * .04,
                      ), // Définissez la taille de l'icône
                    ),
                  ),
                ),
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
                      icon: SvgPicture.asset(
                        "assets/icons/cancel.svg",
                        height: MediaQuery.of(contexts).size.height * .04,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
