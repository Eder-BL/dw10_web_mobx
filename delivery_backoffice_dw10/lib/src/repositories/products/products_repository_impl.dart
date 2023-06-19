import 'dart:developer';

import 'package:dio/dio.dart';

import '../../core/rest_client/custom_dio.dart';
import '../../models/product_model.dart';
import 'dart:typed_data';

import 'products_repository.dart';

class ProductsRepositoryImpl implements ProductsRepository {
  final CustomDio _dio;

  ProductsRepositoryImpl(this._dio);

  @override
  Future<void> deleteProduct(int id) async {
    try {
      await _dio.auth().put(
        '/products/$id',
        data: {
          'enabled': false,
        },
      );
    } on DioError catch (e, s) {
      log('Erro ao desabilitar produto', error: e, stackTrace: s);
      throw Exception('Erro ao desabilitar produto');
    }
  }

  @override
  Future<List<ProductModel>> findAll(String? name) async {
    try {
      final productResult = await _dio.auth().get(
        '/products',
        queryParameters: {
          if (name != null) 'name': name,
          'enabled': true,
        },
      );

      final products =
          productResult.data.map<ProductModel>((p) => ProductModel.fromMap(p)).toList();

      return products;
    } on DioError catch (e, s) {
      log('Erro ao buscar produtos', error: e, stackTrace: s);
      throw Exception('Erro ao buscar produtos');
    }
  }

  @override
  Future<ProductModel> getProduct(int id) async {
    try {
      final productResult = await _dio.auth().get(
            '/products/$id',
          );

      return ProductModel.fromMap(productResult.data);
    } on DioError catch (e, s) {
      log('Erro ao buscar produtos', error: e, stackTrace: s);
      throw Exception('Erro ao buscar produtos');
    }
  }

  @override
  Future<void> save(ProductModel product) {
    try {
      final client = _dio.auth();
      if (product.id != null) {
        return client.put(
          '/products/${product.id}',
          data: product.toMap(),
        );
      } else {
        return client.post(
          '/products',
          data: product.toMap(),
        );
      }
    } on DioError catch (e, s) {
      log('Erro ao salvar produto', error: e, stackTrace: s);
      throw Exception('Erro ao salvar produto');
    }
  }

  @override
  Future<String> uploadImageProduct(Uint8List file, String fileName) {
    try {
      final formData = FormData.fromMap({
        'file': MultipartFile.fromBytes(
          file,
          filename: fileName,
        ),
      });

      return _dio.auth().post('/uploads', data: formData).then((value) => value.data['url']);
    } on DioError catch (e, s) {
      log('Erro ao fazer upload da imagem', error: e, stackTrace: s);
      throw Exception('Erro ao fazer upload da imagem');
    }
  }
}
