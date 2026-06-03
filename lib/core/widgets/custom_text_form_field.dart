import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField({
    super.key,
    required this.title,
    required this.controller,
    required this.hintText,
    this.maxLines,
    this.validator,
  });

  final TextEditingController controller;
  final String title;
  final String hintText;
  final Function(String?)? validator;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.displaySmall!.copyWith(fontSize: 16),
        ),
        SizedBox(height: 8),
        TextFormField(
          controller: controller,
          validator: validator != null
              ? (String? value) => validator!(value)
              : null,
          maxLines: maxLines,
          style: Theme.of(context).textTheme.labelMedium,
          decoration: InputDecoration(hintText: hintText),
        ),
      ],
    );
  }
}
