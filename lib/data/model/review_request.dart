class ReviewRequest {
  String id;
  String name;
  String review;

  ReviewRequest({
    required this.id,
    required this.name,
    required this.review,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'review': review,
    };
  }

  factory ReviewRequest.fromMap(Map<String, dynamic> map) {
    return ReviewRequest(
      id: map['id'] as String,
      name: map['name'] as String,
      review: map['review'] as String,
    );
  }
}
