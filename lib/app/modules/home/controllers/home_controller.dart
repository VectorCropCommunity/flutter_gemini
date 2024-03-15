import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:wa_bot/app/data/chatClass.dart';
import 'package:wa_bot/key.dart';

class HomeController extends GetxController {
  TextEditingController textFieldController = TextEditingController();
  RxBool isGenerating = RxBool(false);
  ScrollController scrollController = ScrollController();

  late List<Chat> messages = <Chat>[].obs;

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

      final content = [Content.text("$prompt [reply in markdown]")];
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
}
