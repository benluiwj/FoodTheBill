import './Cuisines.dart';
import './PriceRanges.dart';

class FoodQuery {
  String? location;
  Cuisines? cuisine;
  Cuisines? cuisineChoices = Cuisines();
  PriceRanges? price;
  PriceRanges? priceRanges = PriceRanges();

  FoodQuery({this.location, this.cuisine, this.price}) {
    this.cuisine = cuisineChoices;
    this.price = priceRanges;
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

  @override
  String toString() {
    return "Location: $location \n Cuisine: ${cuisine!.curr} \n Price Range: ${price!.curr}";
  }
}
