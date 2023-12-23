class Review {
  String name;
  String review;
  String date;

  Review({
    required this.name,
    required this.review,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'review': review,
      'date': date,
    };
  }

  factory Review.fromMap(Map<String, dynamic> map) {
    return Review(
      name: map['name'] as String,
      review: map['review'] as String,
      date: map['date'] as String,
    );
  }
}
