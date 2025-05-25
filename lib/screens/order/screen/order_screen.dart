import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_com_admin_web/providers/order_provider.dart';
import 'package:shop_com_admin_web/data/model/order.dart';
import 'package:shop_com_admin_web/utils/custom_page_controller.dart';
import 'package:shop_com_admin_web/utils/widgets/data_table.dart';
import 'package:shop_com_admin_web/utils/widgets/error_widget.dart';

import '../../../utils/toast.dart';
import '../../../utils/widgets/dialog_confirm.dart';

class OrderScreen extends ConsumerStatefulWidget {
  const OrderScreen({super.key});

  @override
  ConsumerState<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends ConsumerState<OrderScreen> {
  late CustomPageController<Order> customPageController =
  CustomPageController<Order>(
    data: [],
    dataEmpty: [Order.empty()],
    funcCompare: (a, b) => a.id?.compareTo(b.id ?? '') ?? 0,
  );
  late CustomDataTable<Order> customDataTable;

  @override
  Widget build(BuildContext context) {
    final orderState = ref.watch(orderProvider);

    customPageController.setData(orderState.order);

    customDataTable = CustomDataTable<Order>(
      controller: customPageController,
      titleHeader: 'Danh sách người dùng',
      showExtension: (Order order) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: null,
          ),
        ],
      ),
      refresh: () {
        ref.read(orderProvider.notifier).refresh();
      },
      showPagination: true,
      showBottomWidget: true,
      isShowCheckbox: false,
      parent: context,
    );

    return Column(
      children: [
        if (orderState.isLoading)
          const Expanded(
            child: Center(child: CircularProgressIndicator()),
          )
        else if (orderState.isError)
          const Expanded(
            child: ErrorsWidget(),
          )
        else if (orderState.order.isEmpty)
            const Expanded(
              child: Center(child: Text('Không có đơn hàng nào')),
            )
          else
            Expanded(
              child: customDataTable.drawTable(context),
            ),
      ],
    );
  }
}
