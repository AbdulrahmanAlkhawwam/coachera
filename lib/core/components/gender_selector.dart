import 'package:flutter/material.dart';

class GenderSelector extends StatefulWidget {
  final void Function(String?) onChanged;
  final String? initialGender; // "male" or "female"

  const GenderSelector({
    super.key,
    required this.onChanged,
    this.initialGender,
  });

  @override
  State<GenderSelector> createState() => _GenderSelectorState();
}

class _GenderSelectorState extends State<GenderSelector> {
  String? selectedGender;

  @override
  void initState() {
    super.initState();
    selectedGender = widget.initialGender;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
      ),
      value: selectedGender,
      items: const [
        DropdownMenuItem(value: "male", child: Text("Male")),
        DropdownMenuItem(value: "female", child: Text("Female")),
      ],
      onChanged: (val) {
        setState(() => selectedGender = val);
        widget.onChanged(val);
      },
      validator: (val) => val == null ? "Please select your gender" : null,
    );
  }
}
