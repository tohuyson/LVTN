import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String? hintText;
  final IconData? icon;
  final ValueChanged<String>? onChanged;
  final bool autofocus;
  final bool obscureText;

  final String? initValue;

  final FormFieldValidator<String>? validator;

  final TextEditingController? controller;

  const InputField({
    Key? key,
    this.controller,
    this.hintText,
    this.icon,
    this.onChanged,
    this.autofocus = false,
    this.initValue,
    this.validator,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      initialValue: this.initValue,
      autofocus: this.autofocus,
      onChanged: onChanged,
      maxLines: 1,
      textAlignVertical: TextAlignVertical.center,
      cursorColor: Theme.of(context).primaryColor,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        prefixIcon: Icon(
          icon,
          color: Theme.of(context).primaryColor,
        ),
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            width: 1,
            style: BorderStyle.none,
          ),
        ),
      ),
    );
  }
}
