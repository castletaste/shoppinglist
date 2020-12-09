import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shoppinglist/models/item.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shoppinglist/widgets/shop_item.dart';
import 'package:google_fonts/google_fonts.dart';

int doneCount = 0;

class ShopList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box<ShopListItem>('shop').listenable(),
      builder: (context, Box<ShopListItem> box, _) {
        if (box.values.isEmpty)
          return Container(
            padding: EdgeInsets.only(top: 50.0),
            child: Center(
              child: Text(
                "Список покупок еще пуст :)",
                style: TextStyle(color: Colors.white, fontSize: 16.0),
              ),
            ),
          );

        return ListView(children: [
          // ListTile(
          //   title: Text(
          //     'Сортировать по убыванию',
          //     style: GoogleFonts.montserrat(
          //       color: Colors.white,
          //       textStyle: TextStyle(fontWeight: FontWeight.w300),
          //     ),
          //   ),
          // ),
          ListView.builder(
            itemCount: box.values.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            reverse: false,
            itemBuilder: (context, index) {
              ShopListItem res = box.getAt(index);
              return Dismissible(
                key: UniqueKey(),
                onDismissed: (direction) {
                  res.delete();
                },
                background: Container(),
                child: ShopItem(
                  itemTitle: res.name,
                  isChecked: res.isDone,
                  checkboxCallback: (checkboxState) {
                    res.isDone = !res.isDone;
                    res.save();
                  },
                  onTapCallback: () {
                    res.isDone = !res.isDone;
                    res.save();
                  },
                ),
              );
            },
          ),
        ]);
      },
    );
  }
}
