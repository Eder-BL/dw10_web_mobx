import 'package:flutter/material.dart';

import 'widgets/order_header.dart';
import 'widgets/order_item.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        return Container(
          padding: const EdgeInsets.only(top: 40),
          child: Column(
            children: [
              const OrderHeader(),
              const SizedBox(
                height: 50,
              ),
              Expanded(
                child: GridView.builder(
                  itemCount: 10,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    mainAxisExtent: 91,
                    maxCrossAxisExtent: 600,
                  ),
                  itemBuilder: (context, index) {
                    return const OrderItem();
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
