import 'package:flutter/material.dart';
import 'package:flutter_dashboard/core/constants/color_constants.dart';

class NavBarWidget extends StatelessWidget {
  final String companyName;
  final Icon icon1;
  final Icon icon2;
  final VoidCallback? onPressedIcon1;
  final VoidCallback? onPressedIcon2;

  const NavBarWidget({
    super.key,
    this.companyName = 'Flutter Project',
    required this.icon1,
    required this.icon2,
    required this.onPressedIcon1,
    required this.onPressedIcon2,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorConstants.primaryPurple,
      title: Text(companyName),
      actions: [
        IconButton(onPressed: onPressedIcon1, icon: icon1),
        IconButton(onPressed: onPressedIcon2, icon: icon2),
      ],
    );
  }
}
