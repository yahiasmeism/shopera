import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../domin/entities/cart_item.dart';
import '../components/delete_item_button.dart';
import '../cubit/cart_cubit.dart';
import 'cart_item.dart';

class CartItemSliverListView extends StatefulWidget {
  const CartItemSliverListView({super.key, required this.items});
  final List<CartItem> items;
  @override
  State<CartItemSliverListView> createState() => _CartItemSliverListViewState();
}

class _CartItemSliverListViewState extends State<CartItemSliverListView> {
  final _listKey = GlobalKey<SliverAnimatedListState>();
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CartCubit>();
    return SliverAnimatedList(
      key: _listKey,
      initialItemCount: widget.items.length,
      itemBuilder: (context, index, animation) {
        return SizeTransition(
          sizeFactor: animation,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 14),
            child: Slidable(
              key: ValueKey(index),
              endActionPane: ActionPane(
                extentRatio: .20,
                motion: const BehindMotion(),
                children: [
                  const SizedBox(width: 12),
                  DeleteItemButton(
                    onPressed: () {
                      _deleteProduct(index, cubit);
                    },
                  )
                ],
              ),
              child: CartItemWidget(item: widget.items[index]),
            ),
          ),
        );
      },
    );
  }

  _deleteProduct(int index, CartCubit cubit) {
    final removedItem = widget.items[index];
    cubit.deleteItem(removedItem.id);
    _listKey.currentState?.removeItem(
      index,
      (context, animation) => SizeTransition(
        sizeFactor: animation,
        child: CartItemWidget(
          item: removedItem,
        ),
      ),
      duration: const Duration(milliseconds: 300),
    );
  }
}
