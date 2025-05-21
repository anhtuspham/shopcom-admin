import 'package:flutter/material.dart';
import '../color_value_key.dart';
import 'text_button.dart';
import 'title_header_dialog.dart';

Future<bool> showConfirmDialog(
    BuildContext context, {
      Function()? on_confirm,
      Function()? on_close,
      String? title,
    }) async {
  bool? flag = await showDialog<bool>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return BodyDialogConfirm(
        title: title,
        on_confirm: on_confirm,
        on_close: on_close,
      );
    },
  );
  return flag ?? false;
}

class BodyDialogConfirm extends StatelessWidget {
  final String? title;

  final Function()? on_confirm;
  final Function()? on_close;

  const BodyDialogConfirm(
      {super.key, required this.title, this.on_confirm, this.on_close});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AlertDialog(
      backgroundColor: ColorValueKey.backgroundColor,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: TitleHeaderDialog(title: 'Thông báo')),
            ],
          ),
          const SizedBox(height: 10,),
          Text(
            title ?? 'Xác nhận rời trang',
            style: TextStyle(
              fontSize: 16.0,
              color: ColorValueKey.textColor,
            ),
          ),
        ],
      ),
      actions: <Widget>[
        TextButtonWidget(
            child: Text(
              'Hủy',
              style: const TextStyle(
                // color: ColorValueKey.textColor,
                // fontWeight: FontWeight.w600,
              ),
            ),
            onPressed: () {
              if (on_close != null) {
                on_close!();
              }
              // Navigator.of(context).pop();
              Navigator.pop(context, false);
            }),
        TextButtonWidget(
          child: Text(
            'Xác nhận',
            style: const TextStyle(
              // color: ColorValueKey.textColor,
              // fontWeight: FontWeight.w600,
            ),
          ),
          onPressed: () {
            if (on_confirm != null) {
              on_confirm!();
            }
            Navigator.pop(context, true);
          },
        ),
      ],
    );
  }
}