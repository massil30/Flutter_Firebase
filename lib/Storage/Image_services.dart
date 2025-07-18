import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImageServices extends GetxController {
  // Observable list of images
  RxList<XFile> images = <XFile>[].obs;

  // Pick multiple images
  Future<void> pickImages() async {
    final ImagePicker _picker = ImagePicker();
    final List<XFile>? selectedImages = await _picker.pickMultiImage();

    if (selectedImages != null && selectedImages.isNotEmpty) {
      images.assignAll(selectedImages);
    }
  }

  // Clear images
  void clearImages() {
    images.clear();
  }
}
