import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobile_outcastbarber/models/withdraw.dart';

class RecordWithdraws {
  String title;
  String? nameBarber;
  List<WithDraw> withdraws;
  int price;
  DateTime date;

  RecordWithdraws(
      {required this.title,
      this.nameBarber,
      required this.price,
      required this.withdraws,
      required this.date});

  factory RecordWithdraws.fromjson(Map<String, dynamic> json) {
    Timestamp timestamp = json['date'];
    return RecordWithdraws(
        title: json['withdraw_title'],
        nameBarber: json['name_barber'],
        withdraws: (json['list_withdraw'] != null) ? List<WithDraw>.from(json['list_withdraw'].map((x) => WithDraw.fromjson(x))) : [],
        price: json['price'],
        date: timestamp.toDate());
  }

  Map<String, dynamic> json() {
    List<Map<String, dynamic>> withdraws = [];
      if (this.withdraws.isNotEmpty) {
        this.withdraws.map((e) => withdraws.add(e.json())).toList();
      }
    return {
      'withdraw_title': this.title,
      'name_barber': this.nameBarber,
      'list_withdraw': withdraws,
      'price': this.price,
      'date': this.date};
  }
}
