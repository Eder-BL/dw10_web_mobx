import 'package:flutter/material.dart';

enum OrderStatus {
  pendente('Pendente', 'P', Colors.blue),
  confirmado('Confirmado', 'C', Colors.green),
  finalizado('Finalizado', 'F', Colors.black),
  rejeitado('Rejeitado', 'R', Colors.red),
  cancelado('Cancelado', 'X', Colors.red);

  final String name;
  final String acronym;
  final Color color;

  const OrderStatus(this.name, this.acronym, this.color);

  static OrderStatus parse(String acronym) {
    return OrderStatus.values.firstWhere((element) => element.acronym == acronym);
  }
}
