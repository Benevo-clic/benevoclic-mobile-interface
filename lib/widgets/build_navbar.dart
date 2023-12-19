import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:namer_app/models/buildNavigation_model.dart';

class BuildNavBar extends StatefulWidget {
  late int? currentPageIndex;
  List<BuildNavigationModel>? buildNavigationModel;
  final Function(int) onPageChanged;
  late double? size;

  BuildNavBar(
      {super.key,
      this.currentPageIndex,
      this.buildNavigationModel,
      required this.onPageChanged,
      this.size});

  @override
  State<BuildNavBar> createState() => _BuildNavBarState();
}

class _BuildNavBarState extends State<BuildNavBar> {
  Widget buildNavigationIcon(String assetName, int index, {double? size}) {
    final bool isSelected = index == widget.currentPageIndex;

    // Logique pour l'état sélectionné
    if (isSelected) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            assetName,
            height: size ?? 24,
            color: Color.fromRGBO(55, 94, 232, 1),
          ),
        ],
      );
    } else {
      return SvgPicture.asset(
        assetName,
        height: size ?? 24,
      );
    }
  }

  IndexedStack buildIndexedStack(List<Widget> pages) {
    return IndexedStack(
      index: widget.currentPageIndex,
      children: pages,
    );
  }

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      backgroundColor: Color.fromRGBO(255, 153, 85, 1),
      // Fond transparent
      selectedIndex: widget.currentPageIndex ?? 0,
      onDestinationSelected: (index) {
        setState(() => widget.currentPageIndex = index);
        widget.onPageChanged(index);
      },
      indicatorColor: Colors.transparent,
      destinations: [
        NavigationDestination(
          icon: buildNavigationIcon(
              widget.buildNavigationModel![0].iconTitle, 0,
              size: 35),
          label: widget.buildNavigationModel![0].label,
          tooltip: widget.buildNavigationModel![0].label,
        ),
        NavigationDestination(
          icon: buildNavigationIcon(
              widget.buildNavigationModel![1].iconTitle, 1,
              size: widget.size),
          label: widget.buildNavigationModel![1].label,
          tooltip: widget.buildNavigationModel![1].label,
        ),
        NavigationDestination(
          icon: buildNavigationIcon(
              widget.buildNavigationModel![2].iconTitle, 2,
              size: 35),
          label: widget.buildNavigationModel![2].label,
          tooltip: widget.buildNavigationModel![2].label,
        ),
        NavigationDestination(
          icon: buildNavigationIcon(
              widget.buildNavigationModel![3].iconTitle, 3,
              size: 35),
          label: widget.buildNavigationModel![3].label,
          tooltip: widget.buildNavigationModel![3].label,
        ),
        // Répétez pour les autres éléments...
      ],
    );
  }
}
