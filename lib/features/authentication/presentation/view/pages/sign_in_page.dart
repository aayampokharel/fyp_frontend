import "package:flutter/material.dart";
import "package:flutter_dashboard/core/constants/color_constants.dart";
import "package:flutter_dashboard/core/constants/image_constants.dart";
import "package:flutter_dashboard/core/constants/string_constants.dart";
import "package:flutter_dashboard/features/authentication/presentation/view/widgets/colored_button_widget.dart";
import "package:flutter_dashboard/features/authentication/presentation/view/widgets/container_with_two_parts_widget.dart";
import "package:flutter_dashboard/features/authentication/presentation/view/widgets/nav_bar_widget.dart";
import "package:flutter_dashboard/features/authentication/presentation/view/widgets/text_field_widget.dart";

class SignInPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController institutionController = TextEditingController();
  SignInPage({super.key});

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
          companyName: StringConstants.companyName,
        ),
      ),
      body: Center(
        child: ContainerWithTwoParts(
          height: 800,
          width: 800,
          imagePath: ImageConstants.natureImage,
          companyLogo: ImageConstants.logoImage,
          companyName: StringConstants.companyName,
          taskName: "Sign In",
          taskDescription: "Please sign in to continue",
          rightSideChild: Column(
            children: [
              TextFieldWidget(
                containerSize: 350,
                textController: emailController,
                labelText: "email",
                hintText: "Enter your email",
              ),
              TextFieldWidget(
                containerSize: 350,
                textController: institutionController,
                labelText: "Institution Name",
                hintText: "Enter your Institution",
              ),
              ColoredButtonWidget(
                onPressed: () {},
                width: 300,
                textColor: Colors.white,
                height: 300,
                color: ColorConstants.accentPurple,
                text: "Sign In",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
