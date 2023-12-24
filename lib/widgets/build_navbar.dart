import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../cubit/page/page_cubit.dart';
import '../models/buildNavigation_model.dart';

class BuldNavBar extends StatelessWidget {
  final List<BuildNavigationModel>? buildNavigationModel;
  final Function(int)? onItemTapped;

  BuldNavBar({super.key, this.buildNavigationModel, this.onItemTapped});

  Widget buildNavigationIcon(String assetName, int index, bool isSelected) {
    double? iconSize = buildNavigationModel![index].size;

    return SvgPicture.asset(
      assetName,
      height: iconSize,
      color: isSelected ? Color.fromRGBO(55, 94, 232, 1) : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PageCubit, int>(
      builder: (context, currentPageIndex) {
        return CurvedNavigationBar(
          backgroundColor: Colors.transparent,
          buttonBackgroundColor: Color.fromRGBO(255, 153, 85, 1),
          color: Color.fromRGBO(255, 153, 85, 1),
          height: 60,
          index: currentPageIndex,
          onTap: (index) {
            if (onItemTapped != null) {
              onItemTapped!(index);
            } else {
              context.read<PageCubit>().setPage(index);
            }
          },
          items: buildNavigationModel!.map((e) {
            return buildNavigationIcon(
              e.iconTitle,
              buildNavigationModel!.indexOf(e),
              buildNavigationModel!.indexOf(e) == currentPageIndex,
            );
          }).toList(),

          // items: List.generate(buildNavigationModel!.length, (index) {
          //   return NavigationDestination(
          //     icon: buildNavigationIcon(
          //       buildNavigationModel![index].iconTitle,
          //       index,
          //       index == currentPageIndex,
          //     ),
          //     label: buildNavigationModel![index].label,
          //     tooltip: buildNavigationModel![index].label,
          //   );
          // }),
        );
      },
    );
  }
}
