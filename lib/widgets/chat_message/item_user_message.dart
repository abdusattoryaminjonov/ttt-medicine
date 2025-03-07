import 'package:TTTMedicine/constants/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/talk_models/message_model.dart';
import '../../services/utils_service.dart';

Widget itemOfUserMessage(MessageModel message) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      Container(
        margin: EdgeInsets.only(top: 10),
        constraints: const BoxConstraints(maxWidth: 300),
        padding:
        const EdgeInsets.only(top: 10, bottom: 10, left: 16, right: 16),
        decoration:  BoxDecoration(
          color: AppColors.purple,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25),
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
            topRight: Radius.circular(4),
          ),
        ),
        child: Expanded(
          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                message.message!,
                style:  TextStyle(
                  color: AppColors.white100,
                  fontSize: 16,
                ),
              ),
              (message.base64 != null && message.base64!.isNotEmpty)
                  ? Container(
                margin: const EdgeInsets.only(top: 16, bottom: 6),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.memory(
                    Utils.base64Decode(message.base64!),
                  ),
                ),
              )
                  : const SizedBox.shrink(),
              // Container(
              //   child: Image.memory(
              //       Utils.base64Decode(base64Image),
              //       width: 200,
              //       fit: BoxFit.fitWidth,
              //   ),
              // )
            ],
          ),
        ),
      ),
    ],
  );
}