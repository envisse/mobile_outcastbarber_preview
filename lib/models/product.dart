class Product {
  String id;
  String name;
  int price;
  int? amount;
  int? totalprice;

  Product({required this.name, required this.price, this.amount, this.totalprice, required this.id});

  factory Product.fromjson(Map<String, dynamic> json, String id) {
    return Product(name: json['name_product'], price: json['price'], amount: json['amount'], id: id);
  }

  Map<String, dynamic> json() {
    return {'name_product': this.name, 'price': this.price, 'amount': this.amount, 'total_price': this.totalprice};
  }
}
