import 'package:flutter/material.dart';
import 'package:shoppinglist/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoppinglist/models/item.dart';
import 'package:hive/hive.dart';

String newItemTitle;

class AddShopItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
          color: kColorBlack,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text('Запиши продукт',
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                fontSize: 20.0,
                color: Colors.white,
                fontWeight: FontWeight.w700,
              )),
          Container(
            margin: EdgeInsets.symmetric(vertical: 5.0),
            child: TextField(
              onChanged: (newText) {
                newItemTitle = newText;
              },
              onSubmitted: (newText) {
                Box<ShopListItem> shopBox = Hive.box('shop');
                shopBox.add(ShopListItem(
                  name: newItemTitle,
                ));
                Navigator.pop(context);
              },
              maxLines: 1,
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
              cursorColor: kColorYellow,
              textAlign: TextAlign.center,
              autofocus: true,
              textCapitalization: TextCapitalization.words,
              style: GoogleFonts.montserrat(
                  textStyle: kTextStyleReg, fontSize: 20.0),
            ),
          ),
          FlatButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
              side: BorderSide(color: kColorYellow),
            ),
            onPressed: () {
              Box<ShopListItem> shopBox = Hive.box<ShopListItem>('shop');
              shopBox.add(ShopListItem(name: newItemTitle));
//                shopBox.clear();
              Navigator.pop(context);
            },
            splashColor: kColorBlack,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 15.0),
              child: Text('Добавить',
                  style: GoogleFonts.montserrat(
                    fontSize: 18.0,
                    color: kColorYellow,
                    fontWeight: FontWeight.w700,
                  )),
            ),
            color: kColorBlackAccent,
          ),
        ],
      ),
    );
  }
}
