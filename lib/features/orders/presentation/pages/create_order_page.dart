// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopera/core/widgets/button_primary.dart';
import 'package:shopera/features/orders/data/models/order_model.dart';
import 'package:shopera/features/orders/presentation/cubit/orders_cubit.dart';
import 'package:shopera/features/orders/presentation/pages/complated_page.dart';

import '../../../cart/persentation/cubit/cart_cubit.dart';
import '../components/order_details_widget.dart';

class CreateOrderPage extends StatelessWidget {
  const CreateOrderPage({super.key});

  static const routeName = 'create orders';

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<OrdersCubit>();
    final OrderModel order = ModalRoute.of(context)?.settings.arguments as OrderModel;
    // var itemsCount = ;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Order'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: OrderDetailsWidget(order: order)),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: PrimaryButton(
                    labelText: 'Submit Order',
                    onPressed: () async {
                      if (await context.read<CartCubit>().removeCart()) {
                        Navigator.pushReplacementNamed(context, CompletedCreateOrderPage.routeName);
                        cubit.createOrder(order);
                      }
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
