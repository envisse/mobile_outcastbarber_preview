class WithDraw {
  String name;
  int amount;
  int total;

  WithDraw({required this.name, required this.amount, required this.total});

  factory WithDraw.fromjson(Map<String, dynamic> json) {
    return WithDraw(
        name: json['name'], amount: json['amount'], total: json['total']);
  }

  Map<String, dynamic> json() {
    return {'name': this.name, 'amount': this.amount, 'total': this.total};
  }
}
