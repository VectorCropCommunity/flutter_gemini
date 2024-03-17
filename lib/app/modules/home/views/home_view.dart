import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
          centerTitle: true,
          title: Image(
            image: AssetImage(
              "./assets/gemini.png",
            ),
            width: Get.width / 5,
          ),
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
      extendBody: true,
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(10),
        height: Get.height / 7.75,
        width: Get.width,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.black, Colors.transparent],
                begin: Alignment.bottomCenter,
                end: Alignment(0, -2.5))),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Get.theme.inputDecorationTheme.fillColor,
                  borderRadius: BorderRadius.circular(20)),
              width: Get.width,
              // padding: EdgeInsets.only(right: 10),
              // margin: const EdgeInsets.all(10),
              child: Row(children: [
                Expanded(
                  child: TextField(
                    controller: controller.textFieldController,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(16),
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                    ),
                  ),
                ),
                Obx(() => controller.isGenerating.value
                    ? const IconButton(
                        onPressed: null,
                        icon: CircularProgressIndicator.adaptive())
                    : IconButton(
                        onPressed: () {
                          if (controller.textFieldController.value.text !=
                              " ") {
                            // controller.generate(
                            //     controller.textFieldController.value.text);
                            controller.generate(
                                controller.textFieldController.value.text);
                          }
                        },
                        icon: const Icon(Icons.send),
                        splashRadius: 0.1,
                      ))
              ]),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'This ai will display inaccurate into, including about people, so double check its responses.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 10),
            )
          ],
        ),
      ),
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView.custom(
            controller: controller.scrollController,
            physics: const ClampingScrollPhysics(),
            childrenDelegate: SliverChildBuilderDelegate(
                childCount: controller.messages.length, (context, index) {
              return Obx(
                () => controller.messages[index].isSentByMe
                    ? chatBubble(controller.messages[index].text)
                    : chatBubbleReciever(controller.messages[index].text),
              );
            }),
          ),
        ),
      ),
    );
  }
}
