import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_com_admin_web/providers/coupon_provider.dart';

import '../../../../data/model/coupon.dart';
import '../../../utils/color_value_key.dart';
import '../../../utils/local_value_key.dart';
import '../../../utils/toast.dart';
import '../../../utils/widgets/base_form_dialog.dart';
import '../../../utils/widgets/data_table.dart';
import '../../../utils/widgets/input_form_widget.dart';

class AddEditCouponDialog extends ConsumerStatefulWidget {
  final Coupon? coupon;
  final CustomDataTable? customDataTable;

  const AddEditCouponDialog({super.key, this.coupon, this.customDataTable});

  @override
  ConsumerState<AddEditCouponDialog> createState() => _AddEditCouponDialogState();
}

class _AddEditCouponDialogState extends ConsumerState<AddEditCouponDialog> {
  String code = '';
  int discountValue = 0;
  String discountType = '';
  String address = '';
  String password = '';
  bool isAdmin = false;
  @override
  Widget build(BuildContext context) {
    bool isNotEdit = widget.coupon == null;
    return BaseFormDialog(
      title: isNotEdit ? LocalValueKey.addCoupon : LocalValueKey.editCoupon,
      inputs: [
        InputForm(
          enabled: isNotEdit ? true : false,
          initialValue: widget.coupon?.code ?? "",
          labelText: LocalValueKey.name,
          isRequired: true,
          onSaved: (newValue) {
            code = newValue ?? '';
          },
        ),
        const SizedBox(
          height: 8,
        ),

        const SizedBox(
          height: 8,
        ),
        InputForm(
          enabled: true,
          initialValue: widget.coupon?.discountType ?? "",
          labelText: 'Loại giảm giá',
          isRequired: true,
          onSaved: (newValue) {
            discountType = newValue ?? '';
          },
        ),
      ],
      onSubmit: (formKey, setLoading) async {
        if (!formKey.currentState!.validate()) return;
        formKey.currentState!.save();
        setLoading(true);
        // final result = isNotEdit
        //     ? await ref.read(couponProvider.notifier).createCoupon()
        //     : await ref.read(couponProvider.notifier).updateCouponInfo(
        //         id: widget.coupon?.id ?? "",);
        setLoading(false);
        if (!context.mounted) return;
        final couponState = ref.read(couponProvider);
        // final content = result == true
        //     ? isNotEdit
        //         ? LocalValueKey.addSuccessCoupon
        //         : LocalValueKey.editSuccessCoupon
        //     : couponState.errorMessage ??
        //         "Thất bại khi $isNotEdit ? tạo : chỉnh sửa người dùng";
        // showResultToastWithUI(
        //   description: content ?? "",
        //   context: context,
        //   result: result,
        // );
        // if (result) {
        //   widget.customDataTable?.controller.clearSelected();
        //   context.pop();
        // }
      },
    );
  }
}

void showAddEditCouponDialog(BuildContext context,
    {Coupon? coupon, CustomDataTable? customDataTable}) {
  showDialog(
    context: context,
    builder: (context) =>
        AddEditCouponDialog(coupon: coupon, customDataTable: customDataTable),
  );
}
