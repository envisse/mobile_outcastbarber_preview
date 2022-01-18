class Crew {
  String id;
  String barber;

  Crew({required this.barber,required this.id});

  factory Crew.fromjson(Map<String, dynamic> json,String id) {
    return Crew(barber: json['barber_name'],id: id);
  }

  Map<String, dynamic> json() {
    return {'barber_name': this.barber};
  }
}
