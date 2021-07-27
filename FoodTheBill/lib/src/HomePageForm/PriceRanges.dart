/// This class handles all the logic for the Price Range field of the form

class PriceRanges {
  List<String>? pricerange;
  String? curr;
  String placeHolder = "Price Range";
  String cheapest = "Not expensive";
  String cheaper = "Normal";
  String cheap = "Expensive";
  String expensive = "Very expensive";

  /// Constructor of the Price Range class

  PriceRanges() {
    pricerange = [placeHolder, cheapest, cheaper, cheap, expensive];
    curr = placeHolder;
  }

  /// Returns the available price ranges that can be chosen

  List<String>? getPrices() {
    return pricerange;
  }

  /// Returns the current price range selected, including the placeholder
  String? getCurr() {
    return curr;
  }

  /// Returns the current index of the current price range that is selected

  int getPriceLevel() {
    return pricerange!.indexOf(curr!);
  }
}
