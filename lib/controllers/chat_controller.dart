import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../domain/usecases/gemini_text_and_image_usecase.dart';
import '../domain/usecases/gemini_text_only_usecase.dart';
import '../models/talk_models/message_model.dart';
import '../repositories/gemini_talk_repository_impl.dart';
import '../services/chat_data.dart';
import '../services/log_service.dart';
import '../services/utils_service.dart';

class ChatController extends GetxController{
  GeminiTextOnlyUseCase textOnlyUseCase =
  GeminiTextOnlyUseCase(GeminiTalkRepositoryImpl());
  GeminiTextAndImageUseCase textAndImageUseCase =
  GeminiTextAndImageUseCase(GeminiTalkRepositoryImpl());

  TextEditingController textController = TextEditingController();
  final FocusNode textFieldFocusNode = FocusNode();

  String? pickedImage;

  List<MessageModel> messages = [];
  SpeechToText speechToText = SpeechToText();
  bool speechEnabled = false;
  FlutterTts flutterTts = FlutterTts();


  bool isLoading = false;

  goToAccountPage(){
    Get.back();
  }

  @override
  void onClose() {
    textController.dispose(); // Dispose properly when controller is removed
    super.onClose();
  }

  uploadData(){
    var data = ChatNoSqlService.fetchNoSqlCard();
    messages = data;
    update();
  }

  apiTextOnly(String text) async {
    var either = await textOnlyUseCase.call(text);
    either.fold((l) {
      updateMessages(MessageModel(isMine: false, message: l),false);
    }, (r) async {
      updateMessages(MessageModel(isMine: false, message: r),false);
    });
  }

  apiTextAndImage(String text, String base64) async {
    var either = await textAndImageUseCase.call(text, base64);
    either.fold((l) {
      updateMessages(MessageModel(isMine: false, message: l),false);
    }, (r) async {
      updateMessages(MessageModel(isMine: false, message: r),false);
    });
  }

  updateMessages(MessageModel messageModel,bool isLoading) {
    this.isLoading = isLoading;
    messages.add(messageModel);
    update();

    ChatNoSqlService.saveNoSqlDB(messageModel);
  }


  onSendPressed(String text) async {
    if (pickedImage == null) {
      apiTextOnly(text);
      updateMessages(MessageModel(isMine: true, message: text),true);
    } else {
      apiTextAndImage(text, pickedImage!);
      updateMessages(
          MessageModel(isMine: true, message: text, base64: pickedImage),true);
    }
    textController.clear();
    onRemovedImage();
  }

  onSelectedImage() async {
    var base64 = await Utils.pickAndConvertImage();
    if (base64.trim().isNotEmpty) {
      pickedImage = base64;
      LogService.i(base64);
      update();
    }
  }

  onRemovedImage() {
    pickedImage = null;
    update();
  }

  /// Speech to Text
  void initSTT() async {
    speechEnabled = await speechToText.initialize();
    update();
  }

  void startSTT() async {
    await speechToText.listen(onResult: onSTTResult);
    update();
  }

  void stopSTT() async {
    await speechToText.stop();
    update();
  }

  void onSTTResult(SpeechRecognitionResult result) {
    if (result.finalResult) {
      var words = result.recognizedWords;
      onSendPressed(words);
      LogService.i(words);
    }
  }

  Future speakTTS(String text) async{
    var result = await flutterTts.speak(text);
    // if (result == 1) setState(() => ttsState = TtsState.playing);
  }

  Future stopTTS() async{
    var result = await flutterTts.stop();
    // if (result == 1) setState(() => ttsState = TtsState.stopped);
  }

  Future<void> _setAwaitOptions() async {
    await flutterTts.awaitSpeakCompletion(true);
  }
}