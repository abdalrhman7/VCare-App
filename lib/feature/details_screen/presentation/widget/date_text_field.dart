import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/text_style.dart';

class DateTextField extends StatelessWidget {
  const DateTextField({super.key, required this.dateController});

  final TextEditingController dateController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please Select Date';
        }
        return null;
      },
      controller: dateController,
      onTap: () async {
        final selectedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2023),
          lastDate: DateTime(2026),
        );
        if (selectedDate != null) {
          final data = selectedDate;
          String formattedDate = DateFormat('yyyy-MM-dd').format(data);
          dateController.text = formattedDate;
        }
      },
      decoration: InputDecoration(
        hintText:
        dateController.text.isEmpty ? 'Select Date' : dateController.text,
        hintStyle: Style.textStyle16,
      ),
    );
  }
}
