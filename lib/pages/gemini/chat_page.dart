import 'package:TTTMedicine/controllers/chat_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shake/shake.dart';
import '../../constants/app_colors.dart';


import '../../constants/text.dart';
import '../../services/utils_service.dart';
import '../../widgets/chat_message/item_gemini_message.dart';
import '../../widgets/chat_message/item_user_message.dart';

class ChatPage extends StatefulWidget {
  static const String id = 'chat_page';

  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final controller = Get.find<ChatController>();

  @override
  void initState() {
    super.initState();
    controller.initSTT();
    controller.uploadData();

    ShakeDetector.autoStart(
      onPhoneShake: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            width: 200,
            content:  const Center(child: Text(shakeMessage)),
            behavior: SnackBarBehavior.floating, // Optional: positions SnackBar above the bottom
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            backgroundColor: Colors.black12,
          ),

        );
        controller.speakTTS(shakeMessage);
      },
      minimumShakeCount: 1,
      shakeSlopTimeMS: 500,
      shakeCountResetTime: 3000,
      shakeThresholdGravity: 2.7,
    );
  }

  @override
  void dispose() {
    // controller.textController.dispose();
    // controller.textFieldFocusNode.dispose();
    super.dispose();
}

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("TTT-Chat",style: TextStyle(
            color: AppColors.appActiveColor,
          ),),
            leading:IconButton(
              icon: Icon(Icons.arrow_back_outlined,color: AppColors.appActiveColor),
              onPressed: (){
                controller.goToAccountPage();
              },
            )
        ),
        body: GetBuilder<ChatController>(
          builder: (_) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Container(
                    child: controller.messages.isEmpty
                        ? Center(
                      child: SizedBox(
                        width: 100,
                              child: Lottie.asset('assets/lotties/loading_puls.json'),
                      ),
                    )
                        : ListView.builder(
                      itemCount: controller.messages.length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        var message =
                        controller.messages[index];
                        if (message.isMine!) {
                          return itemOfUserMessage(message);
                        } else {
                          return itemOfGeminiMessage(message, controller,context);
                        }
                      },
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 20, left: 20),
                  padding: const EdgeInsets.only(left: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: Colors.grey, width: 1.5),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      controller.pickedImage == null
                          ? const SizedBox.shrink()
                          : Container(
                        margin: const EdgeInsets.only(top: 15),
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          // color: Colors.blue,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.white),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.memory(
                            Utils.base64Decode(
                                controller.pickedImage!
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: controller.textController,
                              maxLines: null,
                              style:  TextStyle(color: AppColors.purple),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Message',
                                hintStyle: TextStyle(color: Colors.black12),
                              ),
                            ),
                          ),
                          IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              controller.onSelectedImage();
                            },
                            icon:  Icon(
                              Icons.add_photo_alternate_outlined,
                              color: AppColors.purple,
                            ),
                          ),
                          IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              controller.speechToText.isNotListening
                                  ? controller.startSTT()
                                  : controller.stopSTT();
                            },
                            icon:  Icon(
                              Icons.mic,
                              color: AppColors.purple,
                            ),
                          ),
                          IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              var text = controller.textController.text
                                  .toString()
                                  .trim();
                              controller.onSendPressed(text);
                            },
                            icon:  Icon(
                              Icons.send,
                              color: AppColors.purple,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );

  }
}
