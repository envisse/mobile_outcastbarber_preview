import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobile_outcastbarber/models/product.dart';
import 'package:mobile_outcastbarber/models/service.dart';

class RecordServices {
  String nameCostumer;
  String? nameBarber;
  List<Service> services;
  List<Product> products;
  int totalprice;
  DateTime date;

  RecordServices(
      {required this.nameCostumer,
      this.nameBarber,
      required this.services,
      required this.products,
      required this.totalprice,
      required this.date});

  factory RecordServices.fromjson(Map<String, dynamic> json) {
    Timestamp timestamp = json['date'];
    return RecordServices(
        nameCostumer: json['name_costumer'],
        nameBarber: json['name_barber'],
        services: (json['service_done'] != null) ? List<Service>.from(json['service_done'].map((x) => Service.fromjson(x,''))) : [],
        products: (json['product_sold'] != null) ? List<Product>.from(json['product_sold'].map((x) => Product.fromjson(x,''))) : [],
        totalprice: json['total'],
        date: timestamp.toDate());
  }

  Map<String, dynamic> json() {
    List<Map<String, dynamic>> serviceDone = [];
    List<Map<String, dynamic>> productSold = [];
    if (this.services.isNotEmpty)
      this.services.map((e) => serviceDone.add(e.json())).toList();

    if (this.products.isNotEmpty)
      this.products.map((e) => productSold.add(e.json())).toList();

    return {
      'name_costumer': this.nameCostumer,
      'name_barber': this.nameBarber,
      'service_done': serviceDone,
      'product_sold': productSold,
      'total': this.totalprice,
      'date': this.date
    };
  }
}
