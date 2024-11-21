import 'package:egrocery/constants/productConstants.dart';
import 'package:egrocery/models/productModel.dart';
import 'package:egrocery/providers/productsProviders.dart';
import 'package:egrocery/widgets/addProduct.dart';
import 'package:egrocery/widgets/searchTitle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductListScreen extends ConsumerStatefulWidget {
  const ProductListScreen({super.key});

  @override
  ConsumerState<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends ConsumerState<ProductListScreen> {
  bool isloading = false;
  String selectedId = '';
  @override
  void initState() {
    ref.read(productsProvider.notifier).fetchProducts();
    super.initState();
  }

  void onDeletedHandler(id) async {
    try {
      selectedId = id.toString();
      setState(() {
        isloading = true;
        selectedId = selectedId;
      });
      await ref
          .read(deleteProductsProvider.notifier)
          .deleteProducts(selectedId);
      final deleteState = ref.read(deleteProductsProvider);
      if (deleteState is LoadingDeleteProductState) {
        setState(() {
          isloading = deleteState.isloading;
        });
      }
      if (deleteState is LoadedDeleteProductState) {
        setState(() {
          isloading = deleteState.isloading;
          selectedId = '';
        });
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(deleteState.message)));
      }
      if (deleteState is ErrorDeleteProductState) {
        setState(() {
          isloading = deleteState.isloading;
          selectedId = '';
        });
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(deleteState.message)));
      }
      setState(() {
        isloading = false;
        selectedId = '';
      });
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
    ProductsState productdataState = ref.watch(productsProvider);

    if (productdataState is InitialProductsState) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    if (productdataState is ErrorProductsState) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Something went wrong')));
      return const Center(
          child: Text(
        "Products not found,Retry!",
      ));
    }
    if (productdataState is ProductsLoadedState) {
      return buildProductList(productdataState);
    }

    return const Text("Product is empty");
  }

  Widget buildProductList(ProductsLoadedState productDataState) {
    List<Product> totalProducts = productDataState.products;

    onChangeHandler(value) {
      ref.read(productsProvider.notifier).filterProducts(value);
    }

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SearchTitle(
              title: 'Product Listing', onChangeHandler: onChangeHandler),
          totalProducts.isEmpty
              ? Expanded(
                  child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                     Text("Products not found!",style:Theme.of(context).textTheme.headlineMedium),
                    TextButton(
                      
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const AddProduct(isEditMode: false)));
                        },
                         child: const Text('+ Add product'))
                  ],
                )))
              : Expanded(
                  child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: totalProducts.length,
                      itemBuilder: (context, index) {
                        Product product = totalProducts[index];
                        return Column(
                          children: [
                            Card(
                              elevation: 0,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.4,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("Product Name : ${product.name}",
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium),
                                          Text("MOQ : ${product.moq}",
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium)
                                        ],
                                      ),
                                    ),
                                    Container(
                                        height: 40,
                                        padding:
                                            EdgeInsets.fromLTRB(0, 0, 20, 0),
                                        child: const VerticalDivider(
                                          width: 4,
                                          color: Color.fromARGB(
                                              255, 105, 103, 103),
                                        )),
                                    SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.4,
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.24,
                                                      child: Text(
                                                        "Price : ${product.price}",
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyMedium,
                                                      )),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      GestureDetector(
                                                          onTap: () {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            AddProduct(
                                                                              isEditMode: true,
                                                                              productId: product.id.toString(),
                                                                              productName: product.name,
                                                                              moq: product.moq.toString(),
                                                                              price: product.price.toString(),
                                                                              discountPrice: product.discountedPrice.toString(),
                                                                            )));
                                                          },
                                                          child: const Icon(
                                                              Icons.edit)),
                                                      GestureDetector(
                                                          onTap: () async {
                                                            await showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) =>
                                                                        AlertDialog(
                                                                          //
                                                                          title:
                                                                              Text(
                                                                            "Delete Product",
                                                                            style:
                                                                                Theme.of(context).textTheme.titleSmall,
                                                                          ),
                                                                          content: Text(
                                                                              'Are you sure you want to delete this product?',
                                                                              style: Theme.of(context).textTheme.headlineMedium),
                                                                          actions: [
                                                                            TextButton(
                                                                                onPressed: () {
                                                                                  Navigator.of(context).pop();
                                                                                },
                                                                                child: const Text(
                                                                                  "Cancel",
                                                                                  style: TextStyle(color: Color.fromARGB(255, 61, 60, 59)),
                                                                                )),
                                                                            TextButton(
                                                                                onPressed: () {
                                                                                  Navigator.of(context).pop();
                                                                                  onDeletedHandler(product.id);
                                                                                },
                                                                                child: const Text(
                                                                                  "Delete",
                                                                                  style: TextStyle(color: Color.fromARGB(255, 186, 38, 28)),
                                                                                ))
                                                                          ],
                                                                        ));
                                                          },
                                                          child: isloading &&
                                                                  selectedId ==
                                                                      product.id
                                                                          .toString()
                                                              ? const SizedBox(
                                                                  width: 12,
                                                                  height: 12,
                                                                  child:
                                                                      CircularProgressIndicator(
                                                                    strokeWidth:
                                                                        3,
                                                                  ))
                                                              : const Icon(
                                                                  Icons.delete))
                                                    ],
                                                  )
                                                ],
                                              ),
                                              Text(
                                                  "Discount Price : ${product.discountedPrice}",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium)
                                            ]))
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            )
                          ],
                        );
                      }),
                ),
        ],
      ),
    );
  }
}
