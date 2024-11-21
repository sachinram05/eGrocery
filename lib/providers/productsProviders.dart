import 'package:egrocery/actions/productActions.dart';
import 'package:egrocery/constants/productConstants.dart';
import 'package:egrocery/models/productModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final ProductActions productActions = ProductActions();

final productsProvider = StateNotifierProvider<ProductsNotifier, ProductsState>((ref) => ProductsNotifier());

class ProductsNotifier extends StateNotifier<ProductsState> {
  ProductsNotifier() : super(InitialProductsState(isloading: true));

  List<Product> productList = [];

  void fetchProducts() async {
    try {
      List<Product> products = await productActions.getProducts();
      productList = products;
      state = ProductsLoadedState(products: products, isloading: false);
    } catch (e) {
      state = ErrorProductsState(message: e.toString(), isloading: false);
    }
  }

  void filterProducts(filterValue) {
    if (filterValue == null || filterValue.isEmpty) {
      state = ProductsLoadedState(products: productList, isloading: false);
    } else {
      List<Product> listProducts = productList.where((item) =>
              item.name.toLowerCase().contains(filterValue.toLowerCase()) ||
              item.price.toString().contains(filterValue) ||
              item.moq.toString().contains(filterValue.toLowerCase().toLowerCase()) ||
              item.discountedPrice.toString().contains(filterValue))
          .toList();

      state = ProductsLoadedState(products: listProducts, isloading: false);
    }
  }
}

final addProductsProvider = StateNotifierProvider<AddProductsNotifier, AddProductsState>((ref) => AddProductsNotifier(ref),);

class AddProductsNotifier extends StateNotifier<AddProductsState> {
  final Ref ref;
  AddProductsNotifier(this.ref) : super(LoadingAddProductsState(isloading: true));

  Future<void> addProducts(data) async {
    try {
      Map<String, Object> response = await productActions.addProduct(data);
      
      if (response['status'] == true) {
        ref.read(productsProvider.notifier).fetchProducts();
        state = LoadedAddProductsState(message: response['data'].toString(), isloading: false);
      } else {
        state = ErrorAddProductsState(message: response['data'].toString(), isloading: false);
      }
    } catch (e) {
      state = ErrorAddProductsState(message: e.toString(), isloading: false);
    }
  }
}


final updateProductsProvider = StateNotifierProvider<UpdateProductsNotifier, UpdateProductState>((ref) => UpdateProductsNotifier(ref));

class UpdateProductsNotifier extends StateNotifier<UpdateProductState> {
  final Ref ref;
  UpdateProductsNotifier(this.ref) : super(LoadingUpdateProductState(isloading: true));

  Future<void> updateProducts(data) async {
    try {
      Map<String, Object> response = await productActions.updateProduct(data);

      if (response['status'] == true) {
        ref.read(productsProvider.notifier).fetchProducts();
        state = LoadedUpdateProductState(message: response['data'].toString(), isloading: false);
      } else {
        state = ErrorUpdateProductState(message: response['data'].toString(), isloading: false);
      }
    } catch (e) {
      state = ErrorUpdateProductState(message: e.toString(), isloading: false);
    }
  }
}

final deleteProductsProvider = StateNotifierProvider<DeleteProductsNotifier, DeleteProductState>((ref) => DeleteProductsNotifier(ref));

class DeleteProductsNotifier extends StateNotifier<DeleteProductState> {
  final Ref ref;
  DeleteProductsNotifier(this.ref) : super(LoadingDeleteProductState(isloading: true));

  Future<void> deleteProducts(id) async {
    try {
      Map<String, Object> response = await productActions.deleteProduct(id);

      if (response['status'] == true) {
        ref.read(productsProvider.notifier).fetchProducts();
        state = LoadedDeleteProductState(message: response['data'].toString(), isloading: false);
      } else {
        state = ErrorDeleteProductState(message: response['data'].toString(), isloading: false);
      }
    } catch (e) {
      state = ErrorDeleteProductState(message: e.toString(), isloading: false);
    }
  }
}
