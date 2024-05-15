import 'package:fluttertoast/fluttertoast.dart';
import 'package:watchit/View/Constant/color_utils.dart';

showToast(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: primaryColor,
      textColor: basicFontColor,
      fontSize: 16.0);
}
