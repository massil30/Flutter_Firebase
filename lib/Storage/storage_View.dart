import 'package:flutter/material.dart';
import 'package:flutter_firebase/Storage/Image_services.dart';
import 'package:flutter_firebase/Storage/storage_services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class StorageView extends StatefulWidget {
  @override
  _StorageViewState createState() => _StorageViewState();
}

class _StorageViewState extends State<StorageView> {
  final image_controller = Get.find<ImageServices>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pick an Image')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Obx(() {
            return Wrap(
              children: image_controller.images.map((image) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.file(
                    File(image.path),
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                );
              }).toList(),
            );
          }),
          ElevatedButton(
            onPressed: () async {
              try {
                await image_controller.pickImages(); // ✅ This fixes your issue
              } catch (e) {
                Get.snackbar('Error', 'Failed to pick images: $e');
              }
            },
            child: Text('Select from Gallery'),
          ),
        ],
      ),
    );
  }
}
