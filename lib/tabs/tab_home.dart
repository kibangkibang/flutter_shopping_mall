import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_shopping_mall/models/model_item.dart';
import 'package:flutter_shopping_mall/models/model_item_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:carousel_slider/carousel_slider.dart';

List<String> categories = ["test1", "test2", "test3", "test4"];

class HomeTab extends StatefulWidget {
  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int _current = 0;
  final CarouselController _controller = CarouselController();
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
                  child: DefaultTabController(
                      length: categories.length,
                      child: PreferredSize(
                          child: Container(
                            child: TabBar(
                              tabs: List.generate(
                                  categories.length,
                                  (index) => Tab(
                                        text: categories[index],
                                      )),
                              labelColor: Colors.indigo,
                              unselectedLabelColor: Colors.black45,
                            ),
                          ),
                          preferredSize: Size.fromHeight(42)))),
              Container(
                  child: CarouselSlider(
                carouselController: _controller,
                options: CarouselOptions(
                    enlargeCenterPage: true,
                    height: 180.0,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 5),
                    autoPlayAnimationDuration: Duration(milliseconds: 1500),
                    onPageChanged: (index, reason) {
                      setState(() {
                        _current = index;
                      });
                    }),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: itemProvider.items.asMap().entries.map((entry) {
                  return GestureDetector(
                    onTap: () => _controller.animateToPage(entry.key),
                    child: Container(
                      width: 12.0,
                      height: 12.0,
                      margin:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: (Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.white
                                  : Colors.black)
                              .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                    ),
                  );
                }).toList(),
              ),
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
