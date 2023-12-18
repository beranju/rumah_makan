import 'package:flutter/foundation.dart';
import 'package:rumah_makan/common/result_state.dart';
import 'package:rumah_makan/data/api/api_service.dart';
import 'package:rumah_makan/data/model/customer_review.dart';
import 'package:rumah_makan/data/model/review_request.dart';
import 'package:rumah_makan/data/model/review_response.dart';

class AddReviewProvider extends ChangeNotifier {
  final ApiService apiService;

  AddReviewProvider({required this.apiService});

  late List<Review> _review;
  ResultState _state = ResultState.loading;
  String _message = '';

  ResultState get state => _state;

  String get message => _message;

  List<Review> get review => _review;

  Future<dynamic> addReview(ReviewRequest request) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final ReviewResponse response = await apiService.addReview(request);
      if (response.customerReviews.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _review = response.customerReviews;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = e.toString();
    }
  }
}
