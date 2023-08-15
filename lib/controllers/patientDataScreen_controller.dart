import 'package:get/get.dart';

class PatientDataScreenController extends GetxController {
  RxInt selectedIndex = 0.obs;
  List<String> tabBarItemsList = [
    'Add visit',
    'Previous visits',
    'Patient Details',
    'Medical Analysis',
    'XRays',
    'Chronic Diseases'
  ];
}
