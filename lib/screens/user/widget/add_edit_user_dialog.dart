import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_com_admin_web/providers/user_provider.dart';

import '../../../../data/model/user.dart';
import '../../../utils/color_value_key.dart';
import '../../../utils/local_value_key.dart';
import '../../../utils/toast.dart';
import '../../../utils/widgets/base_form_dialog.dart';
import '../../../utils/widgets/data_table.dart';
import '../../../utils/widgets/input_form_widget.dart';

class AddEditUserDialog extends ConsumerStatefulWidget {
  final User? user;
  final CustomDataTable? customDataTable;

  const AddEditUserDialog({super.key, this.user, this.customDataTable});

  @override
  ConsumerState<AddEditUserDialog> createState() => _AddEditUserDialogState();
}

class _AddEditUserDialogState extends ConsumerState<AddEditUserDialog> {
  final ValueNotifier<bool> hidePassword = ValueNotifier(true);
  final double space = 12;
  ValueNotifier<bool> loadingNotifier = ValueNotifier(false);
  String email = '';
  String name = '';
  String address = '';
  String password = '';
  bool isAdmin = false;

  @override
  void dispose() {
    loadingNotifier.dispose();
    hidePassword.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.user != null) {
      isAdmin = widget.user?.isAdmin ?? false;
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isNotEdit = widget.user == null;
    return BaseFormDialog(
      title: isNotEdit ? LocalValueKey.addUser : LocalValueKey.editUser,
      inputs: [
        InputForm(
          enabled: isNotEdit ? true : false,
          initialValue: widget.user?.name ?? "",
          labelText: LocalValueKey.name,
          isRequired: true,
          onSaved: (newValue) {
            name = newValue ?? '';
          },
        ),
        const SizedBox(
          height: 8,
        ),
        InputForm(
          enabled: isNotEdit ? true : false,
          initialValue: widget.user?.email ?? "",
          labelText: LocalValueKey.email,
          isRequired: true,
          onSaved: (newValue) {
            email = newValue ?? '';
          },
        ),
        const SizedBox(
          height: 8,
        ),
        ValueListenableBuilder(
          valueListenable: hidePassword,
          builder: (context, value, child) {
            return InputForm(
              labelText: LocalValueKey.password,
              isRequired: widget.user == null ? true : false,
              obscureText: value,
              suffixIcon: IconButton(
                onPressed: () {
                  hidePassword.value = !hidePassword.value;
                },
                icon: value
                    ? Icon(
                        Icons.visibility_off,
                        color: ColorValueKey.textColor,
                      )
                    : Icon(
                        Icons.visibility,
                        color: ColorValueKey.textColor,
                      ),
              ),
              onSaved: (newValue) {
                password = newValue ?? '';
              },
            );
          },
        ),
        const SizedBox(
          height: 8,
        ),
        InputForm(
          enabled: isNotEdit ? true : false,
          initialValue: widget.user?.address ?? "",
          labelText: 'Địa chỉ',
          isRequired: true,
          onSaved: (newValue) {
            address = newValue ?? '';
          },
        ),
        const SizedBox(
          height: 8,
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Text('Quyền quản trị'),
              Switch(
                value: isAdmin,
                onChanged: (value) {
                  setState(() {
                    isAdmin = value;
                  });
                },
                activeColor: ColorValueKey.mainColor,
              )
            ],
          ),
        )
      ],
      onSubmit: (formKey, setLoading) async {
        if (!formKey.currentState!.validate()) return;
        formKey.currentState!.save();
        setLoading(true);
        final result = isNotEdit
            ? await ref.read(userProvider.notifier).createUser(
                  name: name,
                  email: email,
                  password: password,
                  isAdmin: isAdmin,
                  address: address,
                )
            : await ref.read(userProvider.notifier).updateUserInfo(
                  name: name,
                  email: email,
                  address: address,
                  password: password,
                );
        setLoading(false);
        if (!context.mounted) return;
        final userState = ref.read(userProvider);
        final content = result == true
            ? isNotEdit
                ? LocalValueKey.addSuccessUser
                : LocalValueKey.editSuccessUser
            : userState.errorMessage ??
                "Thất bại khi $isNotEdit ? tạo : chỉnh sửa người dùng";
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

void showAddEditUserDialog(BuildContext context,
    {User? user, CustomDataTable? customDataTable}) {
  showDialog(
    context: context,
    builder: (context) =>
        AddEditUserDialog(user: user, customDataTable: customDataTable),
  );
}
