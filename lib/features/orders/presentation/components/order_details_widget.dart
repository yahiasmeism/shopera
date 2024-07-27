import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shopera/core/constants/colors.dart';
import 'package:shopera/core/widgets/hr_dashed_divider.dart';
import 'package:shopera/features/orders/data/models/order_model.dart';

class OrderDetailsWidget extends StatelessWidget {
  const OrderDetailsWidget({
    super.key,
    required this.order,
  });

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    final itemsCount = order.items.fold(0, (sum, item) => sum + item.quantity);
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Order Summary',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
            ),
            const SizedBox(height: 20),
            ...List<Widget>.generate(
              order.items.length,
              (index) {
                final item = order.items[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${item.quantity}x',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(width: 10),
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 250),
                        child: Text(
                          item.title,
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '\$${(item.price * item.quantity).toStringAsFixed(2)}',
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.primaryColor),
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            const Divider(thickness: 2, color: AppColors.primaryColor),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.confirmation_number, color: AppColors.subtitleTextColor),
              title: const Text('Order No.', style: TextStyle(fontSize: 18, color: AppColors.subtitleTextColor)),
              trailing: Text(
                order.orderNo,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.event, color: AppColors.subtitleTextColor),
              title: const Text('Count', style: TextStyle(fontSize: 18, color: AppColors.subtitleTextColor)),
              trailing: Text(
                "$itemsCount",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.date_range, color: AppColors.subtitleTextColor),
              title: const Text('Created At', style: TextStyle(fontSize: 18, color: AppColors.subtitleTextColor)),
              trailing: Text(
                DateFormat.yMMMd().add_jm().format(order.createAt),
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const HrDashedDivider(dashSize: 2),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.attach_money, color: AppColors.subtitleTextColor),
              title: const Text('Total', style: TextStyle(fontSize: 24, color: AppColors.subtitleTextColor)),
              trailing: Text(
                "\$${order.total.toStringAsFixed(2)}",
                style: const TextStyle(fontSize: 24, color: AppColors.primaryColor, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
