import 'package:flutter/material.dart';

class BirthDatePicker extends StatefulWidget {
  final void Function(DateTime?) onChanged;
  final DateTime? initialDate;

  const BirthDatePicker({
    super.key,
    required this.onChanged,
    this.initialDate,
  });

  @override
  State<BirthDatePicker> createState() => _BirthDatePickerState();
}

class _BirthDatePickerState extends State<BirthDatePicker> {
  int? selectedYear;
  int? selectedMonth;
  int? selectedDay;

  @override
  void initState() {
    super.initState();
    if (widget.initialDate != null) {
      selectedYear = widget.initialDate!.year;
      selectedMonth = widget.initialDate!.month;
      selectedDay = widget.initialDate!.day;
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentYear = DateTime.now().year;
    final years = List.generate(100, (i) => currentYear - i); // آخر 100 سنة
    final months = List.generate(12, (i) => i + 1);
    final days = selectedYear != null && selectedMonth != null
        ? List.generate(
            DateTime(selectedYear!, selectedMonth! + 1, 0).day,
            (i) => i + 1,
          )
        : <int>[];

    void notifyParent() {
      if (selectedYear != null &&
          selectedMonth != null &&
          selectedDay != null) {
        widget.onChanged(
          DateTime(selectedYear!, selectedMonth!, selectedDay!),
        );
      } else {
        widget.onChanged(null);
      }
    }

    return Row(
      children: [
        Expanded(
          child: DropdownButtonFormField<int>(
            initialValue: selectedYear,
            items: years
                .map((y) => DropdownMenuItem(value: y, child: Text("$y")))
                .toList(),
            onChanged: (val) {
              setState(() {
                selectedYear = val;
                selectedDay = null;
              });
              notifyParent();
            },
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: DropdownButtonFormField<int>(
            initialValue: selectedMonth,
            items: months
                .map((m) => DropdownMenuItem(value: m, child: Text("$m")))
                .toList(),
            onChanged: (val) {
              setState(() {
                selectedMonth = val;
                selectedDay = null;
              });
              notifyParent();
            },
          ),
        ),
        const SizedBox(width: 12),

        // Day
        Expanded(
          child: DropdownButtonFormField<int>(
            initialValue: selectedDay,
            items: days
                .map((d) => DropdownMenuItem(value: d, child: Text("$d")))
                .toList(),
            onChanged: (val) {
              setState(() => selectedDay = val);
              notifyParent();
            },
          ),
        ),
      ],
    );
  }
}
