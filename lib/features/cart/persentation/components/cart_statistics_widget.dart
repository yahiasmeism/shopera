import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/hr_dashed_divider.dart';
import '../../domin/entities/cart.dart';

class CartStatisticsWidget extends StatelessWidget {
  const CartStatisticsWidget({
    super.key,
    required this.cart,
  });
  final Cart? cart;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(14),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
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
