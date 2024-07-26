import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopera/core/services/service_locator.dart';
import 'package:shopera/features/search/cubit/search_cubit.dart';

import '../../home/persentation/cubit/products_cubit.dart';
import 'product_search_result_list.dart';

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


    return BlocProvider(
      create: (context) => SearchCubit(AppDep.sl())..search(query: query),
      child: ProductSearchResults(query: query),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
