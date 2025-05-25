import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_com_admin_web/data/model/coupon.dart';
import 'package:shop_com_admin_web/utils/custom_page_controller.dart';
import 'package:shop_com_admin_web/utils/global_key.dart';
import 'package:shop_com_admin_web/utils/local_value_key.dart';
import 'package:shop_com_admin_web/utils/widgets/button_widget.dart';
import 'package:shop_com_admin_web/utils/widgets/data_table.dart';
import 'package:shop_com_admin_web/utils/widgets/error_widget.dart';

import '../../../providers/coupon_provider.dart';
import '../../../utils/toast.dart';
import '../../../utils/widgets/dialog_confirm.dart';
import '../widget/add_edit_coupon_dialog.dart';

class CouponScreen extends ConsumerStatefulWidget {
  const CouponScreen({super.key});

  @override
  ConsumerState<CouponScreen> createState() => _CouponScreenState();
}

class _CouponScreenState extends ConsumerState<CouponScreen> {
  late CustomPageController<Coupon> customPageController =
      CustomPageController<Coupon>(
    data: [],
    dataEmpty: [Coupon.empty()],
    funcCompare: (a, b) => a.code?.compareTo(b.code ?? '') ?? 0,
  );
  late CustomDataTable<Coupon> customDataTable;

  @override
  Widget build(BuildContext context) {
    final couponState = ref.watch(couponProvider);

    customPageController.setData(couponState.coupon);

    customDataTable = CustomDataTable<Coupon>(
      controller: customPageController,
      titleHeader: 'Danh sách người dùng',
      showExtension: (Coupon coupon) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => showAddEditCouponDialog(context, coupon: coupon),
          ),
          const SizedBox(width: 10),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () async {
              final isOk = await showConfirmDialog(context,
                  title: '${LocalValueKey.deleteConfirm}: ${coupon.code}');
              if (!isOk) return;

              final result = await ref
                  .read(couponProvider.notifier)
                  .deleteCoupon(id: coupon.id ?? '');
              if (!context.mounted) return;

              final content = result == true
                  ? LocalValueKey.deleteSuccessCoupon
                  : LocalValueKey.deleteFailCoupon;
              showResultToastWithUI(
                description: content ?? "",
                context: context,
                result: result,
              );
            },
          ),
        ],
      ),
      bottomWidget: Row(
        children: [
          CreateButtonWidget(
              callBack: () => showAddEditCouponDialog(context),
              tooltip: LocalValueKey.addCoupon)
        ],
      ),
      refresh: () {
        ref.read(couponProvider.notifier).refresh();
      },
      showPagination: true,
      showBottomWidget: true,
      isShowCheckbox: false,
      parent: context,
    );

    return Column(
      children: [
        if (couponState.isLoading)
          const Expanded(
            child: Center(child: CircularProgressIndicator()),
          )
        else if (couponState.isError)
          const Expanded(
            child: ErrorsWidget(),
          )
        else if (couponState.coupon.isEmpty)
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
