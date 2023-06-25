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
  final ProductsRepository _productRepository;

  @readonly
  var _status = ProductDetailStateStatus.initial;

  @readonly
  String? _errorMessage;

  @readonly
  String? _imagePath;

  @readonly
  ProductModel? _productModel;

  ProductDetailControllerBase(this._productRepository);

  @action
  Future<void> uploadImageProduct(Uint8List file, String fileName) async {
    _status = ProductDetailStateStatus.loading;
    _imagePath = await _productRepository.uploadImageProduct(file, fileName);
    _status = ProductDetailStateStatus.uploaded;
  }

  @action
  Future<void> save(String name, double price, String description) async {
    try {
      _status = ProductDetailStateStatus.loading;
      final productModel = ProductModel(
        id: _productModel?.id,
        name: name,
        description: description,
        price: price,
        enabled: _productModel?.enabled ?? true,
        image: _imagePath!,
      );

      await _productRepository.save(productModel);
      _status = ProductDetailStateStatus.saved;
    } catch (e, s) {
      log('Erro ao salvar o produto', error: e, stackTrace: s);
      _status = ProductDetailStateStatus.error;
      _errorMessage = 'Erro ao salvar o produto';
    }
  }

  @action
  Future<void> loadProduct(int? id) async {
    try {
      _status = ProductDetailStateStatus.loading;
      _productModel = null;
      _imagePath = null;
      if (id != null) {
        _productModel = await _productRepository.getProduct(id);
        _imagePath = _productModel!.image;
      }
      _status = ProductDetailStateStatus.loaded;
    } catch (e, s) {
      log('Erro ao carregar produto', error: e, stackTrace: s);
      _status = ProductDetailStateStatus.errorLoadProduct;
    }
  }

  Future<void> deleteProduct() async {
    try {
      _status = ProductDetailStateStatus.loading;

      if (_productModel != null && _productModel!.id != null) {
        _productRepository.deleteProduct(_productModel!.id!);
        _status = ProductDetailStateStatus.deleted;
      }
      await Future.delayed(Duration.zero);
      _status = ProductDetailStateStatus.error;
      _errorMessage = 'Produto nao cadastrado, não foi possivel deletar!';
    } catch (e, s) {
      log('Erro ao Deletar produto', error: e, stackTrace: s);
      _status = ProductDetailStateStatus.errorLoadProduct;
      _errorMessage = 'Produto não cadastrado, não foi possivel deletar!';
    }
  }
}
