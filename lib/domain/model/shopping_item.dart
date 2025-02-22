import 'package:freezed_annotation/freezed_annotation.dart';

part 'shopping_item.freezed.dart';
part 'shopping_item.g.dart';

@freezed
abstract class ShoppingItem with _$ShoppingItem {
  const factory ShoppingItem({
    required String id,
    required String name,
    @Default(false) bool isBought,
  }) = _ShoppingItem;

  factory ShoppingItem.fromJson(Map<String, Object?> json) =>
      _$ShoppingItemFromJson(json);
}
