import 'package:TTTMedicine/controllers/account_controller.dart';
import 'package:TTTMedicine/controllers/add_page_controller.dart';
import 'package:TTTMedicine/controllers/chat_controller.dart';
import 'package:TTTMedicine/controllers/pills_controller.dart';
import 'package:get/get.dart';

class RootBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChatController(), fenix: true);
    Get.lazyPut(() => AccountController(), fenix: true);
    Get.lazyPut(() => AddPageController(), fenix: true);
    Get.lazyPut(() => PillsController(),fenix: true);
  }
}