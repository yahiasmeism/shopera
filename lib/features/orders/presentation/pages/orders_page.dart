import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shopera/core/constants/colors.dart';
import 'package:shopera/features/orders/presentation/cubit/orders_cubit.dart';
import 'package:shopera/features/orders/presentation/pages/order_details_page.dart';

import '../components/order_tile.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});
  static const routeName = 'OrdersPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
      ),
      body: BlocBuilder<OrdersCubit, OrdersState>(
        builder: (context, state) {
          if (state is OrderLoaded) {
            if (state.loading) {
              return const Center(
                child: SpinKitWaveSpinner(color: AppColors.primaryColor),
              );
            }
            return ListView.builder(
              itemCount: state.orders.length,
              itemBuilder: (context, index) {
                final order = state.orders.reversed.toList()[index];
                return OrderTile(
                  order: order,
                  onTap: () {
                    Navigator.pushNamed(context, OrderDetailsPage.routeName, arguments: order);
                  },
                );
              },
            );
          } else {
            return const Center(
              child: Text('No orders found'),
            );
          }
        },
      ),
    );
  }
}
