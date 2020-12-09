import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shoppinglist/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoppinglist/emojis_database.dart';

var parser = EmojiParser();
var rbread = Emoji('хлеб', '🍞');

class ShopItem extends StatelessWidget {
  final bool isChecked;
  final String itemTitle;
  final Function checkboxCallback;
  final Function onTapCallback;
  ShopItem({
    this.isChecked,
    this.itemTitle,
    this.checkboxCallback,
    this.onTapCallback,
  });

  @override
  Widget build(BuildContext context) {
    return ListTileTheme(
      child: GestureDetector(
        onTap: onTapCallback,
        child: Container(
          margin: EdgeInsets.only(top: 15.0, left: 20.0, right: 20.0),
          padding: EdgeInsets.only(left: 20.0, top: 10.0, bottom: 10.0),
          decoration: BoxDecoration(
            color: kColorBlackAccent,
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                '${parser.get('${itemTitle.toLowerCase()}').code} $itemTitle',
                style: GoogleFonts.montserrat(textStyle: kTextStyleReg),
              ),
              Checkbox(
                checkColor: kColorBlack,
                activeColor: kColorYellow,
                value: isChecked,
                onChanged: checkboxCallback,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
