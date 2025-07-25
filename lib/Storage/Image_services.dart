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

  // Delete image at a specific index
  void deleteImageAt(int index) {
    images.removeAt(index);
  }

  // Compress all images (returns list of compressed XFile)
  // Note: Requires 'image' and 'path_provider' packages for actual compression.
  // This is a placeholder for demonstration.
  Future<List<XFile>> compressAllImages() async {
    // TODO: Implement actual compression logic using image/image.dart or flutter_image_compress
    // For now, just return the original images
    return images.toList();
  }
}
