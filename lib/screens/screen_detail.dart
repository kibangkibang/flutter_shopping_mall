import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shopping_mall/models/model_item.dart';
import 'package:intl/intl.dart';

class DetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var f = NumberFormat('###,###,###,###');
    final item = ModalRoute.of(context)!.settings.arguments as Item;
    return Scaffold(
      appBar: AppBar(
        title: Text('상세보기'),
      ),
      body: Center(
        child: Container(
          child: ListView(
            children: [
              Image.network(item.imageUrl),
              Padding(padding: EdgeInsets.all(3)),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                padding: EdgeInsets.fromLTRB(15, 5, 15, 15),
                child: Text(
                  item.title,
                  style:
                      TextStyle(fontSize: 17.sp, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(f.format(item.price) + '원'),
                        Text('출판사 : ' + item.brand),
                        Text('출판일 : ' + item.registerDate),
                      ],
                    ),
                    InkWell(
                      onTap: () {},
                      child: Column(
                        children: [
                          Icon(
                            Icons.add,
                            color: Colors.red,
                          ),
                          Text(
                            '담기',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(15),
                child: Text(item.description),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
