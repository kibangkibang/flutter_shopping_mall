import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_shopping_mall/models/model_item_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var f = NumberFormat('###,###,###,###');
    final itemProvider = Provider.of<ItemProvider>(context);
    return FutureBuilder(
      future: itemProvider.fetchItems(),
      builder: (context, snapshot) {
        if (itemProvider.items.length == 0) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return ListView(
            shrinkWrap: true,
            children: [
              Container(
                  child: CarouselSlider(
                options: CarouselOptions(
                  enlargeCenterPage: true,
                  height: 200.0,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 5),
                  autoPlayAnimationDuration: Duration(milliseconds: 1500),
                ),
                items: itemProvider.items.map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'VOO',
                                style: TextStyle(fontSize: 20),
                              ),
                              Text('data'),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              )),
              Padding(padding: EdgeInsets.fromLTRB(0, 15, 0, 15)),
              GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 1 / 1.4),
                  itemCount: itemProvider.items.length,
                  itemBuilder: (context, index) {
                    return GridTile(
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/detail',
                              arguments: itemProvider.items[index]);
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(itemProvider.items[index].imageUrl),
                              Text(
                                itemProvider.items[index].title,
                                style: TextStyle(fontSize: 18),
                              ),
                              Text(
                                f.format(itemProvider.items[index].price) + '원',
                                style:
                                    TextStyle(fontSize: 16, color: Colors.red),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ],
          );
        }
      },
    );
  }
}
