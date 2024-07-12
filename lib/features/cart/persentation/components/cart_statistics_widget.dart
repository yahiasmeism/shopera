
import 'package:flutter/material.dart';
import 'package:shopera/core/constants/colors.dart';
import '../../../../core/widgets/hr_dashed_divider.dart';
import '../../domin/entities/cart_entity.dart';

class CartStatisticsWidget extends StatelessWidget {
  const CartStatisticsWidget({
    super.key,
    required this.cart,
  });
  final CartEntity? cart;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(14),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(10, 0, 0, 0),
            offset: Offset(0, 1),
            blurRadius: 3,
            spreadRadius: 2,
          )
        ],
        color: Colors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Text(
              'Select Item:',
              style: TextStyle(color: AppColors.subtitleTextColor),
            ),
            trailing: Text(
              '${cart?.totalQuantity ?? 0}', //!---------------
              style: const TextStyle(fontSize: 18),
            ),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Text(
              'Subtotal:',
              style: TextStyle(color: AppColors.subtitleTextColor),
            ),
            trailing: Text(
              "\$${(cart?.total ?? 0).toStringAsFixed(2)}",
              style: const TextStyle(fontSize: 18),
            ),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Text(
              'Discount(%${calculateDiscountPercentage.round()}):',
              style: const TextStyle(color: AppColors.subtitleTextColor),
            ),
            trailing: Text(
              "\$${(discountedAmount).toStringAsFixed(2)}",
              style: const TextStyle(fontSize: 18),
            ),
          ),
          const HrDashedDivider(dashSize: 2),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Text(
              'Total:',
              style: TextStyle(color: AppColors.subtitleTextColor),
            ),
            trailing: Text(
              "\$${(cart?.discountedTotal ?? 0).toStringAsFixed(2)}",
              style: const TextStyle(
                fontSize: 24,
                color: AppColors.primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  double get calculateDiscountPercentage {
    if (cart == null || cart!.total == 0) return 0.0;

    double discount = cart!.total - cart!.discountedTotal;
    double discountPercentage = (discount / cart!.total) * 100;
    return discountPercentage;
  }

  double get discountedAmount {
    if (cart == null || cart!.total == 0) return 0.0;

    return cart!.total * (calculateDiscountPercentage / 100);
  }
}
