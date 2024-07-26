import 'package:flutter/material.dart';

import '../home/persentation/cubit/products_cubit.dart';
import 'components/product_search_result_list.dart';

class ProductSearchDelegate extends SearchDelegate {
  final ProductsCubit productsCubit;

  ProductSearchDelegate(this.productsCubit);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          showSuggestions(context); // Refresh suggestions when query is cleared
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isEmpty) {
      return const Center(child: Text('Please enter a search term.'));
    }

    productsCubit.search(query: query);

    return ProductSearchResults(query: query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
