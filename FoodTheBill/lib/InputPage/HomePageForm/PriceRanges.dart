class PriceRanges {
  List<String>? pricerange;
  String? curr;
  String placeHolder = "Price Range";
  String cheapest = "Not expensive";
  String cheaper = "Normal";
  String cheap = "Expensive";
  String expensive = "Very expensive";

  PriceRanges() {
    pricerange = [placeHolder, cheapest, cheaper, cheap, expensive];
    curr = placeHolder;
  }
  List<String>? getPrices() {
    return pricerange;
  }

  String? getCurr() {
    return curr;
  }

  int getPriceLevel() {
    return pricerange!.indexOf(curr!);
  }
}
