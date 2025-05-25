import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_com_admin_web/providers/order_provider.dart';

import '../../../../data/model/order.dart';
import '../../../utils/color_value_key.dart';
import '../../../utils/local_value_key.dart';
import '../../../utils/toast.dart';
import '../../../utils/widgets/base_form_dialog.dart';
import '../../../utils/widgets/data_table.dart';
import '../../../utils/widgets/dropdown_form.dart';
import '../../../utils/widgets/input_form_widget.dart';

class AddEditOrderDialog extends ConsumerStatefulWidget {
  final Order? order;
  final CustomDataTable? customDataTable;

  const AddEditOrderDialog({super.key, this.order, this.customDataTable});

  @override
  ConsumerState<AddEditOrderDialog> createState() => _AddEditOrderDialogState();
}

class _AddEditOrderDialogState extends ConsumerState<AddEditOrderDialog> {
  String status = '';

  @override
  Widget build(BuildContext context) {
    return BaseFormDialog(
      title: LocalValueKey.editOrder,
      inputs: [
        const SizedBox(
          height: 8,
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: DropdownForm(
            enabled: true,
            value: Item(
                code: widget.order?.status ?? '',
                name: widget.order?.status ?? ''),
            onSaved: (v) {
              status = v.code;
            },
            items: [
              Item(code: 'pending', name: 'Pending'),
              Item(code: 'processing', name: 'Processing'),
              Item(code: 'delivered', name: 'Delivered'),
              Item(code: 'cancelled', name: 'Cancelled'),
            ],
          ),
        )
      ],
      onSubmit: (formKey, setLoading) async {
        if (!formKey.currentState!.validate()) return;
        formKey.currentState!.save();
        setLoading(true);
        final result = await ref
            .read(orderProvider.notifier)
            .updateOrderStatus(orderId: widget.order?.id ?? '', status: status);
        setLoading(false);
        if (!context.mounted) return;
        final content = result == true
            ? LocalValueKey.updateSuccessOrder
            : LocalValueKey.updateFailOrder;
        showResultToastWithUI(
          description: content ?? "",
          context: context,
          result: result,
        );
        if (result) {
          widget.customDataTable?.controller.clearSelected();
          context.pop();
        }
      },
    );
  }
}

void showAddEditOrderDialog(BuildContext context,
    {Order? order, CustomDataTable? customDataTable}) {
  showDialog(
    context: context,
    builder: (context) =>
        AddEditOrderDialog(order: order, customDataTable: customDataTable),
  );
}
