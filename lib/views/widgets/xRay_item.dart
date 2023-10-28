import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

import '../../api/api_manager.dart';
import '../../models/patient_information.dart';
import 'custom_image_btn.dart';
import 'custom_outlineBorder_text.dart';
import 'custom_text.dart';

class XRayItem extends StatefulWidget {
  XRayItem({Key? key, this.xRay}) : super(key: key);

  // XRayResponse xRayResponse;
  XRay? xRay;

  @override
  State<XRayItem> createState() => _XRayItemState();
}

class _XRayItemState extends State<XRayItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Slidable(
        startActionPane: ActionPane(
          extentRatio: .2,
          motion: const DrawerMotion(),
          children: [
            SlidableAction(
              onPressed: (buildContext) async {
                await ApiManager.deleteXray('${widget.xRay?.xRayId}' ?? '');
                setState(() {});
              },
              backgroundColor: Colors.red,
              icon: Icons.delete,
              label: 'Delete',
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
            )
          ],
        ),
        child: Card(
          elevation: 10,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
                    CustomOutlineBorderText(
                        text: "${widget.xRay?.xRayDate}" ?? '')
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
                    CustomOutlineBorderText(text: widget.xRay?.notes ?? '')
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
                        content: widget.xRay!.xRayImage!.isNotEmpty
                            ? Image.memory(
                                base64Decode(widget.xRay?.xRayImage ?? ''),
                                width: 200,
                                height: 200,
                              )
                            : const Text('No Image to display'));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
