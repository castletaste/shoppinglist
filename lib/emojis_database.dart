library flutter_emoji;

import 'dart:convert';

///
/// Constants defined for Emoji.
///
class EmojiConst {
  static final String charNonSpacingMark = String.fromCharCode(0xfe0f);
  static final String charColon = ':';
  static final String charEmpty = '📦';
}

/// List of pre-defined message used in this library
class EmojiMessage {
  static final String errorMalformedEmojiName = 'Malformed emoji name';
}

///
/// Utilities to handle emoji operations.
///
class EmojiUtil {
  ///
  /// Strip colons for emoji name.
  /// So, ':heart:' will become 'heart'.
  ///
  static String stripColons(String name, [void onError(String message)]) {
    Iterable<Match> matches = EmojiParser.REGEX_NAME.allMatches(name);
    if (matches.isEmpty) {
      if (onError != null) {
        onError(EmojiMessage.errorMalformedEmojiName);
      }
      return name;
    }
    return name.replaceAll(EmojiConst.charColon, EmojiConst.charEmpty);
  }

  ///
  /// Wrap colons on both sides of emoji name.
  /// So, 'heart' will become ':heart:'.
  ///
  static String ensureColons(String name) {
    String res = name;
    if (!name.startsWith(EmojiConst.charColon, 0)) {
      res = EmojiConst.charColon + name;
    }

    if (!name.endsWith(EmojiConst.charColon)) {
      res += EmojiConst.charColon;
    }

    return res;
  }

  ///
  /// When processing emojis, we don't need to store the graphical byte
  /// which is 0xfe0f, or so-called 'Non-Spacing Mark'.
  ///
  static String stripNSM(String name) => name.replaceAll(
      RegExp(EmojiConst.charNonSpacingMark), EmojiConst.charEmpty);
}

///
/// The representation of an emoji.
/// There are three properties availables:
///   - 'name' : the emoji name (no colon)
///   - 'full' : the full emoji name. It is name with colons on both sides.
///   - 'code' : the actual graphic presentation of emoji.
///
/// Emoji.None is being used to represent a NULL emoji.
///
class Emoji {
  ///
  /// If emoji not found, the parser always returns this.
  ///
  static final Emoji None = Emoji(EmojiConst.charEmpty, EmojiConst.charEmpty);

  final String name;
  final String code;

  Emoji(this.name, this.code);

  String get full => EmojiUtil.ensureColons(this.name);

  @override
  bool operator ==(other) {
    return this.name == other.name && this.code == other.code;
  }

  Emoji clone() {
    return Emoji(name, code);
  }

  @override
  String toString() {
    return 'Emoji{name="$name", full="$full", code="$code"}';
  }
}

///
/// Emoji storage and parser.
/// You will need to instantiate one of this instance to start using.
///
class EmojiParser {
  ///
  /// This regex is insane, borrowed from lodash, a Javascript library.
  ///
  /// Reference: https://github.com/lodash/lodash/blob/4.16.6/lodash.js#L242
  ///
//  static final RegExp REGEX_EMOJI = RegExp(
//      r'(?:[\u2700-\u27bf]|(?:\ud83c[\udde6-\uddff]){2}|[\ud800-\udbff][\udc00-\udfff])[\ufe0e\ufe0f]?(?:[\u0300-\u036f\ufe20-\ufe23\u20d0-\u20f0]|\ud83c[\udffb-\udfff])?(?:\u200d(?:[^\ud800-\udfff]|(?:\ud83c[\udde6-\uddff]){2}|[\ud800-\udbff][\udc00-\udfff])[\ufe0e\ufe0f]?(?:[\u0300-\u036f\ufe20-\ufe23\u20d0-\u20f0]|\ud83c[\udffb-\udfff])?)*');

  /// A tweak regexp to pass all Emoji Unicode 11.0
  /// TODO: improve this version, since it does not match the graphical bytes.
  static final RegExp REGEX_EMOJI = RegExp(
      r'(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])');

  static final RegExp REGEX_NAME = RegExp(r":([\w-+]+):");

  ///
  /// Data source for Emoji.
  ///
  /// Reference: https://raw.githubusercontent.com/omnidan/node-emoji/master/lib/emoji.json
  ///
  static final String JSON_EMOJI_RU = '{'
      '"кофе":"☕",'
      '"хлеб":"🍞",'
      '"хлеба":"🍞",'
      '"морковь":"🥕",'
      '"моркови":"🥕",'
      '"виноград":"🍇",'
      '"винограда":"🍇",'
      '"дыня":"🍈",'
      '"дыни":"🍈",'
      '"дыню":"🍈",'
      '"дынь":"🍈",'
      '"арбуз":"🍉",'
      '"арбузы":"🍉",'
      '"арбуза":"🍉",'
      '"арбузов":"🍉",'
      '"мандарин":"🍊",'
      '"мандарина":"🍊",'
      '"мандарины":"🍊",'
      '"мандаринов":"🍊",'
      '"лимон":"🍋",'
      '"лимона":"🍋",'
      '"лимонов":"🍋",'
      '"банан":"🍌",'
      '"банана":"🍌",'
      '"бананов":"🍌",'
      '"ананас":"🍍",'
      '"ананаса":"🍍",'
      '"ананасы":"🍍",'
      '"ананасов":"🍍",'
      '"манго":"🥭",'
      '"яблоко":"🍎",'
      '"яблок":"🍎",'
      '"яблока":"🍎",'
      '"яблоки":"🍎",'
      '"яблоков":"🍎",'
      '"груша":"🍐",'
      '"груши":"🍐",'
      '"груш":"🍐",'
      '"персик":"🍑",'
      '"персика":"🍑",'
      '"персиков":"🍑",'
      '"вишня":"🍒",'
      '"вишни":"🍒",'
      '"земляника":"🍓",'
      '"земляники":"🍓",'
      '"виктория":"🍓",'
      '"виктории":"🍓",'
      '"клубника":"🍓",'
      '"клубники":"🍓",'
      '"киви":"🥝",'
      '"помидор":"🍅",'
      '"помидоры":"🍅",'
      '"помидоров":"🍅",'
      '"томат":"🍅",'
      '"томаты":"🍅",'
      '"томатов":"🍅",'
      '"кокос":"🥥",'
      '"кокосы":"🥥",'
      '"кокоса":"🥥",'
      '"кокаин":"🥥",'
      '"кокаина":"🥥",'
      '"кукуруза":"🌽",'
      '"кукурузу":"🌽",'
      '"кукурузы":"🌽",'
      '"перец":"🌶️",'
      '"перца":"🌶️",'
      '"специи":"🌶️",'
      '"чили":"🌶️",'
      '"огурец":"🥒",'
      '"огурцы":"🥒",'
      '"огурцов":"🥒",'
      '"рик":"🥒",'
      '"салат":"🥬",'
      '"салата":"🥬",'
      '"зелень":"🥬",'
      '"зелени":"🥬",'
      '"брокколи":"🥦",'
      '"чеснок":"🧄",'
      '"чеснока":"🧄",'
      '"чесноков":"🧄",'
      '"лук":"🧅",'
      '"лука":"🧅",'
      '"авокадо":"🥑",'
      '"баклажан":"🍆",'
      '"баклажаны":"🍆",'
      '"баклажана":"🍆",'
      '"баклажанов":"🍆",'
      '"презерватив":"🍆",'
      '"презервативов":"🍆",'
      '"презерватива":"🍆",'
      '"презервативы":"🍆",'
      '"картофель":"🥔",'
      '"картофеля":"🥔",'
      '"картофелин":"🥔",'
      '"картошка":"🥔",'
      '"картошку":"🥔",'
      '"картошки":"🥔",'
      '"картошек":"🥔",'
      '"гриб":"🍄",'
      '"гриба":"🍄",'
      '"грибы":"🍄",'
      '"грибов":"🍄",'
      '"псилоцибин":"🍄",'
      '"марио":"🍄",'
      '"каштан":"🌰",'
      '"каштана":"🌰",'
      '"каштанов":"🌰",'
      '"каштаны":"🌰",'
      '"арахис":"🥜",'
      '"арахиса":"🥜",'
      '"рогалик":"🥐",'
      '"рогалики":"🥐",'
      '"круассан":"🥐",'
      '"круассаны":"🥐",'
      '"круассанов":"🥐",'
      '"багет":"🥖",'
      '"багеты":"🥖",'
      '"крендель":"🥨",'
      '"кренделёк":"🥨",'
      '"кренделек":"🥨",'
      '"крендельки":"🥨",'
      '"крендельков":"🥨",'
      '"бублик":"🥯",'
      '"бублики":"🥯",'
      '"бубликов":"🥯",'
      '"бублика":"🥯",'
      '"блины":"🥞",'
      '"блина":"🥞",'
      '"блинов":"🥞",'
      '"блин":"🥞",'
      '"блинчики":"🥞",'
      '"блинчика":"🥞",'
      '"блинчиков":"🥞",'
      '"оладьи":"🥞",'
      '"вафля":"🧇",'
      '"вафли":"🧇",'
      '"вафель":"🧇",'
      '"сыр":"🧀",'
      '"сыра":"🧀",'
      '"сыров":"🧀",'
      '"мясо":"🍖",'
      '"мяса":"🍖",'
      '"барбекю":"🍖",'
      '"свинина":"🍖",'
      '"свинину":"🍖",'
      '"свинины":"🍖",'
      '"курица":"🍗",'
      '"курицу":"🍗",'
      '"курицы":"🍗",'
      '"стейк":"🥩",'
      '"стейка":"🥩",'
      '"стейков":"🥩",'
      '"говядина":"🥩",'
      '"говядину":"🥩",'
      '"говядины":"🥩",'
      '"бекон":"🥓",'
      '"бекона":"🥓",'
      '"бургер":"🍔",'
      '"бургеры":"🍔",'
      '"бургеров":"🍔",'
      '"гамбургер":"🍔",'
      '"гамбургеры":"🍔",'
      '"гамбургеров":"🍔",'
      '"чизбургер":"🍔",'
      '"чизбургеры":"🍔",'
      '"чизбургеров":"🍔",'
      '"фри":"🍟",'
      '"пицца":"🍕",'
      '"пиццу":"🍕",'
      '"пицц":"🍕",'
      '"хотдог":"🌭",'
      '"бутерброд":"🥪",'
      '"бутерброда":"🥪",'
      '"бутерброды":"🥪",'
      '"бутербродов":"🥪",'
      '"сэндвич":"🥪",'
      '"сэндвича":"🥪",'
      '"сэндвичей":"🥪",'
      '"сэндвичи":"🥪",'
      '"тако":"🌮",'
      '"буррито":"🌯",'
      '"буритто":"🌯",'
      '"шаурма":"🌯",'
      '"шаурму":"🌯",'
      '"шаурмы":"🌯",'
      '"шаверма":"🌯",'
      '"шаверму":"🌯",'
      '"шавермы":"🌯",'
      '"фалафель":"🧆",'
      '"фалафеля":"🧆",'
      '"фалафелей":"🧆",'
      '"яйцо":"🥚",'
      '"яйца":"🥚",'
      '"яиц":"🥚",'
      '"попкорн":"🍿",'
      '"попкорна":"🍿",'
      '"попкорнов":"🍿",'
      '"масло":"🧈",'
      '"масла":"🧈",'
      '"масел":"🧈",'
      '"соль":"🧂",'
      '"соли":"🧂",'
      '"консервы":"🥫",'
      '"консерва":"🥫",'
      '"консерв":"🥫",'
      '"heinz":"🥫",'
      '"хайнз":"🥫",'
      '"рис":"🍚",'
      '"риса":"🍚",'
      '"мороженое":"🍦",'
      '"мороженное":"🍦",'
      '"мороженого":"🍦",'
      '"мороженного":"🍦",'
      '"фруктовый лед":"🍧",'
      '"фруктовый лёд":"🍧",'
      '"пломбир":"🍨",'
      '"пломбира":"🍨",'
      '"пломбиров":"🍨",'
      '"пончик":"🍩",'
      '"пончики":"🍩",'
      '"пончиков":"🍩",'
      '"пончика":"🍩",'
      '"печенье":"🍪",'
      '"печенья":"🍪",'
      '"печеньев":"🍪",'
      '"торт":"🎂",'
      '"торты":"🎂",'
      '"тортов":"🎂",'
      '"торта":"🎂",'
      '"кекс":"🧁",'
      '"кексы":"🧁",'
      '"кексов":"🧁",'
      '"кекса":"🧁",'
      '"пирог":"🥧",'
      '"пирога":"🥧",'
      '"пироги":"🥧",'
      '"пирогов":"🥧",'
      '"спагетти":"🍝",'
      '"суши":"🍣",'
      '"морепродукты":"🍣",'
      '"пельмени":"🥟",'
      '"пельменев":"🥟",'
      '"пельмень":"🥟",'
      '"пельменя":"🥟",'
      '"вареники":"🥟",'
      '"вареников":"🥟",'
      '"вареника":"🥟",'
      '"вареник":"🥟",'
      '"китайская еда":"🥡",'
      '"устрица":"🦪",'
      '"устриц":"🦪",'
      '"устрици":"🦪",'
      '"шоколад":"🍫",'
      '"шоколада":"🍫",'
      '"шоколадка":"🍫",'
      '"шоколадки":"🍫",'
      '"шоколадок":"🍫",'
      '"сладкого":"🍫",'
      '"к чаю":"🍫",'
      '"конфета":"🍬",'
      '"конфеты":"🍬",'
      '"конфет":"🍬",'
      '"конфеток":"🍬",'
      '"сладости":"🍬",'
      '"леденец":"🍭",'
      '"леденцы":"🍭",'
      '"леденцов":"🍭",'
      '"чупа чупс":"🍭",'
      '"мед":"🍯",'
      '"меда":"🍯",'
      '"мёд":"🍯",'
      '"мёда":"🍯",'
      '"детское питание":"🍼",'
      '"соску":"🍼",'
      '"смеси":"🍼",'
      '"смесь":"🍼",'
      '"молоко":"🥛",'
      '"молока":"🥛",'
      '"чай":"☕",'
      '"черный чай":"☕",'
      '"зеленый чай":"🍵",'
      '"зелёный чай":"🍵",'
      '"какао":"☕",'
      '"горячий шоколад":"☕",'
      '"шампанское":"🍾",'
      '"шампанского":"🍾",'
      '"вино":"🍷",'
      '"вина":"🍷",'
      '"красное вино":"🍷",'
      '"красного вина":"🍷",'
      '"коктейль":"🍸",'
      '"коктейля":"🍸",'
      '"пиво":"🍺",'
      '"пивко":"🍺",'
      '"пива":"🍺",'
      '"сидр":"🍺",'
      '"сидра":"🍺",'
      '"стаут":"🍺",'
      '"стаута":"🍺",'
      '"портер":"🍺",'
      '"портера":"🍺",'
      '"вечеринка":"🥂",'
      '"вечеринки":"🥂",'
      '"бурбон":"🥃",'
      '"бурбона":"🥃",'
      '"бурбонов":"🥃",'
      '"ликер":"🥃",'
      '"ликера":"🥃",'
      '"ликеров":"🥃",'
      '"ликеры":"🥃",'
      '"ликёр":"🥃",'
      '"ликёра":"🥃",'
      '"ликёров":"🥃",'
      '"ликёры":"🥃",'
      '"ром":"🥃",'
      '"рома":"🥃",'
      '"скотч":"🥃",'
      '"скотча":"🥃",'
      '"виски":"🥃",'
      '"коньяк":"🥃",'
      '"коньяка":"🥃",'
      '"шейк":"🥤",'
      '"молочный коктейль":"🥤",'
      '"кола":"🥤",'
      '"пепси":"🥤",'
      '"фанта":"🥤",'
      '"миринда":"🥤",'
      '"лимонад":"🥤",'
      '"лимонады":"🥤",'
      '"запивон":"🥤",'
      '"сода":"🥤",'
      '"доктор пеппер":"🥤",'
      '"смузи":"🥤",'
      '"сок":"🧃",'
      '"сока":"🧃",'
      '"соки":"🧃",'
      '"лед":"🧊",'
      '"льда":"🧊",'
      '"лёд":"🧊",'
      '"ледяной":"🧊",'
      '"палочки":"🥢",'
      '"посуда":"🍽️",'
      '"посуды":"🍽️",'
      '"машинка":"🚗️",'
      '"машинки":"🚗️",'
      '"машинку":"🚗",'
      '"тесла":"🚗️",'
      '"теслу":"🚗️",'
      '"миски":"🥣",'
      '"миску":"🥣",'
      '"миска":"🥣",'
      '"супа":"🍲",'
      '"супы":"🍲",'
      '"суп":"🍲",'
      '"чашки":"🥣",'
      '"чашка":"🥣",'
      '"чашку":"🥣",'
      '"кастрюлю":"🥘",'
      '"кастрюли":"🥘",'
      '"кастрюля":"🥘",'
      '"сковородки":"🍳",'
      '"сковородку":"🍳",'
      '"сковородка":"🍳",'
      '"ложка":"🥄",'
      '"ложку":"🥄",'
      '"ложки":"🥄"'
      '}';

  Map<String, Emoji> _emojisByName = Map<String, Emoji>();
  Map<String, Emoji> _emojisByCode = Map<String, Emoji>();

  EmojiParser() {
    Map<String, dynamic> mapEmojis = jsonDecode(JSON_EMOJI_RU);
    mapEmojis.forEach((k, v) {
      _emojisByName[k] = Emoji(k, v);
      _emojisByCode[EmojiUtil.stripNSM(v)] = Emoji(k, v);
    });
  }

  Emoji get(String name) =>
      _emojisByName[EmojiUtil.stripColons(name)] ?? Emoji.None;

  Emoji getName(String name) => get(name) ?? Emoji.None;
  bool hasName(String name) =>
      _emojisByName.containsKey(EmojiUtil.stripColons(name));

  ///
  /// Get info for an emoji.
  ///
  /// For example:
  ///
  ///   var parser = EmojiParser();
  ///   var emojiHeart = parser.info('heart');
  ///   print(emojiHeart); '{name: heart, full: :heart:, emoji: ❤️}'
  ///
  /// Returns Emoji.None if not found.
  ///
  Emoji info(String name) {
    return hasName(name) ? get(name) : Emoji.None;
  }

  ///
  /// Get emoji based on emoji code.
  ///
  /// For example:
  ///
  ///   var parser = EmojiParser();
  ///   var emojiHeart = parser.getEmoji('❤');
  ///   print(emojiHeart); '{name: heart, full: :heart:, emoji: ❤️}'
  ///
  /// Returns Emoji.None if not found.
  ///
  Emoji getEmoji(String emoji) {
    return _emojisByCode[EmojiUtil.stripNSM(emoji)] ?? Emoji.None;
  }

  bool hasEmoji(String emoji) {
    return _emojisByCode.containsKey(EmojiUtil.stripNSM(emoji));
  }

  ///
  /// Emojify the input text.
  ///
  /// For example: 'I :heart: :coffee:' => 'I ❤️ ☕'
  ///
  String emojify(String text) {
    Iterable<Match> matches = REGEX_NAME.allMatches(text);
    if (matches.isNotEmpty) {
      String result = text;
      matches.toList().forEach((m) {
        var _e = EmojiUtil.stripColons(m.group(0));
        if (hasName(_e)) {
          result = result.replaceAll(m.group(0), get(_e).code);
        }
      });
      return result;
    }
    return text;
  }

  ///
  /// This method will unemojify the text containing the Unicode emoji symbols
  /// into emoji name.
  ///
  /// For example: 'I ❤️ Flutter' => 'I :heart: Flutter'
  ///
  String unemojify(String text) {
    Iterable<Match> matches = REGEX_EMOJI.allMatches(text);
    if (matches.isNotEmpty) {
      String result = text;
      matches.toList().forEach((m) {
        if (hasEmoji(m.group(0))) {
          result = result.replaceAll(m.group(0), getEmoji(m.group(0)).full);

          /// Just a quick hack to clear graphical byte from emoji.
          /// TODO: find better way to get through this tweak
          result = result.replaceAll(
              EmojiConst.charNonSpacingMark, EmojiConst.charEmpty);
        }
      });
      return result;
    }
    return text;
  }
}
