import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';

chatBubble(text) {
  return Container(
      constraints: BoxConstraints(
        maxWidth: Get.width / 1.2,
      ),
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(colors: [
          Get.theme.colorScheme.primary,
          Get.theme.colorScheme.secondary
        ], begin: Alignment.topLeft, end: Alignment.bottomRight),
      ),
      child: Text(
        text,
        textAlign: TextAlign.right,
        style: const TextStyle(
          color: Colors.white,
        ),
      ));
}

chatBubbleReciever(text) {
  return Container(
    constraints: BoxConstraints(maxWidth: Get.width / 1.2),
    margin: const EdgeInsets.all(5),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Get.theme.colorScheme.tertiary),
    child: MarkdownBody(
      data: text,
      imageBuilder: (uri, title, alt) {
        print(uri.toString());
        return CachedNetworkImage(imageUrl: uri.toString());
      },
      selectable: true,
      onTapLink: (text, href, title) {},
    ),
  );
}

chatBubbleShrimmer() {
  return Container(
    constraints: BoxConstraints(
        maxWidth: Get.width / 1.2, minWidth: Get.width / 15, minHeight: 50),
    margin: const EdgeInsets.all(5),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Get.theme.colorScheme.tertiary),
  );
}
