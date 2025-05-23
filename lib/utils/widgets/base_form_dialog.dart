import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_com_admin_web/utils/widgets/text_button.dart';

import '../color_value_key.dart';
import '../local_value_key.dart';
import 'dialog_confirm.dart';


class BaseFormDialog extends ConsumerStatefulWidget {
  final List<Widget> inputs;
  final String title;
  final void Function()? onCancelPressed;
  final double? width;
  final Widget? actions;
  final void Function(
    GlobalKey<FormState> formKey,
    void Function(bool loading) setLoading,
  ) onSubmit;
  const BaseFormDialog({
    super.key,
    this.inputs = const [],
    required this.onSubmit,
    required this.title,
    this.onCancelPressed,
    this.width,
    this.actions,
  });

  @override
  ConsumerState<BaseFormDialog> createState() => _BaseFormDialogState();
}

class _BaseFormDialogState extends ConsumerState<BaseFormDialog> {
  final _formKey = GlobalKey<FormState>();
  final _loadingNotifier = ValueNotifier(false);

  @override
  void dispose() {
    _loadingNotifier.dispose();
    super.dispose();
  }

  void setLoading(bool isLoading) {
    _loadingNotifier.value = isLoading;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, Object? result) async {
        if (didPop) {
          return;
        }
        final bool shouldPop = await showConfirmDialog(context) ;
        if (context.mounted && shouldPop) {
          context.pop();
        }
      },
      child: AlertDialog(
        backgroundColor: ColorValueKey.backgroundColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.title,
              style: TextStyle(color: ColorValueKey.textColor),
            ),
            const SizedBox(width: 10),
            CloseButton(
              color: Colors.white,
              style: IconButton.styleFrom(
                backgroundColor: Colors.blueGrey,
              ),
              onPressed: () async {
                final bool shouldPop =await showConfirmDialog(context) ;
                if (context.mounted && shouldPop) {
                  context.pop();
                }
              },
            ),
          ],
        ),
        content: SizedBox(
          width: widget.width ?? 300,
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: widget.inputs,
              ),
            ),
          ),
        ),
        actions: [
          widget.actions ?? const Offstage(),
          TextButtonWidget(
            onPressed: widget.onCancelPressed ??
                () async {
                  final bool shouldPop =
                      await  showConfirmDialog(context) ;
                  if (context.mounted && shouldPop) {
                    context.pop();
                  }
                },
            child: Text(
              LocalValueKey.cancel,
            ),
          ),
          ValueListenableBuilder(
            valueListenable: _loadingNotifier,
            builder: (context, isLoading, _) {
              return TextButtonWidget(
                onPressed: isLoading
                    ? null
                    : () {
                        widget.onSubmit(
                          _formKey,
                          setLoading,
                        );
                      },
                child: isLoading
                    ? const CircularProgressIndicator()
                    : Text(
                        LocalValueKey.confirm,
                      ),
              );
            },
          ),
        ],
      ),
    );
  }
}
