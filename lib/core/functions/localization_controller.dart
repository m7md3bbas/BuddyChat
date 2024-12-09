import 'dart:collection';

import 'package:TaklyAPP/core/functions/localization_service.dart';
import 'package:get/get.dart';

class LocalizationController extends GetxController {
  var selectedValue = "en".obs;
  List<HashMap<String, String>> items = [
    HashMap.from({"key": "en", "value": "English"}),
    HashMap.from({"key": "ar", "value": "Arabic"}),
    HashMap.from({"key": "fr", "value": "French"}),
  ];

  @override
  void onInit() {
    super.onInit();
    selectedValue.value = LocalizationService.defaultLocale.languageCode;
    if (!items.any((item) => item['key'] == selectedValue.value)) {}
  }

  void setSelected(String value) {
    if (items.any((item) => item['key'] == value)) {
      selectedValue.value = value;
      LocalizationService.updateLocale(value);
    }
  }
}
