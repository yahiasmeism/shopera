import 'package:flutter/material.dart';
import 'package:shopera/features/orders/data/models/order_model.dart';
import 'package:shopera/features/orders/presentation/components/order_details_widget.dart';

class OrderDetailsPage extends StatelessWidget {
  const OrderDetailsPage({super.key});

  static const routeName = 'orderDetails';

  @override
  Widget build(BuildContext context) {
    final OrderModel order = ModalRoute.of(context)?.settings.arguments as OrderModel;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Details'),
      ),
      body: SingleChildScrollView(child: Padding(padding: const EdgeInsets.all(16.0), child: OrderDetailsWidget(order: order))),
    );
  }
}
