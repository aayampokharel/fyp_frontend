// // import 'package:flutter/material.dart';

// // class TextFieldWidget extends StatelessWidget {
// //   final int containerSize;
// //   final TextEditingController textController;
// //   final String labelText;
// //   final String hintText;
// //   final Icon? trailingIcon1;
// //   final Icon? trailingIcon2;

// //   const TextFieldWidget({
// //     super.key,
// //     required this.containerSize,
// //     required this.textController,
// //     required this.labelText,
// //     required this.hintText,
// //     this.trailingIcon1,
// //     this.trailingIcon2,
// //   });

// //   @override
// //   Widget build(BuildContext context) {
// //     return SizedBox(
// //       width: containerSize.toDouble(),
// //       child: TextField(
// //         controller: textController,

// //         decoration: InputDecoration(
// //           labelText: labelText,
// //           hintText: hintText,
// //           suffixIcon: (trailingIcon1 != null)
// //               ? IconButton(onPressed: () {}, icon: trailingIcon1!)
// //               : null,
// //           //!logic for toogle to be added

// //           // suffixIconColor: Colors.grey,
// //         ),
// //       ),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:flutter_dashboard/core/constants/color_constants.dart';

// class CustomTextFieldWidget extends StatelessWidget {
//   final TextEditingController controller;
//   final String label;
//   final IconData icon;
//   final String? errorText;
//   final TextInputType keyboardType;

//   const CustomTextFieldWidget({
//     super.key,
//     required this.controller,
//     required this.label,
//     required this.icon,
//     this.errorText,
//     this.keyboardType = TextInputType.text,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         TextField(
//           controller: controller,
//           keyboardType: keyboardType,
//           decoration: InputDecoration(
//             labelText: label,
//             prefixIcon: Icon(icon, color: ColorConstants.primaryBlue),
//             filled: true,
//             fillColor: ColorConstants.white,
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//               borderSide: BorderSide.none,
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//               borderSide: BorderSide(color: ColorConstants.lightGray),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//               borderSide: BorderSide(
//                 color: ColorConstants.primaryBlue,
//                 width: 2,
//               ),
//             ),
//           ),
//         ),
//         if (errorText != null)
//           Padding(
//             padding: const EdgeInsets.only(top: 6, left: 8),
//             child: Row(
//               children: [
//                 const Icon(
//                   Icons.error_outline,
//                   color: Colors.redAccent,
//                   size: 16,
//                 ),
//                 const SizedBox(width: 6),
//                 Text(
//                   errorText!,
//                   style: const TextStyle(
//                     color: Colors.redAccent,
//                     fontSize: 13,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_dashboard/core/constants/color_constants.dart';

class CustomTextFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final String? errorText;
  final TextInputType keyboardType;
  final bool isPassword;
  final String? hintText;

  const CustomTextFieldWidget({
    super.key,
    required this.controller,
    required this.label,
    required this.icon,
    this.errorText,
    this.hintText,
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
  });

  @override
  State<CustomTextFieldWidget> createState() => _CustomTextFieldWidgetState();
}

class _CustomTextFieldWidgetState extends State<CustomTextFieldWidget> {
  bool _obscureText = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          obscureText: widget.isPassword ? _obscureText : false,
          decoration: InputDecoration(
            labelText: widget.label,
            hintText: widget.hintText,
            prefixIcon: Icon(widget.icon, color: ColorConstants.primaryBlue),
            suffixIcon: widget.isPassword
                ? IconButton(
                    onPressed: _togglePasswordVisibility,
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                      color: ColorConstants.mediumGray,
                    ),
                  )
                : null,
            filled: true,
            fillColor: ColorConstants.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: ColorConstants.lightGray),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: ColorConstants.primaryBlue,
                width: 2,
              ),
            ),
          ),
        ),
        if (widget.errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 6, left: 8),
            child: Row(
              children: [
                const Icon(
                  Icons.error_outline,
                  color: Colors.redAccent,
                  size: 16,
                ),
                const SizedBox(width: 6),
                Text(
                  widget.errorText!,
                  style: const TextStyle(
                    color: Colors.redAccent,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
