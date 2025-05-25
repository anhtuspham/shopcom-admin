import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_com_admin_web/providers/user_provider.dart';
import 'package:shop_com_admin_web/data/model/user.dart';
import 'package:shop_com_admin_web/screens/user/widget/add_edit_user_dialog.dart';
import 'package:shop_com_admin_web/utils/custom_page_controller.dart';
import 'package:shop_com_admin_web/utils/local_value_key.dart';
import 'package:shop_com_admin_web/utils/widgets/button_widget.dart';
import 'package:shop_com_admin_web/utils/widgets/data_table.dart';
import 'package:shop_com_admin_web/utils/widgets/error_widget.dart';

class UserScreen extends ConsumerStatefulWidget {
  const UserScreen({super.key});

  @override
  ConsumerState<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends ConsumerState<UserScreen> {
  late CustomPageController<User> customPageController =
      CustomPageController<User>(
    data: [],
    dataEmpty: [User.empty()],
    funcCompare: (a, b) => a.name.compareTo(b.name ?? '') ?? 0,
  );
  late CustomDataTable<User> customDataTable;

  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(userProvider);

    customPageController.setData(userState.user);

    customDataTable = CustomDataTable<User>(
      controller: customPageController,
      titleHeader: 'Danh sách người dùng',
      showExtension: (User user) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => showAddEditUserDialog(context, user: user),
          ),
        ],
      ),
      bottomWidget: Row(
        children: [
          CreateButtonWidget(
              callBack: () => showAddEditUserDialog(context),
              tooltip: LocalValueKey.addUser)
        ],
      ),
      refresh: () {
        ref.read(userProvider.notifier).refresh();
      },
      showPagination: true,
      showBottomWidget: true,
      isShowCheckbox: true,
      parent: context,
    );

    // customDataTable.setConfigSize([
    //   200,
    //   200,
    //   200,
    // ]);
    customDataTable.setConfigFilter([
      true,
      true,
      true,
      true,
      true,
      false
    ]);
    customDataTable.setConfigSort([
      true,
      true,
      true,
      true,
      true,
      false
    ]);
    customDataTable.setConfigSearch(
        ['email', 'name', 'address']);

    return Column(
      children: [
        if (userState.isLoading)
          const Expanded(
            child: Center(child: CircularProgressIndicator()),
          )
        else if (userState.isError)
          const Expanded(
            child: ErrorsWidget(),
          )
        else if (userState.user.isEmpty)
          const Expanded(
            child: Center(child: Text('Không có người dùng nào')),
          )
        else
          Expanded(
            child: customDataTable.drawTable(context),
          ),
      ],
    );
  }
}
