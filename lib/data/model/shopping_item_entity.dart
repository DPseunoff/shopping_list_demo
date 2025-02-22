import 'package:objectbox/objectbox.dart';

@Entity()
class ShoppingItemEntity {
  @Id()
  int id;

  @Unique()
  String uid;
  String name;
  bool isBought;

  ShoppingItemEntity({
    this.id = 0,
    required this.uid,
    required this.name,
    this.isBought = false,
  });
}
