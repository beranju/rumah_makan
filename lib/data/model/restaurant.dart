class Restaurant {
  String id;
  String name;
  String description;
  String pictureId;
  String city;
  num rating;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
  });

  factory Restaurant.fromMap(Map<String, dynamic> map) {
    return Restaurant(
      id: map['id'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      pictureId: map['pictureId'] as String,
      city: map['city'] as String,
      rating: map['rating'] as num,
    );
  }
}

// List<Restaurant> restaurantFromJson(String? str) {
//   if (str == null) {
//     return [];
//   }
//   final data = jsonDecode(str);
//   final List listRestaurant = data['restaurants'];
//   return listRestaurant
//       .map((restaurant) => Restaurant.fromJson(restaurant))
//       .toList();
// }
//
// class Restaurant {
//   Restaurant({
//     String? id,
//     String? name,
//     String? description,
//     String? pictureId,
//     String? city,
//     num? rating,
//     Menus? menus,
//   }) {
//     _id = id;
//     _name = name;
//     _description = description;
//     _pictureId = pictureId;
//     _city = city;
//     _rating = rating;
//     _menus = menus;
//   }
//
//   Restaurant.fromJson(dynamic json) {
//     _id = json['id'];
//     _name = json['name'];
//     _description = json['description'];
//     _pictureId = json['pictureId'];
//     _city = json['city'];
//     _rating = json['rating'];
//     _menus = json['menus'] != null ? Menus.fromJson(json['menus']) : null;
//   }
//
//   String? _id;
//   String? _name;
//   String? _description;
//   String? _pictureId;
//   String? _city;
//   num? _rating;
//   Menus? _menus;
//
//   String? get id => _id;
//
//   String? get name => _name;
//
//   String? get description => _description;
//
//   String? get pictureId => _pictureId;
//
//   String? get city => _city;
//
//   num? get rating => _rating;
//
//   Menus? get menus => _menus;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['id'] = _id;
//     map['name'] = _name;
//     map['description'] = _description;
//     map['pictureId'] = _pictureId;
//     map['city'] = _city;
//     map['rating'] = _rating;
//     if (_menus != null) {
//       map['menus'] = _menus?.toJson();
//     }
//     return map;
//   }
// }
