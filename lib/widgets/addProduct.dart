import 'package:egrocery/constants/productConstants.dart';
import 'package:egrocery/providers/productsProviders.dart';
import 'package:egrocery/widgets/inputWithLabel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddProduct extends ConsumerStatefulWidget {
  const AddProduct(
      {super.key,
      required this.isEditMode,
      this.productId,
      this.productName,
      this.moq,
      this.price,
      this.discountPrice});

  final bool isEditMode;
  final String? productId;
  final String? productName;
  final String? moq;
  final String? price;
  final String? discountPrice;

  @override
  ConsumerState<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends ConsumerState<AddProduct> {
  final addProductFormKey = GlobalKey<FormState>();
  String productName = '';
  String moq = '';
  String price = '';
  String discountPrice = '';
  String productId = '';
  bool isloading = false;

  @override
  void initState() {
    if (widget.isEditMode) {
      setState(() {
        productId = widget.productId!;
        productName = widget.productName!;
        moq = widget.moq!;
        price = widget.price!;
        discountPrice = widget.discountPrice!;
      });
    }
    super.initState();
  }

  onAddSubmitHandler() async {
    try {
      if (addProductFormKey.currentState!.validate()) {
        addProductFormKey.currentState!.save();
        setState(() {
          isloading = true;
        });
        if (widget.isEditMode) {
          await ref.read(updateProductsProvider.notifier).updateProducts({
            'id': productId,
            'name': productName,
            'moq': moq,
            'price': price,
            'discounted_price': discountPrice
          });
          final updateState = ref.read(updateProductsProvider);
          if (updateState is LoadingUpdateProductState) {
            setState(() {
              isloading = updateState.isloading;
            });
          }
          if (updateState is LoadedUpdateProductState) {
            setState(() {
              isloading = updateState.isloading;
            });
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(updateState.message)));
          }
          if (updateState is ErrorUpdateProductState) {
            setState(() {
              isloading = updateState.isloading;
            });
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(updateState.message)));
          }
        } else {
          await ref.read(addProductsProvider.notifier).addProducts({
            'name': productName,
            'moq': moq,
            'price': price,
            'discounted_price': discountPrice
          });

          final addState = ref.read(addProductsProvider);
          if (addState is LoadingAddProductsState) {
            setState(() {
              isloading = addState.isloading;
            });
          }
          if (addState is LoadedAddProductsState) {
            addProductFormKey.currentState!.reset();
            setState(() {
              productName = '';
              moq = '';
              price = '';
              discountPrice = '';
              isloading = addState.isloading;
            });
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('Product added!')));
          }
          if (addState is ErrorAddProductsState) {
            setState(() {
              isloading = addState.isloading;
            });
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(addState.message)));
          }
        }
      }
    } catch (err) {
      setState(() {
        isloading = false;
      });
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Something went wrong')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(),
        body: Stack(children: [
      Positioned(
          top: 0,
          right: 0,
          child: Image.asset(
            'assets/images/unnamed.png',
            width: 180,
            height: 180,
          )),
      SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    margin: const EdgeInsets.fromLTRB(10, 30, 10, 30),
                    child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.clear,
                          size: 40,
                          weight: 600,
                        ))),
                Text(
                  widget.isEditMode ? "Edit Product" : "Add Product",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(10, 60, 10, 10),
                  child: Form(
                      key: addProductFormKey,
                      child: Column(children: [
                        InputWithLabel(
                            textStyle: const TextStyle(
                                fontSize: 16, color: Colors.black),
                            labelName: "ProductName",
                            textFormField: TextFormField(
                              initialValue:
                                  widget.isEditMode ? productName : null,
                              decoration: const InputDecoration(
                                  labelText: 'Enter Product Name'),
                              style: Theme.of(context).textTheme.headlineMedium,
                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    value.trim().length < 3) {
                                  return "Please enter at least 3 characters.";
                                }
                                return null;
                              },
                              onSaved: (newValue) {
                                setState(() {
                                  productName = newValue!;
                                });
                              },
                            )),
                        const SizedBox(height: 16),
                        InputWithLabel(
                            labelName: "MOQ",
                            textStyle: const TextStyle(
                                fontSize: 16, color: Colors.black),
                            textFormField: TextFormField(
                              initialValue: widget.isEditMode ? moq : null,
                              keyboardType: TextInputType.number,
                              decoration:
                                  const InputDecoration(labelText: 'Enter MOQ'),
                              style: Theme.of(context).textTheme.headlineMedium,
                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    value.trim().length < 2) {
                                  return "Please enter valid MOQ.";
                                }
                                return null;
                              },
                              onSaved: (newValue) {
                                setState(() {
                                  moq = newValue!;
                                });
                              },
                            )),
                        const SizedBox(height: 16),
                        InputWithLabel(
                            labelName: "Price",
                            textStyle: const TextStyle(
                                fontSize: 16, color: Colors.black),
                            textFormField: TextFormField(
                              initialValue: widget.isEditMode ? price : null,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                  labelText: 'Enter Price'),
                              style: Theme.of(context).textTheme.headlineMedium,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter price";
                                }
                                return null;
                              },
                              onSaved: (newValue) {
                                setState(() {
                                  price = newValue!;
                                });
                              },
                            )),
                        const SizedBox(height: 16),
                        InputWithLabel(
                            labelName: "Discount Price",
                            textStyle: const TextStyle(
                                fontSize: 16, color: Colors.black),
                            textFormField: TextFormField(
                              initialValue:
                                  widget.isEditMode ? discountPrice : null,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                  labelText: 'Enter Discount Price'),
                              style: Theme.of(context).textTheme.headlineMedium,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter discount price";
                                }
                                return null;
                              },
                              onSaved: (newValue) {
                                setState(() {
                                  discountPrice = newValue!;
                                });
                              },
                            )),
                        const SizedBox(height: 16),
                        Container(
                            margin: const EdgeInsets.only(top: 10),
                            width: MediaQuery.of(context).size.width * 1,
                            child: ElevatedButton(
                                onPressed:
                                    isloading ? null : onAddSubmitHandler,
                                child: isloading
                                    ? const CircularProgressIndicator()
                                    : Text(widget.isEditMode
                                        ? "Edit Product"
                                        : "Submit")))
                      ])),
                )
              ],
            ),
          ),
        ),
      )
    ]));
  }
}
