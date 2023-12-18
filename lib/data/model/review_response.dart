import 'customer_review.dart';

class ReviewResponse {
  bool error;
  String message;
  List<Review> customerReviews;

  ReviewResponse({
    required this.error,
    required this.message,
    required this.customerReviews,
  });

  Map<String, dynamic> toMap() {
    return {
      'error': error,
      'message': message,
      'customerReviews': customerReviews,
    };
  }

  factory ReviewResponse.fromMap(Map<String, dynamic> map) {
    return ReviewResponse(
      error: map['error'] as bool,
      message: map['message'] as String,
      customerReviews: List<Review>.from(
        map['customerReviews'].map(
          (x) => Review.fromMap(x),
        ),
      ),
    );
  }
}
