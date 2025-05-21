import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_com_admin_web/utils/screen_size_checker.dart';
import 'package:shop_com_admin_web/utils/widgets/text_button.dart';
import 'package:shop_com_admin_web/utils/widgets/title_header_dialog.dart';

import 'widgets/dialog_confirm.dart';
import 'color_value_key.dart';

extension ContextExtension on BuildContext {
  void showCommonDialog(Widget child, {double? width, double? height, String title = '', bool barrierDismissible = true,bool allowNullWidth = false}) {
    showDialog(
      context: this,
      barrierDismissible: barrierDismissible,
      builder: (context) => PopScope(
        canPop: false,
        onPopInvokedWithResult: (bool didPop, Object? result) async {
          if (didPop) {
            return;
          }
          final bool shouldPop = await showConfirmDialog(context);
          if (context.mounted && shouldPop) {
            context.pop();
          }
        },
        child: Dialog(
          backgroundColor: ColorValueKey.backgroundColor,
          clipBehavior: Clip.antiAlias,
          insetPadding: ScreenSizeChecker.isDesktop(context)? null: EdgeInsets.zero,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
          child: SizedBox(
            width: width ?? double.infinity,
            height: allowNullWidth ==true ? null : height ?? double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 8, right: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: TitleHeaderDialog(title: title)),
                      if(barrierDismissible == true)
                      CloseButton(
                        color: Colors.white,
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.blueGrey,
                        ),
                        onPressed: () async {
                          final bool shouldPop = await showConfirmDialog(context);
                          if (context.mounted && shouldPop) {
                            context.pop();
                          }
                        },
                      ),
                    ],
                  ),
                ),
                child,
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showTopDialog(Widget child, {double? width, double? height, String title = ''}) {
    showGeneralDialog(
      context: this,
      barrierLabel: "",
      barrierDismissible: true,
      pageBuilder: (_, __, ___) {
        return const Offstage();
      },
      transitionBuilder: (context, a1, a2, _) {
        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (bool didPop, Object? result) async {
            if (didPop) {
              return;
            }
            final bool shouldPop = await showConfirmDialog(this);
            if (mounted && shouldPop) {
              context.pop();
            }
          },
          child: Align(
            alignment: Alignment.topCenter,
            child: Material(
              child: Container(
                clipBehavior: Clip.antiAlias,
                decoration:  BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: ColorValueKey.backgroundColor,
                ),

                width: width ?? double.infinity,
                height: height ?? double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, left: 8, right: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child: TitleHeaderDialog(title: title)),
                          CloseButton(
                            color: Colors.white,
                            style: IconButton.styleFrom(
                              backgroundColor: Colors.blueGrey,
                            ),
                            onPressed: () async {
                              final bool shouldPop = await showConfirmDialog(context);
                              if (context.mounted && shouldPop) {
                                context.pop();
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    child,
                  ],
                ),
              ),
            ),
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 10),
    );
  }

  String get currentRoute => GoRouterState.of(this).uri.path;

  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => Theme.of(this).textTheme;
}

class BaseSelectDialog extends StatelessWidget {
  final Widget? title;
  final Widget? content;
  final VoidCallback? onConfirm;

  const BaseSelectDialog({
    super.key,
    this.title,
    this.content,
    this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, Object? result) async {
        if (didPop) {
          return;
        }
        final bool shouldPop = await showConfirmDialog(context);
        if (context.mounted && shouldPop) {
          context.pop();
        }
      },
      child: AlertDialog(
        title: title,
        content: content,
        actions: [
          TextButtonWidget(
            child: Text('Hủy'),
            onPressed: () async {
              final shouldPop = await showConfirmDialog(context);
              if (shouldPop && context.mounted) {
                context.pop();
              }
            },
          ),
          TextButtonWidget(
            onPressed: onConfirm,
            child: Text('Xác nhận'),
          ),
        ],
      ),
    );
  }
}
