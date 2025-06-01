import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../data/config/app_config.dart';
import '../../../utils/color_value_key.dart';
import '../../../utils/local_value_key.dart';

class AccountButton extends StatelessWidget {
  const AccountButton({super.key});

  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
      style: MenuStyle(
        backgroundColor: WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
          return ColorValueKey.mainColor;
        }),
      ),
      builder: (context, controller, child) {
        return SizedBox(
          child: TextButton.icon(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              controller.open();
            },
            style: TextButton.styleFrom(
              foregroundColor: ColorValueKey.accountColor,
            ),
            label: Text(
              app_config.user?.name ?? "",
              textWidthBasis: TextWidthBasis.parent,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.bold,
                color: ColorValueKey.accountColor,
              ),
            ),
          ),
        );
      },
      menuChildren: [
        MenuItemButton(
          child: Text(
            LocalValueKey.logout,
            style: TextStyle(
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          onPressed: () {
            // app_config.clearStaff();
            Future.delayed(const Duration(milliseconds: 100), () {
              if(context.mounted)
                {
                  context.go('/auth');
                }
            });
            // List<CfgRequest>? tmp = await app.api.getListConfigRequest(user!.token);
            // userController.logout().then((value) {
            //   Future.delayed(const Duration(milliseconds: 100), () {
            //     context.goNamed("login");
            //   });
            // });
          },
        ),
      ],
    );
  }
}
