class DetailRestaurantResponse {
  bool error;
  String message;
  DetailRestaurant restaurant;

  DetailRestaurantResponse({
    required this.error,
    required this.message,
    required this.restaurant,
  });

  factory DetailRestaurantResponse.fromMap(Map<String, dynamic> map) {
    return DetailRestaurantResponse(
        error: map['error'] as bool,
        message: map['message'] as String,
        restaurant: DetailRestaurant.fromMap(map['restaurant']));
  }
}

class DetailRestaurant {
  String id;
  String name;
  String description;
  String city;
  String address;
  String pictureId;
  List<Category> categories;
  Menus menus;
  double rating;
  List<CustomerReview> customerReviews;

  DetailRestaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.city,
    required this.address,
    required this.pictureId,
    required this.categories,
    required this.menus,
    required this.rating,
    required this.customerReviews,
  });

  factory DetailRestaurant.fromMap(Map<String, dynamic> map) {
    return DetailRestaurant(
      id: map['id'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      city: map['city'] as String,
      address: map['address'] as String,
      pictureId: map['pictureId'] as String,
      categories: List<Category>.from(
          map['categories'].map((x) => Category.fromMap(x))),
      menus: Menus.fromMap(map['menus']),
      rating: map['rating'] as double,
      customerReviews: List<CustomerReview>.from(
          map['customerReviews'].map((x) => CustomerReview.fromMap(x))),
    );
  }
}

class Category {
  String name;

  Category({
    required this.name,
  });

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      name: map['name'] as String,
    );
  }
}

class Food {
  String name;

  Food({
    required this.name,
  });

  factory Food.fromMap(Map<String, dynamic> map) {
    return Food(
      name: map['name'] as String,
    );
  }
}

class Drink {
  String name;

  Drink({
    required this.name,
  });

  factory Drink.fromMap(Map<String, dynamic> map) {
    return Drink(
      name: map['name'] as String,
    );
  }
}

class CustomerReview {
  String name;
  String review;
  String date;

  CustomerReview({
    required this.name,
    required this.review,
    required this.date,
  });

  factory CustomerReview.fromMap(Map<String, dynamic> map) {
    return CustomerReview(
      name: map['name'] as String,
      review: map['review'] as String,
      date: map['date'] as String,
    );
  }
}

class Menus {
  List<Food> foods;
  List<Drink> drinks;

  Menus({
    required this.foods,
    required this.drinks,
  });

  factory Menus.fromMap(Map<String, dynamic> map) {
    return Menus(
      foods: List<Food>.from(map['foods'].map((x) => Food.fromMap(x))),
      drinks: List<Drink>.from(map['drinks'].map((x) => Drink.fromMap(x))),
    );
  }
}
