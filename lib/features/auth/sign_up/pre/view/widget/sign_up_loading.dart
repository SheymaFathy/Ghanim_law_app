import 'package:flutter_easyloading/flutter_easyloading.dart';

void signUpLoadingWidget() async {
  await EasyLoading.show(
      status: 'loading...', maskType: EasyLoadingMaskType.black);
}
