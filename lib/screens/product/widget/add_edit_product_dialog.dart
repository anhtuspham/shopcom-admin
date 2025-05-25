// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';
// import 'package:shop_com_admin_web/providers/product_provider.dart';
//
// import '../../../../data/model/product.dart';
// import '../../../data/model/product.dart';
// import '../../../utils/color_value_key.dart';
// import '../../../utils/local_value_key.dart';
// import '../../../utils/toast.dart';
// import '../../../utils/widgets/base_form_dialog.dart';
// import '../../../utils/widgets/data_table.dart';
// import '../../../utils/widgets/input_form_widget.dart';
//
// class AddEditProductDialog extends ConsumerStatefulWidget {
//   final Product? product;
//   final CustomDataTable? customDataTable;
//
//   const AddEditProductDialog({super.key, this.product, this.customDataTable});
//
//   @override
//   ConsumerState<AddEditProductDialog> createState() => _AddEditProductDialogState();
// }
//
// class _AddEditProductDialogState extends ConsumerState<AddEditProductDialog> {
//   final ValueNotifier<bool> hidePassword = ValueNotifier(true);
//   final double space = 12;
//   ValueNotifier<bool> loadingNotifier = ValueNotifier(false);
//   String email = '';
//   String name = '';
//   String address = '';
//   String password = '';
//   bool isAdmin = false;
//
//   @override
//   void dispose() {
//     loadingNotifier.dispose();
//     hidePassword.dispose();
//     super.dispose();
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     if (widget.product != null) {
//       isAdmin = widget.product?.isAdmin ?? false;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     bool isNotEdit = widget.product == null;
//     return BaseFormDialog(
//       title: isNotEdit ? LocalValueKey.addProduct : LocalValueKey.editProduct,
//       inputs: [
//         InputForm(
//           enabled: isNotEdit ? true : false,
//           initialValue: widget.product?.name ?? "",
//           labelText: LocalValueKey.name,
//           isRequired: true,
//           onSaved: (newValue) {
//             name = newValue ?? '';
//           },
//         ),
//         const SizedBox(
//           height: 8,
//         ),
//         InputForm(
//           enabled: isNotEdit ? true : false,
//           initialValue: widget.product?.email ?? "",
//           labelText: LocalValueKey.email,
//           isRequired: true,
//           onSaved: (newValue) {
//             email = newValue ?? '';
//           },
//         ),
//         const SizedBox(
//           height: 8,
//         ),
//         ValueListenableBuilder(
//           valueListenable: hidePassword,
//           builder: (context, value, child) {
//             return InputForm(
//               labelText: LocalValueKey.password,
//               isRequired: widget.product == null ? true : false,
//               obscureText: value,
//               suffixIcon: IconButton(
//                 onPressed: () {
//                   hidePassword.value = !hidePassword.value;
//                 },
//                 icon: value
//                     ? Icon(
//                         Icons.visibility_off,
//                         color: ColorValueKey.textColor,
//                       )
//                     : Icon(
//                         Icons.visibility,
//                         color: ColorValueKey.textColor,
//                       ),
//               ),
//               onSaved: (newValue) {
//                 password = newValue ?? '';
//               },
//             );
//           },
//         ),
//         const SizedBox(
//           height: 8,
//         ),
//         InputForm(
//           enabled: true,
//           initialValue: widget.product?.address ?? "",
//           labelText: 'Địa chỉ',
//           isRequired: true,
//           onSaved: (newValue) {
//             address = newValue ?? '';
//           },
//         ),
//         const SizedBox(
//           height: 8,
//         ),
//         Padding(
//           padding: const EdgeInsets.all(8),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               const Text('Admin'),
//               Switch(
//                 value: isAdmin,
//                 onChanged: (value) {
//                   setState(() {
//                     isAdmin = value;
//                   });
//                 },
//                 activeColor: ColorValueKey.editColor,
//               )
//             ],
//           ),
//         )
//       ],
//       onSubmit: (formKey, setLoading) async {
//         if (!formKey.currentState!.validate()) return;
//         formKey.currentState!.save();
//         setLoading(true);
//         final result = isNotEdit
//             ? await ref.read(productProvider.notifier).createProduct(
//                   name: name,
//                   email: email,
//                   password: password,
//                   isAdmin: isAdmin,
//                   address: address,
//                 )
//             : await ref.read(productProvider.notifier).updateProductInfo(
//                 id: widget.product?.id ?? "",
//                 name: name,
//                 email: email,
//                 address: address,
//                 password: password,
//                 isAdmin: isAdmin);
//         setLoading(false);
//         if (!context.mounted) return;
//         final productState = ref.read(productProvider);
//         final content = result == true
//             ? isNotEdit
//                 ? LocalValueKey.addSuccessProduct
//                 : LocalValueKey.editSuccessProduct
//             : productState.errorMessage ??
//                 "Thất bại khi $isNotEdit ? tạo : chỉnh sửa người dùng";
//         showResultToastWithUI(
//           description: content ?? "",
//           context: context,
//           result: result,
//         );
//         if (result) {
//           widget.customDataTable?.controller.clearSelected();
//           context.pop();
//         }
//       },
//     );
//   }
// }
//
// void showAddEditProductDialog(BuildContext context,
//     {Product? product, CustomDataTable? customDataTable}) {
//   showDialog(
//     context: context,
//     builder: (context) =>
//         AddEditProductDialog(product: product, customDataTable: customDataTable),
//   );
// }
