import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/auth_service.dart';
import '../widgets/chat_message/generic_dialog.dart';

class AccountController extends GetxController{

  goToChatPage(){
    Get.toNamed('chat_page');
  }


  logOutDialog(BuildContext context) async {
    bool result = await showGenericDialog(
      context: context,
      title: 'Sign Out',
      content: "Do you want to sign out?",
      optionsBuilder: () => {
        'Cancel': false,
        'Confirm': true,
      },
    );
    if (result) {
      await AuthService.signOutFromGoogle();
      callSplashPage(context);
    }
  }
  callSplashPage(BuildContext context) {
    Navigator.pushReplacementNamed(context, 'splash_page');
  }
}