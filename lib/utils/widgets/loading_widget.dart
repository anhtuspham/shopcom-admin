import 'package:flutter/material.dart';

import 'button_widget.dart';

class LoadingWidget extends StatelessWidget {
  // final void Function()? onPressed;

  const LoadingWidget({super.key,});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RepaintBoundary(
        child: CircularProgressIndicator(),
      ),
    );
    // return Column(
    //   children: [
    //     const Expanded(
    //       child: Center(
    //         child: RepaintBoundary(
    //           child: CircularProgressIndicator(),
    //         ),
    //       ),
    //     ),
    //     Divider(
    //       height: 1,
    //       thickness: 1,
    //       color: ColorValueKey.dividerColor,
    //     ),
    //     if(onPressed != null)
    //     Padding(
    //       padding: const EdgeInsets.all(5.0),
    //       child: Row(
    //         mainAxisAlignment: MainAxisAlignment.end,
    //         children: [
    //           RefreshButtonWidget(
    //             onPressed: onPressed,
    //           ),
    //         ],
    //       ),
    //     ),
    //   ],
    // );
  }
}
