import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_com_admin_web/providers/coupon_provider.dart';
import 'package:shop_com_admin_web/utils/util.dart';
import 'package:intl/intl.dart';

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
  ConsumerState<AddEditCouponDialog> createState() =>
      _AddEditCouponDialogState();
}

class _AddEditCouponDialogState extends ConsumerState<AddEditCouponDialog> {
  String code = '';
  int discountValue = 0;
  int maxDiscountAmount = 0;
  int minOrderValue = 0;
  String discountType = '';
  DateTime expireTime = DateTime.now();
  int usageLimit = 0;

  final TextEditingController _expireTimeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _expireTimeController.text = widget.coupon != null
        ? getStringFromDateTime(widget.coupon!.expirationDate ?? DateTime.now(),
            'dd/MM/yyyy hh:mm:ss')
        : '';
  }

  @override
  void dispose() {
    super.dispose();
    _expireTimeController.dispose();
  }

  Future<void> _selectDateTime(BuildContext context) async {
    // Show date picker
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: expireTime,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      // Show time picker after date is selected
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(expireTime),
      );

      if (pickedTime != null && context.mounted) {
        setState(() {
          // Combine date and time into a single DateTime
          expireTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
          // Update the text controller with formatted date-time
          _expireTimeController.text =
              DateFormat('dd/MM/yyyy HH:mm:ss').format(expireTime);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isNotEdit = widget.coupon == null;
    return BaseFormDialog(
      title: isNotEdit ? LocalValueKey.addCoupon : LocalValueKey.editCoupon,
      inputs: [
        InputForm(
          enabled: isNotEdit ? true : false,
          initialValue: widget.coupon?.code ?? "",
          labelText: LocalValueKey.code,
          isRequired: true,
          onSaved: (newValue) {
            code = newValue ?? '';
          },
        ),
        const SizedBox(
          height: 8,
        ),
        InputForm(
          enabled: true,
          initialValue: widget.coupon?.discountType ?? "",
          labelText: LocalValueKey.discountType,
          isRequired: true,
          onSaved: (newValue) {
            discountType = newValue ?? '';
          },
        ),
        const SizedBox(
          height: 8,
        ),
        InputForm(
          enabled: true,
          initialValue: widget.coupon?.discountValue.toString() ?? "",
          labelText: LocalValueKey.discountValue,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          isRequired: true,
          onSaved: (newValue) {
            discountValue = int.parse(newValue ?? '0');
          },
        ),
        const SizedBox(
          height: 8,
        ),
        InputForm(
          enabled: true,
          initialValue: widget.coupon?.maxDiscountAmount.toString() ?? "",
          labelText: LocalValueKey.maxDiscountAmount,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          isRequired: true,
          onSaved: (newValue) {
            maxDiscountAmount = int.parse(newValue ?? '0');
          },
        ),
        const SizedBox(
          height: 8,
        ),
        InputForm(
          enabled: true,
          initialValue: widget.coupon?.minOrderValue.toString() ?? "",
          labelText: LocalValueKey.minOrderValue,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          isRequired: true,
          onSaved: (newValue) {
            minOrderValue = int.parse(newValue ?? '0');
          },
        ),
        const SizedBox(
          height: 8,
        ),
        TextFormField(
          controller: _expireTimeController,
          readOnly: true,
          // Make it read-only to prevent manual text input
          decoration: InputDecoration(
            labelText: LocalValueKey.expirationDate,
            suffixIcon: Icon(Icons.calendar_today),
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please select an expiration date and time';
            }
            return null;
          },
          onTap: () => _selectDateTime(context),
          // Trigger date-time picker on tap
          onSaved: (newValue) {
            // expireTime is already updated in _selectDateTime
          },
        ),
        const SizedBox(
          height: 8,
        ),
        InputForm(
          enabled: true,
          initialValue: widget.coupon?.usageLimit.toString() ?? "",
          labelText: LocalValueKey.usageLimit,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          isRequired: true,
          onSaved: (newValue) {
            usageLimit = int.parse(newValue ?? '0');
          },
        ),
      ],
      onSubmit: (formKey, setLoading) async {
        if (!formKey.currentState!.validate()) return;
        formKey.currentState!.save();
        setLoading(true);
        final result = isNotEdit
            ? await ref.read(couponProvider.notifier).createCoupon(
                code: code,
                discountValue: discountValue,
                discountType: discountType,
                minOrderValue: minOrderValue,
                expirationDate: expireTime,
                maxDiscountAmount: maxDiscountAmount,
                usageLimit: usageLimit)
            : await ref.read(couponProvider.notifier).updateCoupon(
                id: widget.coupon?.id ?? "",
                code: code,
                discountValue: discountValue,
                discountType: discountType,
                minOrderValue: minOrderValue,
                expirationDate: expireTime,
                maxDiscountAmount: maxDiscountAmount,
                usageLimit: usageLimit);
        setLoading(false);
        if (!context.mounted) return;
        final couponState = ref.read(couponProvider);
        final content = result == true
            ? isNotEdit
                ? LocalValueKey.addSuccessCoupon
                : LocalValueKey.editSuccessCoupon
            : couponState.errorMessage ??
                "Thất bại khi $isNotEdit ? tạo : chỉnh sửa mã giảm giá";
        showResultToastWithUI(
          description: content ?? "",
          context: context,
          result: result,
        );
        context.pop();
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
