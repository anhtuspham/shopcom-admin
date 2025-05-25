// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:shop_com_admin_web/providers/product_provider.dart';
// import 'package:shop_com_admin_web/data/model/product.dart';
// import 'package:shop_com_admin_web/screens/product/widget/add_edit_product_dialog.dart';
// import 'package:shop_com_admin_web/utils/custom_page_controller.dart';
// import 'package:shop_com_admin_web/utils/global_key.dart';
// import 'package:shop_com_admin_web/utils/local_value_key.dart';
// import 'package:shop_com_admin_web/utils/widgets/button_widget.dart';
// import 'package:shop_com_admin_web/utils/widgets/data_table.dart';
// import 'package:shop_com_admin_web/utils/widgets/error_widget.dart';
//
// import '../../../data/model/product.dart';
// import '../../../utils/toast.dart';
// import '../../../utils/widgets/dialog_confirm.dart';
// import '../widget/add_edit_product_dialog.dart';
//
// class ProductScreen extends ConsumerStatefulWidget {
//   const ProductScreen({super.key});
//
//   @override
//   ConsumerState<ProductScreen> createState() => _ProductScreenState();
// }
//
// class _ProductScreenState extends ConsumerState<ProductScreen> {
//   late CustomPageController<Product> customPageController =
//   CustomPageController<Product>(
//     data: [],
//     dataEmpty: [Product.empty()],
//     funcCompare: (a, b) => a.name.compareTo(b.name ?? '') ?? 0,
//   );
//   late CustomDataTable<Product> customDataTable;
//
//   @override
//   Widget build(BuildContext context) {
//     final productState = ref.watch(productProvider);
//
//     customPageController.setData(productState.product);
//
//     customDataTable = CustomDataTable<Product>(
//       controller: customPageController,
//       titleHeader: 'Danh sách sản phẩm',
//       showExtension: (Product product) => Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           IconButton(
//             icon: const Icon(Icons.edit),
//             onPressed: () => showAddEditProductDialog(context, product: product),
//           ),
//           const SizedBox(width: 10),
//           IconButton(
//             icon: const Icon(Icons.delete, color: Colors.red),
//             onPressed: () async {
//               final isOk = await showConfirmDialog(context,
//                   title: '${LocalValueKey.deleteConfirm}: ${product.name}');
//               if (!isOk) return;
//
//               final result = await ref
//                   .read(productProvider.notifier)
//                   .deleteProduct(id: product.id ?? '');
//               if (!context.mounted) return;
//
//               final content = result == true
//                   ? LocalValueKey.deleteSuccessProduct
//                   : LocalValueKey.deleteFailProduct;
//               showResultToastWithUI(
//                 description: content ?? "",
//                 context: context,
//                 result: result,
//               );
//             },
//           ),
//         ],
//       ),
//       bottomWidget: Row(
//         children: [
//           CreateButtonWidget(
//               callBack: () => showAddEditProductDialog(context),
//               tooltip: LocalValueKey.addProduct)
//         ],
//       ),
//       refresh: () {
//         ref.read(productProvider.notifier).refresh();
//       },
//       showPagination: true,
//       showBottomWidget: true,
//       isShowCheckbox: true,
//       parent: context,
//     );
//
//     // customDataTable.setConfigSize([
//     //   200,
//     //   200,
//     //   200,
//     // ]);
//     customDataTable.setConfigFilter([true, true, true, true, true, false]);
//     customDataTable.setConfigSort([true, true, true, true, true, false]);
//     customDataTable.setConfigSearch(['email', 'name', 'address']);
//
//     return Column(
//       children: [
//         if (productState.isLoading)
//           const Expanded(
//             child: Center(child: CircularProgressIndicator()),
//           )
//         else if (productState.isError)
//           const Expanded(
//             child: ErrorsWidget(),
//           )
//         else if (productState.product.isEmpty)
//             const Expanded(
//               child: Center(child: Text('Không có người dùng nào')),
//             )
//           else
//             Expanded(
//               child: customDataTable.drawTable(context),
//             ),
//       ],
//     );
//   }
// }
