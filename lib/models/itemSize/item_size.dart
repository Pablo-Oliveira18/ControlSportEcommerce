class ItemSize {
  ItemSize({this.name, this.price, this.stock});
  ItemSize.fromMap(Map<String, dynamic> map) {
    name = map['name'] as String;
    price = map['price'] as num;
    stock = map['stock'] as int;
  }
  String name;
  num price;
  int stock;

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'stock': stock,
    };
  }

  bool get hasStock => stock > 0;

  @override
  String toString() {
    // TODO: implement toString
    return ('name $name, price $price, stock $stock');
  }

  ItemSize clone() {
    return ItemSize(
      name: name,
      price: price,
      stock: stock,
    );
  }
}
