import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/PatientInformation.dart';
import 'custom_image_btn.dart';
import 'custom_outlineBorder_text.dart';
import 'custom_text.dart';

class XRayItem extends StatelessWidget {
  XRayItem({Key? key, this.xRay}) : super(key: key);

  // XRayResponse xRayResponse;
  XRay? xRay;

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
                  CustomText(text: 'XRay Date'),
                  const SizedBox(
                    width: 8,
                  ),
                  CustomOutlineBorderText(text: "${xRay?.xRayDate}" ?? '')
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  CustomText(text: 'Notes'),
                  const SizedBox(
                    width: 8,
                  ),
                  CustomOutlineBorderText(text: xRay?.notes ?? '')
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              CustomImageButton(
                text: 'View image',
                onTap: () {
                  Get.defaultDialog(
                      title: 'image',
                      content: Image.asset('assets/images/tesr.PNG'));
                },
              ),
              // CustomFormButton(text: 'View image',
              //   onPressed: (){
              //     Get.defaultDialog(
              //         title: 'image',
              //         content:Image.asset('assets/images/tesr.PNG')
              // Base64ImageDisplay(url??'')
              // CachedNetworkImage(
              //   imageUrl:url??'',
              //   progressIndicatorBuilder: (context, url, downloadProgress) =>
              //       Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
              //   errorWidget: (context, url, error) => const Icon(Icons.error),
              // ),

              // )

              // },

              // ),
            ],
          ),
        ),
      ),
    );
  }
}
