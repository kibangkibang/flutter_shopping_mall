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
          return Column(children: [
            Container(
                padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                child: CarouselSlider(
                  options: CarouselOptions(height: 200.0),
                  items: itemProvider.items.map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(color: Colors.grey),
                            child: Text(
                              i.title,
                              style: TextStyle(fontSize: 16.0),
                            ));
                      },
                    );
                  }).toList(),
                )),
            Expanded(
              child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 1 / 1.5),
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
            ),
          ]);
        }
      },
    );
  }
}
