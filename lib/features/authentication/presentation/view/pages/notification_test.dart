import 'package:flutter/material.dart';
import 'package:flutter_dashboard/features/authentication/presentation/view/widgets/nav_bar_widget.dart';

class Notifications extends StatelessWidget {
  const Notifications({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: NavBarWidget(
          icon1: Icon(Icons.person, color: Colors.white),
          icon2: Icon(Icons.logout, color: Colors.white),
          onPressedIcon1: () {},
          onPressedIcon2: () {},
          companyName: "hello brother",
        ),
      ),
      body: Center(child: Text("Notifications Page")),
    );
  }
}
