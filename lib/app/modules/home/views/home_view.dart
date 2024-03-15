import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hidable/hidable.dart';
import 'package:wa_bot/app/data/widget.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Hidable(
        controller: controller.scrollController,
        child: AppBar(
          actions: [
            Container(
              margin: const EdgeInsets.all(5),
              child: Obx(
                () => controller.isGenerating.value
                    ? const CircularProgressIndicator.adaptive()
                    : IconButton(
                        onPressed: () {
                          controller.resetChat();
                        },
                        icon: const Icon(Icons.add),
                        splashColor: Colors.transparent,
                        splashRadius: 0.1,
                      ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        width: Get.width,
        margin: const EdgeInsets.all(10),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: Get.width / 1.2,
                child: TextField(
                  controller: controller.textFieldController,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(16),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none),
                    filled: true,
                  ),
                ),
              ),
              const Spacer(),
              Obx(() => controller.isGenerating.value
                  ? const IconButton(
                      onPressed: null,
                      icon: CircularProgressIndicator.adaptive())
                  : IconButton(
                      onPressed: () {
                        if (controller.textFieldController.value.text != " ") {
                          controller.generate(
                              controller.textFieldController.value.text);
                        }
                      },
                      icon: const Icon(Icons.send),
                      splashRadius: 0.1,
                    ))
            ]),
      ),
      body: Center(
        child: Column(
          //chat screen
          children: [
            Expanded(
                child: Obx(
              () => ListView.custom(
                controller: controller.scrollController,
                physics: const ClampingScrollPhysics(),
                childrenDelegate: SliverChildBuilderDelegate(
                    childCount: controller.messages.length, (context, index) {
                  return Obx(() => controller.messages[index].isSentByMe
                      ? Align(
                          alignment: Alignment.centerRight,
                          child: chatBubble(controller.messages[index].text),
                        )
                      : Align(
                          alignment: Alignment.centerLeft,
                          child: chatBubbleReciever(
                              controller.messages[index].text),
                        ));
                }),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
