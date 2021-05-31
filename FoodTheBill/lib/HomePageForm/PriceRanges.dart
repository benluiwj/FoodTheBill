class PriceRanges {
  List<String>? pricerange;
  String? curr;
  String placeHolder = "Price Range";
  String cheapest = "Less than \$5";
  String cheaper = "More than \$5, less than \$10";
  String cheap = "More than \$10, less than \$20";
  String expensive = "More than \$20";

  PriceRanges() {
    pricerange = [placeHolder, cheapest, cheaper, cheap, expensive];
    curr = null;
  }
  List<String>? getPrices() {
    return pricerange;
  }

  String? getCurr() {
    return curr;
  }
}
