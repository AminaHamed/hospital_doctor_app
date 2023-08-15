import 'package:flutter/material.dart';

import '../widgets/previousVisit_item.dart';

class PreviousVisitsTab extends StatelessWidget {
  const PreviousVisitsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: const Column(
        children: [
          //TODO listView
          PreviousVisitItem(),
          PreviousVisitItem(),
        ],
      ),
    );
  }
}
