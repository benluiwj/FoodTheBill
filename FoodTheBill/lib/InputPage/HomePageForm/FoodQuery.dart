import './Distance.dart';
import './Cuisines.dart';
import './PriceRanges.dart';

class FoodQuery {
  String? location;
  Cuisines? cuisine;
  Cuisines? cuisineChoices = Cuisines();
  PriceRanges? price;
  PriceRanges? priceRanges = PriceRanges();
  Distances? distance;
  Distances? distanceRanges = Distances();

  FoodQuery({this.location, this.cuisine, this.distance, this.price}) {
    this.cuisine = cuisineChoices;
    this.price = priceRanges;
    this.distance = distanceRanges;
  }

  void setLocation(String location) {
    this.location = location;
  }

  void setCuisine(String cuisine) {
    this.cuisine!.curr = cuisine;
  }

  void setPrice(String priceRange) {
    this.price!.curr = priceRange;
  }

  void setDistance(String distance) {
    this.distance!.curr = distance;
  }

  @override
  String toString() {
    return "Location: $location \n Cuisine: ${cuisine!.curr} \n Price Range: ${price!.curr}";
  }
}
