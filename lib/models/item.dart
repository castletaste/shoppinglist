import 'package:hive/hive.dart';
part 'item.g.dart';

@HiveType(typeId: 0)
class ShopListItem extends HiveObject {
  @HiveField(0)
  bool isDone;
  @HiveField(1)
  String id;
  @HiveField(2)
  String name;
  ShopListItem({this.isDone = false, this.name});
}
