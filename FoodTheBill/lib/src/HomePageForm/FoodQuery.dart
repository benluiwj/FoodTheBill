import 'package:milestone1/src/HomePageForm/Distances.dart';

import './Cuisines.dart';
import './PriceRanges.dart';

/// This class contains the FoodQuery class. This class manages the inputs from the user such
/// as distance, pricing and cuisine.
class FoodQuery {
  String? location;
  Cuisines? cuisine;
  Cuisines? cuisineChoices = Cuisines();
  PriceRanges? price;
  PriceRanges? priceRanges = PriceRanges();
  Distances? distance;
  Distances? distanceRanges = Distances();

  /// The constructor of this class

  FoodQuery({this.location, this.cuisine, this.distance, this.price}) {
    this.cuisine = cuisineChoices;
    this.price = priceRanges;
    this.distance = distanceRanges;
  }

  /// Sets the current location to the location selected

  void setLocation(String location) {
    this.location = location;
  }

  /// Sets the current cuisine to the cuisine selected

  void setCuisine(String cuisine) {
    this.cuisine!.curr = cuisine;
  }

  /// Sets the current price range to the price range selected

  void setPrice(String priceRange) {
    this.price!.curr = priceRange;
  }

  /// Sets the current distance to the distance selected

  void setDistance(String distance) {
    this.distance!.curr = distance;
  }
}
