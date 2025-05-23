import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_com_admin_web/providers/user_provider.dart';
import 'package:shop_com_admin_web/data/model/user.dart';
import 'package:shop_com_admin_web/screens/user/widget/add_edit_user_dialog.dart';
import 'package:shop_com_admin_web/utils/custom_page_controller.dart';
import 'package:shop_com_admin_web/utils/local_value_key.dart';
import 'package:shop_com_admin_web/utils/widgets/button_widget.dart';
import 'package:shop_com_admin_web/utils/widgets/data_table.dart';

class UserScreen extends ConsumerStatefulWidget {
  const UserScreen({super.key});

  @override
  ConsumerState<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends ConsumerState<UserScreen> {
  late CustomPageController<User> customPageController =
      CustomPageController<User>(
    data: [],
    dataEmpty: [User.empty()], // User.empty() để cung cấp cấu trúc mẫu
    funcCompare: (a, b) => a.name.compareTo(b.name ?? '') ?? 0,
  );
  late CustomDataTable<User> customDataTable;

  @override
  Widget build(BuildContext context) {
    // Theo dõi trạng thái userProvider
    final userState = ref.watch(userProvider);

    // Cập nhật dữ liệu cho controller
    customPageController.setData(userState.user);

    // Tạo CustomDataTable với cột extension để thêm và chỉnh sửa
    customDataTable = CustomDataTable<User>(
      controller: customPageController,
      titleHeader: 'Danh sách người dùng',
      showExtension: (User user) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  TextEditingController nameController =
                      TextEditingController(text: user.name);
                  TextEditingController emailController =
                      TextEditingController(text: user.email);
                  return AlertDialog(
                    title: const Text('Chỉnh sửa User'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: nameController,
                          decoration: const InputDecoration(labelText: 'Tên'),
                        ),
                        TextField(
                          controller: emailController,
                          decoration: const InputDecoration(labelText: 'Email'),
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Hủy'),
                      ),
                      TextButton(
                        onPressed: () async {
                          final success = await ref
                              .read(userProvider.notifier)
                              .updateUserInfo(
                                name: nameController.text,
                                email: emailController.text,
                              );
                          Navigator.of(context).pop();
                          if (success) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Cập nhật user thành công')),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Cập nhật user thất bại')),
                            );
                          }
                        },
                        child: const Text('Lưu'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
          // IconButton(
          //   icon: const Icon(Icons.add),
          //   onPressed: () {
          //     showDialog(
          //       context: context,
          //       builder: (context) {
          //         TextEditingController codeController =
          //             TextEditingController();
          //         TextEditingController usernameController =
          //             TextEditingController();
          //         TextEditingController nameController =
          //             TextEditingController();
          //         TextEditingController passwordController =
          //             TextEditingController();
          //         TextEditingController desController = TextEditingController();
          //         TextEditingController roleController =
          //             TextEditingController();
          //         TextEditingController phoneController =
          //             TextEditingController();
          //         return AlertDialog(
          //           title: const Text('Thêm User'),
          //           content: SingleChildScrollView(
          //             child: Column(
          //               mainAxisSize: MainAxisSize.min,
          //               children: [
          //                 TextField(
          //                   controller: codeController,
          //                   decoration: const InputDecoration(labelText: 'Mã'),
          //                 ),
          //                 TextField(
          //                   controller: usernameController,
          //                   decoration: const InputDecoration(
          //                       labelText: 'Tên đăng nhập'),
          //                 ),
          //                 TextField(
          //                   controller: nameController,
          //                   decoration: const InputDecoration(labelText: 'Tên'),
          //                 ),
          //                 TextField(
          //                   controller: passwordController,
          //                   decoration:
          //                       const InputDecoration(labelText: 'Mật khẩu'),
          //                 ),
          //                 TextField(
          //                   controller: desController,
          //                   decoration:
          //                       const InputDecoration(labelText: 'Mô tả'),
          //                 ),
          //                 TextField(
          //                   controller: roleController,
          //                   decoration:
          //                       const InputDecoration(labelText: 'Vai trò'),
          //                 ),
          //                 TextField(
          //                   controller: phoneController,
          //                   decoration: const InputDecoration(
          //                       labelText: 'Số điện thoại'),
          //                 ),
          //               ],
          //             ),
          //           ),
          //           actions: [
          //             TextButton(
          //               onPressed: () => Navigator.of(context).pop(),
          //               child: const Text('Hủy'),
          //             ),
          //             TextButton(
          //               onPressed: () async {
          //                 final success =
          //                     await ref.read(userProvider.notifier).createUser(
          //                           code: codeController.text,
          //                           username: usernameController.text,
          //                           name: nameController.text,
          //                           password: passwordController.text,
          //                           des: desController.text,
          //                           role: roleController.text,
          //                           phone: phoneController.text,
          //                         );
          //                 Navigator.of(context).pop();
          //                 if (success) {
          //                   ScaffoldMessenger.of(context).showSnackBar(
          //                     const SnackBar(
          //                         content: Text('Tạo user thành công')),
          //                   );
          //                 } else {
          //                   ScaffoldMessenger.of(context).showSnackBar(
          //                     const SnackBar(
          //                         content: Text('Tạo user thất bại')),
          //                   );
          //                 }
          //               },
          //               child: const Text('Tạo'),
          //             ),
          //           ],
          //         );
          //       },
          //     );
          //   },
          // ),
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
    ]); // Cho phép lọc tất cả cột trừ extension
    customDataTable.setConfigSort([
      true,
      true,
      true,
      true,
      true,
      false
    ]); // Cho phép sắp xếp tất cả cột trừ extension
    customDataTable.setConfigSearch(
        ['code', 'name', 'email', 'phone', 'role']); // Cột có thể tìm kiếm

    // Sử dụng Column để chứa nội dung chính
    return Column(
      children: [
        if (userState.isLoading)
          const Expanded(
            child: Center(child: CircularProgressIndicator()),
          )
        else if (userState.isError)
          Expanded(
            child: Center(
                child: Text(
                    'Lỗi: ${userState.errorMessage ?? "Lỗi không xác định"}')),
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
