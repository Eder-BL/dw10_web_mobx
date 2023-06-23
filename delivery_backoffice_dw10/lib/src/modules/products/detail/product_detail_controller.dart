import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:mobx/mobx.dart';

import '../../../models/product_model.dart';
import '../../../repositories/products/products_repository.dart';

part 'product_detail_controller.g.dart';

enum ProductDetailStateStatus {
  initial,
  loading,
  loaded,
  error,
  errorLoadProduct,
  deleted,
  uploaded,
  saved,
}

class ProductDetailController = ProductDetailControllerBase with _$ProductDetailController;

abstract class ProductDetailControllerBase with Store {
  final ProductsRepository _productsRepository;

  ProductDetailControllerBase(this._productsRepository);

  @readonly
  var _status = ProductDetailStateStatus.initial;

  @readonly
  String? _errorMessage;

  @readonly
  String? _imagePath;

  @action
  Future<void> uploadImageProduct(Uint8List file, String fileName) async {
    _status = ProductDetailStateStatus.loading;
    try {
      _imagePath = await _productsRepository.uploadImageProduct(file, fileName);
      _status = ProductDetailStateStatus.uploaded;
    } on PlatformException catch (e) {
      _errorMessage = e.message;
      _status = ProductDetailStateStatus.error;
    }
  }

  @action
  Future<void> save(String name, double price, String description) async {
    try {
      _status = ProductDetailStateStatus.loading;
      final productModel = ProductModel(
        name: name,
        description: description,
        price: price,
        image: _imagePath!,
        enabled: true,
      );
      await _productsRepository.save(productModel);
      _status = ProductDetailStateStatus.saved;
    } on PlatformException catch (e, s) {
      log('Erro ao salvar produto', error: e, stackTrace: s);
      _errorMessage = e.message;
      _status = ProductDetailStateStatus.error;
    }
  }
}
