import 'package:housepital/src/constants/colors.dart';
import 'package:toast/toast.dart';

void showToast(String msg, context) {
  Toast.show(msg, context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM,backgroundColor:secondaryColor);
}