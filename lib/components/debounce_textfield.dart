import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_shopping_mall/models/model_item_provider.dart';
import 'package:flutter_shopping_mall/models/model_query.dart';
import 'package:provider/provider.dart';

import '../models/model_item_provider.dart';

class DebounceTextField extends StatefulWidget {
  @override
  State<DebounceTextField> createState() => _DebounceTextField();
}

class _DebounceTextField extends State<DebounceTextField> {
  final _searchQuery = new TextEditingController();
  Timer? _debounce;
  String searchText = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _searchQuery.addListener(_onSearchChanged);
  }

  @override
  Widget build(BuildContext context) {
    final itemProvider = Provider.of<ItemProvider>(context, listen: false);
    final searchQuery = Provider.of<SearchQuery>(context, listen: false);
    return WillPopScope(
        onWillPop: () async {
          itemProvider.searchItems = [];
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            title: Column(
              children: [
                TextField(
                  autofocus: true,
                  controller: _searchQuery,
                  decoration: InputDecoration(
                    hintText: '검색어를 입력하세요.',
                    border: InputBorder.none,
                  ),
                  maxLines: 1,
                  cursorColor: Colors.grey,
                  cursorWidth: 1.5,
                ),
              ],
            ),
            actions: [
              IconButton(
                onPressed: _onSearchChanged,
                icon: Icon(Icons.search_rounded),
              )
            ],
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.black),
          ),
          body: ListView.separated(
            itemBuilder: (context, index) {
              return InkWell(
                child: ListTile(
                  title: Text(itemProvider.searchItems[index].title),
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/detail',
                      arguments: itemProvider.searchItems[index]);
                },
              );
            },
            itemCount: itemProvider.searchItems.length,
            separatorBuilder: (BuildContext context, int index) {
              return Divider();
            },
          ),
        ));
  }

  _onSearchChanged() {
    final searchQuery = Provider.of<SearchQuery>(context, listen: false);
    final itemProvider = Provider.of<ItemProvider>(context, listen: false);
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(
      const Duration(milliseconds: 250),
      () {
        if (_searchQuery.text == '') {
          itemProvider.getItems();
        }
        searchQuery.updateText(_searchQuery.text);
        itemProvider.search(_searchQuery.text);
      },
    );
  }

  @override
  void dispose() {
    _searchQuery.removeListener(_onSearchChanged);
    _searchQuery.dispose();
    _debounce?.cancel();
    super.dispose();
  }
}
