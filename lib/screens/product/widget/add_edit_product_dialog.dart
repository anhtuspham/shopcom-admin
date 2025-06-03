import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shop_com_admin_web/data/model/variant.dart';
import 'package:shop_com_admin_web/providers/product_provider.dart';
import '../../../data/model/product.dart';
import '../../../utils/local_value_key.dart';
import '../../../utils/toast.dart';
import '../../../utils/widgets/base_form_dialog.dart';
import '../../../utils/widgets/data_table.dart';
import '../../../utils/widgets/input_form_widget.dart';

class AddEditProductDialog extends ConsumerStatefulWidget {
  final Product? product;
  final CustomDataTable? customDataTable;

  const AddEditProductDialog({super.key, this.product, this.customDataTable});

  @override
  ConsumerState<AddEditProductDialog> createState() =>
      _AddEditProductDialogState();
}

class _AddEditProductDialogState extends ConsumerState<AddEditProductDialog> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController brandController = TextEditingController();
  final List<_VariantForm> variants = [_VariantForm()];
  final ImagePicker _picker = ImagePicker();
  final List<String> categoryItems = [
    'Laptop',
    'Smartphone',
    'Tablet',
    'Headphone'
  ];

  @override
  void initState() {
    super.initState();
    if (widget.product != null) {
      nameController.text = widget.product!.name;
      descriptionController.text = widget.product!.description ?? '';
      categoryController.text = widget.product!.category ?? '';
      brandController.text = widget.product!.brand ?? '';
      if (widget.product!.variants != null &&
          widget.product!.variants!.isNotEmpty) {
        variants.clear();
        for (var variant in widget.product!.variants!) {
          variants.add(_VariantForm.fromVariant(variant));
        }
      }
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    categoryController.dispose();
    brandController.dispose();
    for (var variant in variants) {
      variant.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isNotEdit = widget.product == null;
    return BaseFormDialog(
      title: isNotEdit ? LocalValueKey.addProduct : LocalValueKey.editProduct,
      key: _formKey,
      width: 600,
      inputs: [
        const SizedBox(height: 20),
        InputForm(
          controller: nameController,
          labelText: 'Name',
          isRequired: true,
        ),
        const SizedBox(height: 8),
        InputForm(
          controller: descriptionController,
          labelText: 'Description',
          isRequired: true,
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField(
          value: categoryController.text.isNotEmpty
              ? categoryController.text
              : null,
          items: categoryItems.map((item) {
            return DropdownMenuItem(value: item, child: Text(item));
          }).toList(),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Category is required';
            }
            return null;
          },
          decoration: const InputDecoration(
              border: OutlineInputBorder(), labelText: 'Category'),
          onChanged: (value) {
            categoryController.text = value ?? '';
          },
        ),
        const SizedBox(height: 8),
        InputForm(
          controller: brandController,
          labelText: 'Brand',
          isRequired: true,
        ),
        const SizedBox(height: 16),
        const Text(
          'Variants',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: variants.length,
          itemBuilder: (context, index) {
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Variant ${index + 1}',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    InputForm(
                      controller: variants[index].priceController,
                      labelText: 'Price',
                      isRequired: true,
                    ),
                    const SizedBox(height: 8),
                    InputForm(
                      controller: variants[index].quantityController,
                      labelText: 'Quantity',
                      isRequired: true,
                    ),
                    const SizedBox(height: 8),
                    InputForm(
                      controller: variants[index].ramController,
                      labelText: 'RAM',
                      // isRequired: true,
                    ),
                    const SizedBox(height: 8),
                    InputForm(
                      controller: variants[index].romController,
                      labelText: 'ROM',
                      // isRequired: true,
                    ),
                    const SizedBox(height: 8),
                    InputForm(
                      controller: variants[index].colorController,
                      labelText: 'Color',
                      // isRequired: true,
                    ),
                    const SizedBox(height: 8),
                    const Text('Images'),
                    Wrap(
                      spacing: 8,
                      children: [
                        ...variants[index].existingImages.map((url) {
                          return Stack(
                            children: [
                              Image.network(
                                url,
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                              Positioned(
                                right: 0,
                                child: IconButton(
                                  icon: const Icon(Icons.remove_circle,
                                      color: Colors.red),
                                  onPressed: () {
                                    setState(() {
                                      variants[index]
                                          .existingImages
                                          .remove(url);
                                    });
                                  },
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                        ...variants[index].newImages.entries.map((entry) {
                          final imageBytes = entry.value;
                          return Stack(
                            children: [
                              Image.memory(
                                imageBytes,
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                              Positioned(
                                right: 0,
                                child: IconButton(
                                  icon: const Icon(Icons.remove_circle,
                                      color: Colors.red),
                                  onPressed: () {
                                    setState(() {
                                      variants[index]
                                          .newImages
                                          .remove(entry.key);
                                    });
                                  },
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        final pickedFiles = await _picker.pickMultiImage();
                        if (pickedFiles != null) {
                          for (var file in pickedFiles) {
                            final bytes = await file.readAsBytes();
                            setState(() {
                              variants[index].newImages[file] = bytes;
                            });
                          }
                        }
                      },
                      child: const Text('Add Images'),
                    ),
                    if (variants.length > 1)
                      Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            setState(() {
                              variants.removeAt(index);
                            });
                          },
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              variants.add(_VariantForm());
            });
          },
          child: const Text('Add Variant'),
        ),
      ],
      onSubmit: (formKey, setLoading) async {
        if (!formKey.currentState!.validate()) return;
        formKey.currentState!.save();
        setLoading(true);

        final variantData = variants.map((v) => v.toJson()).toList();
        final variantImages =
            variants.map((v) => v.newImages.keys.toList()).toList();

        final result = isNotEdit
            ? await ref.read(productProvider.notifier).createProduct(
                  name: nameController.text,
                  description: descriptionController.text,
                  category: categoryController.text,
                  brand: brandController.text,
                  variants: variantData,
                  variantImages: variantImages,
                )
            : await ref.read(productProvider.notifier).updateProduct(
                  id: widget.product?.id ?? '',
                  name: nameController.text,
                  description: descriptionController.text,
                  category: categoryController.text,
                  brand: brandController.text,
                  variants: variantData,
                  variantImages: variantImages,
                );

        setLoading(false);
        if (!context.mounted) return;

        final productState = ref.read(productProvider);
        final content = result == true
            ? isNotEdit
                ? LocalValueKey.addSuccessProduct
                : LocalValueKey.editSuccessProduct
            : productState.errorMessage ??
                'Failed to ${isNotEdit ? 'create' : 'update'} product';

        showResultToastWithUI(
          description: content,
          context: context,
          result: result,
        );

        if (result) {
          widget.customDataTable?.controller.clearSelected();
          Navigator.of(context).pop();
        }
      },
    );
  }
}

class _VariantForm {
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController ramController = TextEditingController();
  final TextEditingController romController = TextEditingController();
  final TextEditingController colorController = TextEditingController();
  List<String> existingImages = [];
  Map<XFile, Uint8List> newImages = {};

  _VariantForm();

  factory _VariantForm.fromVariant(Variant variant) {
    final form = _VariantForm();
    form.priceController.text = variant.price?.toString() ?? '';
    form.quantityController.text = variant.quantity?.toString() ?? '';
    form.ramController.text = variant.ram ?? '';
    form.romController.text = variant.rom ?? '';
    form.colorController.text = variant.color ?? '';
    form.existingImages = variant.images ?? [];
    return form;
  }

  Map<String, dynamic> toJson() => {
        'price': double.tryParse(priceController.text) ?? 0.0,
        'quantity': int.tryParse(quantityController.text) ?? 0,
        'ram': ramController.text,
        'rom': romController.text,
        'color': colorController.text,
        'images': existingImages,
      };

  void dispose() {
    priceController.dispose();
    quantityController.dispose();
    ramController.dispose();
    romController.dispose();
    colorController.dispose();
  }
}

void showAddEditProductDialog(BuildContext context,
    {Product? product, CustomDataTable? customDataTable}) {
  showDialog(
    context: context,
    builder: (context) => AddEditProductDialog(
        product: product, customDataTable: customDataTable),
  );
}
