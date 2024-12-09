import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class FontSizeController extends GetxController {
  // Store the current font size as an observable variable
  var fontSize = 18.0.obs; // Default is medium (18)

  // Method to update the font size

  double getresponsivefontsize(BuildContext context,
      {required double fontSize}) {
    double getresponsivefontsize = fontSize * scalefactor(context);
    double lowerlimit = fontSize * 0.8;
    double upperlimit = fontSize * 1.5;
    return getresponsivefontsize.clamp(lowerlimit, upperlimit);
  }

  double scalefactor(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    if (width < 600) {
      return width / 700;
    } else if (width < 900 && width > 600) {
      return width / 700;
    } else {
      return width / 1000;
    }
  }

  void updateFontSize(double size, BuildContext context) {
    var finalSize = getresponsivefontsize(context, fontSize: size);

    fontSize.value = finalSize;
  }

  
}



