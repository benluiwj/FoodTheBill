/// This class handles all the logic for the Cuisine field of the form

class Cuisines {
  List<String>? cuisines;
  String? curr;
  String placeHolder = 'Cuisines';
  String western = 'Western';
  String chinese = 'Chinese';
  String indian = 'Indian';
  String malay = 'Malay';

  /// Constructor of the Cuisine class

  Cuisines() {
    cuisines = [placeHolder, western, chinese, indian, malay];
    curr = placeHolder;
  }

  /// Returns a list of all the current cuisines available

  List<String>? getCuisines() {
    return cuisines;
  }

  /// Returns the current cuisine that was selected, including the placeholder
  /// if it is selected.

  String? getCurr() {
    return curr;
  }
}
