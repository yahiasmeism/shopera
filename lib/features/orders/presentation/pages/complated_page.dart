import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shopera/core/constants/colors.dart';
import 'package:shopera/core/utils/nav_bar_cubit.dart';
import 'package:shopera/core/widgets/button_primary.dart';
import 'package:shopera/features/orders/presentation/cubit/orders_cubit.dart';

import 'orders_page.dart';

class CompletedCreateOrderPage extends StatelessWidget {
  const CompletedCreateOrderPage({super.key});

  void _goToHome(BuildContext context) {
    Navigator.of(context).pop();
    context.read<NavigationBarCubit>().navigateTo(NavigationBarState.home);
  }

  static const routeName = 'complatedCreateOrderPage';

  void _goToOrders(BuildContext context) {
    Navigator.pushReplacementNamed(context, OrdersPage.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<OrdersCubit, OrdersState>(
        builder: (context, state) {
          if (state is OrderLoaded) {
            if (state.loading) {
              return const Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SpinKitWaveSpinner(
                      color: AppColors.primaryColor,
                    ),
                    SizedBox(height: 12),
                    Text('Creating your order, please wait...')
                  ],
                ),
              );
            }
            return Stack(
              children: [
                const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 200.0,
                      ),
                      SizedBox(height: 20.0),
                      Text(
                        'Order Successful',
                        style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: PrimaryButton(
                            onPressed: () => _goToHome(context),
                            labelText: 'Go to Home',
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: PrimaryButton(
                            onPressed: () => _goToOrders(context),
                            labelText: 'Go to Orders',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
