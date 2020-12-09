import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoppinglist/constants.dart';
import 'package:shoppinglist/widgets/shop_list.dart';
import 'add_shop_item.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shoppinglist/models/item.dart';

class ShopScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorBlack,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              backgroundColor: Colors.transparent,
              context: context,
              isScrollControlled: true,
              builder: (context) => SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: AddShopItem(),
                    ),
                  ));
        },
        backgroundColor: kColorBlack,
        child: Icon(
          Icons.add,
          color: kColorYellow,
          size: 36.0,
        ),
      ),
      appBar: AppBar(
        backgroundColor: kColorBlack,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'Мои покупки',
              style: GoogleFonts.montserrat(
                  textStyle: kTextStyleBold, fontSize: 24.0),
            ),
            GestureDetector(
              onLongPress: () {
                Hive.box<ShopListItem>('shop').clear();
              },
              child: ValueListenableBuilder(
                  valueListenable: Hive.box<ShopListItem>('shop').listenable(),
                  builder: (context, Box<ShopListItem> box, _) {
                    return Text(
                      '${Hive.box<ShopListItem>('shop').values.where((isDone) => isDone.isDone).length} из ${Hive.box<ShopListItem>('shop').values.length}',
                      style: GoogleFonts.montserrat(
                        textStyle: kTextStyleReg,
                        fontSize: 20.0,
                        color:
                            (Hive.box<ShopListItem>('shop').values.length == 0
                                ? Colors.transparent
                                : Colors.white),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
      body: ShopList(),
    );
  }
}
