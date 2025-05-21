
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

void showImageDialog(BuildContext context, {required String url, int backstep = 1}) async {
  await showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      final mediaQuery = MediaQuery.of(context);

      double width = mediaQuery.size.width / 1.5;
      if(width < 400) {
        width = 400;
      }
      double height = mediaQuery.size.height / 1.5;
      if(height < 400) {
        height = 400;
      }

      return PopScope(
        canPop: true,
        onPopInvokedWithResult: (didPop, data) {
          // int _count = 0;
          // Navigator.popUntil(context, (route) {
          //   return _count++ == backstep;
          // });
        },
        child: Center(
          child: CachedNetworkImage(
            imageUrl: url,
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        )
      );
    },
  );
}
