import 'package:TaklyAPP/core/functions/font_size_controller.dart';
import 'package:get/get.dart';

class FontSizeBinding extends Bindings {
  @override
  void dependencies() {
    // Bind the FontSizeController to the widget
    Get.put(FontSizeController());
    
  }
}
