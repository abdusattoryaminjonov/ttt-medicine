import 'package:TTTMedicine/controllers/chat_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_parsed_text/flutter_parsed_text.dart';

import '../../models/talk_models/message_model.dart';
import '../../constants/app_colors.dart';


Widget itemOfGeminiMessage(MessageModel message,ChatController controller,BuildContext context){

  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    margin: const EdgeInsets.only(top: 15, bottom: 15),
    child: Container(
      constraints: const BoxConstraints(maxWidth: 300),
      padding:
      const EdgeInsets.only(top: 10, bottom: 10, left: 16, right: 16),
      decoration:  BoxDecoration(
        color: AppColors.appActiveColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(4),
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 30,
                child: Icon(Icons.android,color: AppColors.white100,),
              ),
              GestureDetector(
                onTap: () {
                  controller.speakTTS(message.message!);
                },
                child:  Icon(
                  Icons.volume_up,
                  color: AppColors.white100,
                ),
              )
            ],
          ),
          Container(

              margin: const EdgeInsets.only(top: 15),
              child: ParsedText(
                text:message.message!,
                style:  TextStyle(
                  fontSize: 16,
                  color: AppColors.white100,
                ),
                // parse: <MatchText>[
                //
                //   MatchText(
                //     type: ParsedType.URL,
                //     style: const TextStyle(
                //       color: Colors.white,
                //     ),
                //     onTap: (url) {
                //       //controller.gotoIntranetPage(url,context);
                //     },),
                //   MatchText(
                //     type: ParsedType.CUSTOM,
                //     pattern: r"\*\*(.*?)\*\*",
                //     style: const TextStyle(
                //       fontWeight: FontWeight.bold,
                //       color: Colors.white70,
                //       fontSize: 18,
                //     ),
                //     onTap: (url) {},),
                //   MatchText(
                //     type: ParsedType.CUSTOM,
                //     pattern: r"```dart(.*?) \```",
                //     style: const TextStyle(
                //       fontWeight: FontWeight.w100,
                //       color: Colors.white70,
                //       backgroundColor: Colors.grey,
                //       fontSize: 15,
                //     ),
                //     onTap: (url) {},),
                // ],
              )
          )
        ],
      ),
    ),
  );
}