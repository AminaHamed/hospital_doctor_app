import 'package:flutter/material.dart';
import 'package:hospital_app/views/widgets/custom_appBar.dart';
import 'package:hospital_app/views/widgets/custom_drawer.dart';

import '../../models/tabBarList.dart';
import '../widgets/tabBarItem.dart';

class PatientDataScreen extends StatefulWidget {
  const PatientDataScreen({Key? key}) : super(key: key);

  @override
  State<PatientDataScreen> createState() => _PatientDataScreenState();
}

class _PatientDataScreenState extends State<PatientDataScreen> {
  int selectedIndex = 0;
  List<String> sources = [
    'Add visit',
    'Previous visits',
    'Patient Details',
    'Medical Analysis',
    'XRays',
    'Chronic Diseases'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(text: 'Patient Data'),
        drawer: const CustomDrawer(),
        body: DefaultTabController(
          length: sources.length,
          child: Column(
            children: [
              TabBar(
                isScrollable: true,
                tabs: sources
                    .map((tab) => TabBarItem(
                        text: tab,
                        isSelected: sources.indexOf(tab) == selectedIndex))
                    .toList(),
                onTap: (index) {
                  setState(() {
                    selectedIndex = index;
                    // print(selectedIndex);
                  });
                },
              ),
              Expanded(child: tabs[selectedIndex])
            ],
          ),
        ));
  }
}
