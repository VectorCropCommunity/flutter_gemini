import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:wa_bot/app/data/chatClass.dart';
import 'package:wa_bot/key.dart';

class HomeController extends GetxController {
  TextEditingController textFieldController = TextEditingController();
  RxBool isGenerating = RxBool(false);
  ScrollController scrollController = ScrollController();
  String apiKey = geminiApi;
  FlutterTts tts = FlutterTts();

  late List<Chat> messages = <Chat>[].obs;

  @override
  void onInit() {
    resetChat();
    tts.setLanguage('en-US');
    tts.setPitch(0.9);
    tts.setSpeechRate(0.5);
    super.onInit();
  }

  @override
  void onClose() {
    tts.stop();
    super.onClose();
  }

  ttsFun() {}

  @override
  void onReady() {
    window.onKeyData = (final keyData) {
      if (keyData.logical == LogicalKeyboardKey.enter.keyId) {
        textFieldController.text.isNotEmpty
            ? generate(textFieldController.text)
            : null;
        return true;
      }

      return false;
    };
    super.onReady();
  }

  void generate(prompt) async {
    prompt = prompt.toString().trim();
    textFieldController.clear();
    if (prompt != '') {
      goToBottom();
      messages
          .add(Chat(text: "$prompt", date: DateTime.now(), isSentByMe: true));

      isGenerating.value = true;

      final model = GenerativeModel(
        model: 'gemini-pro',
        apiKey: geminiApi,
      );

      final content = [Content.text("$prompt")];
      try {
        await model.generateContent(content).then((value) {
          addToChat(value.text.toString());
          isGenerating.value = false;
          goToBottom();
        });
      } on Exception catch (e) {
        print(e);
        Get.showSnackbar(GetSnackBar(
          title: "Error",
          backgroundColor: Get.theme.colorScheme.error,
          message: "$e",
        ));
        isGenerating.value = false;
      }
    }
  }

  addToChat(text) {
    messages.add(Chat(text: text, date: DateTime.now(), isSentByMe: false));
  }

  goToBottom() {
    scrollController.animateTo(scrollController.position.maxScrollExtent + 100,
        duration: const Duration(milliseconds: 500), curve: Curves.linear);
  }

  resetChat() {
    messages.clear();
  }

  toSpeech(text) {
    tts.speak(text);
  }

  stopSpeech() {}

  // chat(prompt) async {
  //   prompt = prompt.toString().trim();

  //   if (prompt.toString().isNotEmpty) {
  //     messages
  //         .add(Chat(text: "$prompt", date: DateTime.now(), isSentByMe: true));
  //     isGenerating.value = true;
  //     textFieldController.clear();
  //     goToBottom();

  // For text-only input, use the gemini-pro model
  //     final model = GenerativeModel(
  //       model: 'gemini-pro',
  //       apiKey: apiKey,
  //       generationConfig: GenerationConfig(maxOutputTokens: 100),
  //     );
  //     // Initialize the chat
  //     final chat = model.startChat(
  //       history: [
  //         Content.text("Hi"),
  //         Content.model(
  //           [TextPart('Great to meet you. What would you like to know?')],
  //         )
  //       ],
  //     );
  //     var content = Content.text('$prompt');

  //     try {
  //       await chat.sendMessage(content).then(
  //         (value) {
  //           addToChat(value.text.toString());
  //           isGenerating.value = false;
  //           goToBottom();
  //         },
  //       );
  //     } on Exception catch (e) {
  //       print(e);
  //       Get.showSnackbar(GetSnackBar(
  //         title: "Error",
  //         backgroundColor: Get.theme.colorScheme.error,
  //         message: "$e",
  //       ));
  //       isGenerating.value = false;
  //     }
  //   }
  // }
}
