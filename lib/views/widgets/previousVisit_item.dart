import 'package:flutter/material.dart';

import 'custom_outlineBorder_text.dart';
import 'custom_text.dart';

class PreviousVisitItem extends StatelessWidget {
  const PreviousVisitItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: Colors.white70,
        child: Container(
          // height: 200,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          child: Column(
            children: [
              Row(
                children: [
                  CustomText(text: 'Date'),
                  const SizedBox(
                    width: 8,
                  ),
                  CustomOutlineBorderText(text: 'mm/dd/yyyy')
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  CustomText(text: 'Diagnosis'),
                  const SizedBox(
                    width: 8,
                  ),
                  CustomOutlineBorderText(text: 'Diagnosis')
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  CustomText(text: 'Pharmaceutical'),
                  const SizedBox(
                    width: 8,
                  ),
                  CustomOutlineBorderText(text: 'Pharmaceutical')
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
