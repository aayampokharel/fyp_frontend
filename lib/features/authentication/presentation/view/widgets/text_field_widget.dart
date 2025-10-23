import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final int containerSize;
  final TextEditingController textController;
  final String labelText;
  final String hintText;
  final Icon? trailingIcon1;
  final Icon? trailingIcon2;

  const TextFieldWidget({
    super.key,
    required this.containerSize,
    required this.textController,
    required this.labelText,
    required this.hintText,
    this.trailingIcon1,
    this.trailingIcon2,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: containerSize.toDouble(),
      child: TextField(
        controller: textController,

        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          suffixIcon: (trailingIcon1 != null)
              ? IconButton(onPressed: () {}, icon: trailingIcon1!)
              : null,
          //!logic for toogle to be added

          // suffixIconColor: Colors.grey,
        ),
      ),
    );
  }
}
