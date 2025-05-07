import 'package:flutter/material.dart';

import 'button_widget.dart';

class ErrorsWidget extends StatelessWidget {
  final String? titleError;
  // final void Function()? onPressed;
  const ErrorsWidget({super.key,this.titleError,});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        titleError ?? 'Không có dữ liệu',
        style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.red),
      ),
    );
    /*   return  Column(
      children: [
        Expanded(
          child: Center(
            child: Text(
              titleError ?? LocalValueKey.noData,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.red),
            ),
          )
        ),
        Divider(height: 1, thickness: 1, color: ColorValueKey.dividerColor),
        if(onPressed != null)
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              RefreshButtonWidget(
                onPressed: onPressed,
              ),
            ],
          ),
        ),
      ],
    );
    return Center(
      child: Text(
        titleError ?? LocalValueKey.noData,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.red),
      ),
    );*/
  }
}
