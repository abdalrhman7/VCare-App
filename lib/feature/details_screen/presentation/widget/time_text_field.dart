import 'package:flutter/material.dart';

import '../../../../core/constants/text_style.dart';

class TimeTextField extends StatelessWidget {
  const TimeTextField({
    super.key,
    required this.timeController,
  });

  final TextEditingController timeController;


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please Select Time';
        }
        return null;
      },
      controller: timeController,
      onTap: () async {
        final selectedDate = await showTimePicker(
          initialEntryMode: TimePickerEntryMode.dial,
          context: context,
          initialTime: TimeOfDay.now(),
          cancelText: "Cancel",
          confirmText: "Save",
          helpText: "Select time",
          builder: (context, Widget? child) {
            return MediaQuery(
              data: MediaQuery.of(context)
                  .copyWith(alwaysUse24HourFormat: true),
              child: child!,
            );
          },
        );
        if (selectedDate != null) {
          final formattedDate =
              '${selectedDate.hour.toString()}:${selectedDate.minute.toString().padLeft(2, '0')}';
          timeController.text = formattedDate;
        }
      },
      decoration: InputDecoration(
        hintText: timeController.text.isEmpty
            ? 'Select Time'
            : timeController.text,
        hintStyle: Style.textStyle16,
      ),
    );
  }
}