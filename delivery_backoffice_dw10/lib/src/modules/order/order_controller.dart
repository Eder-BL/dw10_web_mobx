import 'dart:developer';

import 'package:mobx/mobx.dart';

import '../../models/orders/order_model.dart';
import '../../models/orders/order_status.dart';
import '../../repositories/order/order_repository.dart';
part 'order_controller.g.dart';

enum OrderStateStatus {
  initial,
  loading,
  loaded,
  error,
}

class OrderController = OrderControllerBase with _$OrderController;

abstract class OrderControllerBase with Store {
  final OrderRepository _orderRepository;

  @readonly
  var _status = OrderStateStatus.initial;

  late final DateTime _today;

  @readonly
  OrderStatus? _statusFilter;

  @readonly
  var _orders = <OrderModel>[];

  @readonly
  String? _errorMessage;

  OrderControllerBase(this._orderRepository) {
    final todayNow = DateTime.now();
    _today = DateTime(todayNow.year, todayNow.month, todayNow.day);
  }

  @action
  Future<void> findOrders() {
    _status = OrderStateStatus.loading;
    return _orderRepository.findAllOrders(_today, _statusFilter).then(
      (orders) {
        _orders = orders;
        _status = OrderStateStatus.loaded;
      },
      onError: (e, s) {
        log(
          'Erro ao buscar pedidos do dia',
          error: e,
          stackTrace: s,
        );
        _status = OrderStateStatus.error;
        _errorMessage = 'Erro ao buscar pedidos do dia';
      },
    );
  }
}
