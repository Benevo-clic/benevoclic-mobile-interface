import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../cubit/page/page_cubit.dart';
import '../models/buildNavigation_model.dart';

class BuldNavBar extends StatelessWidget {
  final List<BuildNavigationModel>? buildNavigationModel;

  BuldNavBar({super.key, this.buildNavigationModel});

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
        return NavigationBar(
          backgroundColor: Color.fromRGBO(255, 153, 85, 1),
          selectedIndex: currentPageIndex,
          onDestinationSelected: (index) {
            context.read<PageCubit>().setPage(index);
          },
          indicatorColor: Colors.transparent,
          destinations: List.generate(buildNavigationModel!.length, (index) {
            return NavigationDestination(
              icon: buildNavigationIcon(
                buildNavigationModel![index].iconTitle,
                index,
                index == currentPageIndex,
              ),
              label: buildNavigationModel![index].label,
              tooltip: buildNavigationModel![index].label,
            );
          }),
        );
      },
    );
  }
}
