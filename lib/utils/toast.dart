import 'package:elegant_notification/elegant_notification.dart';
import 'package:elegant_notification/resources/stacked_options.dart';
import 'package:flutter/material.dart';

void showSuccessToastWithUI({String? title, required String description, required BuildContext context, Offset? offset}) {
  if (context.mounted) {
    ElegantNotification.success(
      width: 300,
      height: 100,
      border: Border.all(),
      position: Alignment.bottomRight,
      // stackedOptions: StackedOptions(
      //   key: 'above',
      //   type: StackedType.above,
      //   itemOffset: offset ?? Offset(0, 0),
      // ),
      description: Text(
        style: const TextStyle(
          color: Colors.black,
        ),
        description,
      ),
      title: Text(
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        title ?? 'Notification',
      ),
    ).show(context);
  }
}

void showFailureToastWithUI({String? title, required String description, required BuildContext context, Offset? offset}) {
  if (context.mounted) {
    ElegantNotification.error(
      width: 300,
      height: 100,
      border: Border.all(),
      position: Alignment.bottomRight,
      // stackedOptions: StackedOptions(
      //   key: 'above',
      //   type: StackedType.above,
      //   itemOffset: offset ?? Offset(0, 0),
      // ),
      description: Text(
        style: const TextStyle(
          color: Colors.black,
        ),
        description,
      ),
      title: Text(
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        title ?? 'Notification',
      ),
    ).show(context);
  }
}

void showResultToastWithUI({String? title, required String description, required BuildContext context, Offset? offset, required bool result}) {
  if (context.mounted) {
    if (result) {
      showSuccessToastWithUI(description: description, context: context, title: title, offset: offset);
    } else {
      showFailureToastWithUI(description: description, context: context, title: title, offset: offset);
    }
  }
}
