import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:intl/intl.dart';

class GlobalMethods {
  static String formattedDateText(String publishedAt) {
    final parsedDate = DateTime.parse(publishedAt);
    String formattedDate = DateFormat("yyyy-MM-dd hh:mm:ss").format(parsedDate);
    DateTime publishedDate =
        DateFormat("yyyy-MM-dd hh:mm:ss").parse(formattedDate);
    return "${publishedDate.day}/${publishedDate.month}/${publishedDate.year} ON ${publishedDate.hour}:${publishedDate.minute}";
  }

  static Future<void> errorDialog(
      {required String errorMessage, required BuildContext context}) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text('Xảy ra lỗi'),
            title: const Row(
              children: [
                Icon(
                  IconlyBold.danger,
                  color: Colors.red,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "Lỗi",
                  style: TextStyle(color: Colors.red),
                ),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                  },
                  child: Text(
                    'Thoát',
                    style: TextStyle(color: Colors.cyan, fontSize: 18),
                  ))
            ],
          );
        });
  }
}
