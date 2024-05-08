
class Rating {
  final double rate;
  final int count;


  Rating.fromJson(Map<String, dynamic> json) :
    rate = double.parse(json['rate'].toString()),
    count = json['count'];

  Map<String, dynamic> toJson() => {
    'rate': rate,
    'count': count,
  };


}
