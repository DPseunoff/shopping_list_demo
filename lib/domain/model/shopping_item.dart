class ShoppingItem {
  final String id;
  final String name;
  final bool isBought;

  const ShoppingItem({
    required this.id,
    required this.name,
    this.isBought = false,
  });

  ShoppingItem copyWith({
    String? id,
    String? name,
    bool? isBought,
  }) {
    return ShoppingItem(
      id: id ?? this.id,
      name: name ?? this.name,
      isBought: isBought ?? this.isBought,
    );
  }

  @override
  String toString() =>
      'ShoppingItem(id: $id, name: $name, isBought: $isBought)';
}
