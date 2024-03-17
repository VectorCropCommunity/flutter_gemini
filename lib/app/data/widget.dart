import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';
import 'package:wa_bot/app/modules/home/controllers/home_controller.dart';

chatBubble(text) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(Icons.person),
          TextButton(
            onPressed: () {},
            child: Icon(
              Icons.edit_outlined,
              color: Get.theme.iconTheme.color,
            ),
          ),
        ],
      ),
      const SizedBox(
        height: 10,
      ),
      Text(text),
      const SizedBox(
        height: 20,
      )
    ],
  );
}

chatBubbleReciever(text) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const ImageIcon(
            AssetImage("assets/bard.png"),
          ),
          TextButton(
            onPressed: () {
              HomeController().toSpeech(text);
            },
            child: Icon(Icons.volume_up, color: Get.theme.iconTheme.color),
          ),
        ],
      ),
      const SizedBox(
        height: 10,
      ),
      MarkdownBody(
        data: text,
        imageBuilder: (uri, title, alt) {
          print(uri.toString());
          return CachedNetworkImage(imageUrl: uri.toString());
        },
        styleSheet: MarkdownStyleSheet(),
        shrinkWrap: true,
        softLineBreak: true,
        checkboxBuilder: (value) {
          if (value == null || value == false) {
            return const SizedBox();
          } else {
            return const Icon(Icons.check_circle);
          }
        },
        fitContent: true,
        selectable: true,
        onTapLink: (text, href, title) {},
      ),
      const SizedBox(
        height: 20,
      )
    ],
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

// chatBubbleReciever(text) {
//   return Container(
//     constraints: BoxConstraints(maxWidth: Get.width / 1.2),
//     margin: const EdgeInsets.all(5),

//     // decoration: BoxDecoration(
//     //     borderRadius: BorderRadius.circular(10),
//     //     color: Get.theme.colorScheme.tertiary),
//     child: MarkdownBody(
//       data: text,
//       imageBuilder: (uri, title, alt) {
//         print(uri.toString());
//         return CachedNetworkImage(imageUrl: uri.toString());
//       },
//       styleSheet: MarkdownStyleSheet(),
//       shrinkWrap: true,
//       softLineBreak: true,
//       checkboxBuilder: (value) {
//         if (value == null || value == false) {
//           return const SizedBox();
//         } else {
//           return const Icon(Icons.check_circle);
//         }
//       },
//       fitContent: true,
//       selectable: true,
//       onTapLink: (text, href, title) {},
//     ),
//   );
// }



// chatBubble(text) {
//   return Container(
//     padding: const EdgeInsets.all(10),
//     child: Row(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       mainAxisAlignment: MainAxisAlignment.end,
//       children: [
//         Container(
//           constraints: BoxConstraints(
//             maxWidth: Get.width / 1.2,
//           ),
//           margin: const EdgeInsets.only(right: 5),
//           // padding: const EdgeInsets.all(10),
//           // decoration: BoxDecoration(
//           //   borderRadius: BorderRadius.circular(10),
//           //   gradient: LinearGradient(colors: [
//           //     Get.theme.colorScheme.primary,
//           //     Get.theme.colorScheme.secondary
//           //   ], begin: Alignment.topLeft, end: Alignment.bottomRight),
//           // ),
//           child: Text(
//             text,
//             textAlign: TextAlign.right,
//             style: const TextStyle(
//                 // color: Colors.white,
//                 ),
//           ),
//         ),
//         const SizedBox(
//           width: 5,
//         ),
//         CircleAvatar(
//           radius: 16,
//           child: Icon(
//             Icons.person_2_outlined,
//             color: Get.theme.iconTheme.color,
//           ),
//         )
//       ],
//     ),
//   );
// }