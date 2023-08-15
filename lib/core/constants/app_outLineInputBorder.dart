import 'package:flutter/material.dart';

appOutLineInputBorder({required Color color, double width = 1}) {
  return OutlineInputBorder(
    borderSide: BorderSide(color: color, width: width),
    borderRadius: BorderRadius.circular(20),
  );
}
