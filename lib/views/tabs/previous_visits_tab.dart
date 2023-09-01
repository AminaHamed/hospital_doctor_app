import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hospital_app/models/VisitsRes.dart';

import '../../api/api_manager.dart';
import '../widgets/previousVisit_item.dart';

class PreviousVisitsTab extends StatelessWidget {
  PreviousVisitsTab({Key? key}) : super(key: key);
  final patientID = Get.arguments.toString();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<VisitsRes>>(
              stream: ApiManager.getPreviousVisitsStream(patientID),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  print(snapshot.error.toString());
                  return Center(
                      child:
                          Text('Error loading: ${snapshot.error.toString()}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Text('No visits available.');
                } else {
                  List<VisitsRes> visits = snapshot.data!;
                  return ListView.builder(
                      itemCount: visits.length,
                      itemBuilder: (context, index) {
                        return PreviousVisitItem(
                          visitsRes: visits[index],
                        );
                      });
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
