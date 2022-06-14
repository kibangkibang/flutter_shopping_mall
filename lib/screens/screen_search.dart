import 'package:flutter/material.dart';
import 'package:flutter_shopping_mall/components/debounce_textfield.dart';
import 'package:flutter_shopping_mall/models/model_item_provider.dart';
import 'package:flutter_shopping_mall/models/model_query.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final item = Provider.of<ItemProvider>(context);
    final searchQuery = Provider.of<SearchQuery>(context);
    return DebounceTextField();
  }
}
