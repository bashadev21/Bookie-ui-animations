import 'package:flutter/material.dart';

import 'package:get/get.dart';

class BooksViewController extends GetxController
    with SingleGetTickerProviderMixin {
  final pgcontroller = PageController();
  final notifier = ValueNotifier(0.0);

  void liserner() {
    notifier.value = pgcontroller.page;
  }

  @override
  void onInit() {
    pgcontroller.addListener(liserner);
    super.onInit();
  }

  @override
  void onClose() {
    pgcontroller.removeListener(liserner);
    pgcontroller.dispose();
    super.onClose();
  }
}
