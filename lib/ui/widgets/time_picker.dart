import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyDatePicker extends StatelessWidget {
  final String? Function(String?)? validator;
  final String? Function(String?)? onSaved;
  final String? labelText;
  final String? initialValue;

  MyDatePicker(
      {this.validator,
      required this.onSaved,
      this.labelText,
      this.initialValue});
  @override
  Widget build(BuildContext context) {
    return DateTimePicker(
        type: DateTimePickerType.dateTime,
        dateMask: 'yyyy-MM-d hh:mm:a',
        decoration: InputDecoration(
            suffixIcon: Icon(Icons.calendar_today),
            filled: true,
            fillColor: Colors.white,
            labelText: labelText,
            labelStyle: GoogleFonts.montserrat(color: Colors.black),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: BorderSide(color: Colors.deepPurple)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: BorderSide(color: Colors.white)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: BorderSide(color: Colors.white))),
        style: GoogleFonts.montserrat(color: Colors.black),
        initialValue: initialValue,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),

        //onChanged: (val) => print(val),
        validator: (val) {
          print(val);
          return null;
        },
        onSaved: onSaved);
  }
}
