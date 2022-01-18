class Service {
  String id;
  String name;
  int? amount;
  int price;
  int? totalprice;

  Service({required this.name, required this.price, this.amount, this.totalprice, required this.id});

  factory Service.fromjson(Map<String, dynamic> json, String id) {
    return Service(name: json['name_service'], price: json['price'], amount: json['amount'], id: id);
  }

  Map<String, dynamic> json() {
    return {'name_service': this.name, 'price': this.price, 'amount': this.amount, 'total_price': this.totalprice};
  }
}
