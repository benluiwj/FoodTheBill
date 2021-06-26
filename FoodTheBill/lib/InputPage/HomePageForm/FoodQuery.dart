import './Cuisines.dart';
import './PriceRanges.dart';

class FoodQuery {
  String? location;
  Cuisines? cuisine;
  PriceRanges? price;
  Cuisines? cuisines = Cuisines();
  PriceRanges? priceRanges = PriceRanges();

  FoodQuery({this.location, this.cuisine, this.price}) {
    this.cuisine = cuisines;
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
