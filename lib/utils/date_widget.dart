import 'package:flutter/material.dart';

import '../core/constants/app_color.dart';
import 'date_utils.dart';

class DateWidget extends StatelessWidget {
  DateWidget({Key? key, required this.selectedDate, required this.onTap})
      : super(key: key);
  void Function()? onTap;
  DateTime selectedDate;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: AppColor.primaryColor, width: 1)),
          child: Row(
            children: [
              Text(
                MyDateUtils.formatDateToString(selectedDate),
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: AppColor.grey),
              ),
              const Spacer(),
              const Icon(
                Icons.calendar_month,
                color: AppColor.grey,
              )
            ],
          ),
        ),
      ),
    );
  }
}
