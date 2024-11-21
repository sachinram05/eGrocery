import 'package:egrocery/models/productModel.dart';
import 'package:flutter/material.dart';

//Product
@immutable
abstract class ProductsState {}

class InitialProductsState extends ProductsState {
  InitialProductsState({required this.isloading});
  final bool isloading;
}

class ProductsLoadedState extends ProductsState {
  ProductsLoadedState({required this.products, required this.isloading});
  final List<Product> products;
  final bool isloading;
}

class ErrorProductsState extends ProductsState {
  ErrorProductsState({required this.message, required this.isloading});
  final String message;
  final bool isloading;
}

@immutable
abstract class AddProductsState {}

class LoadingAddProductsState extends AddProductsState {
  LoadingAddProductsState({required this.isloading});
  final bool isloading;
}

class LoadedAddProductsState extends AddProductsState {
  LoadedAddProductsState({required this.message, required this.isloading});
  final String message;
  final bool isloading;
}

class ErrorAddProductsState extends AddProductsState {
  ErrorAddProductsState({required this.message, required this.isloading});
  final String message;
  final bool isloading;
}


// updateProduct
@immutable
abstract class UpdateProductState {}

class LoadingUpdateProductState extends UpdateProductState {
  LoadingUpdateProductState({required this.isloading});
  final bool isloading;
}

class LoadedUpdateProductState extends UpdateProductState {
  LoadedUpdateProductState({required this.message, required this.isloading});
  final String message;
  final bool isloading;
}

class ErrorUpdateProductState extends UpdateProductState {
  ErrorUpdateProductState({required this.message, required this.isloading});
  final String message;
  final bool isloading;
}


// deleteProduct
@immutable
abstract class DeleteProductState {}

class LoadingDeleteProductState extends DeleteProductState {
  LoadingDeleteProductState({required this.isloading});
  final bool isloading;
}

class LoadedDeleteProductState extends DeleteProductState {
  LoadedDeleteProductState({required this.message, required this.isloading});
  final String message;
  final bool isloading;
}

class ErrorDeleteProductState extends DeleteProductState {
  ErrorDeleteProductState({required this.message, required this.isloading});
  final String message;
  final bool isloading;
}
