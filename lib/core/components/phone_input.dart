import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PhoneNumberField extends StatelessWidget {
  final TextEditingController controller;
  final String? initialValue;
  final void Function(String)? onChanged;

  const PhoneNumberField({
    super.key,
    required this.controller,
    this.initialValue,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller..text = initialValue ?? "+",
      keyboardType: TextInputType.phone,
      decoration: const InputDecoration(
        labelText: "Phone Number",
        border: OutlineInputBorder(),
      ),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^\+\d*')), // يبدأ بـ +
      ],
      onChanged: onChanged,
      validator: (value) {
        if (value == null || value.isEmpty || value.length < 8) {
          return "Please enter a valid phone number";
        }
        if (!value.startsWith("+")) {
          return "Phone number must start with +";
        }
        return null;
      },
    );
  }
}
