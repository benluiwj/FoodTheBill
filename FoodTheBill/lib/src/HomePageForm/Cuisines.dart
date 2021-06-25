class Cuisines {
  List<String>? cuisines;
  String? curr;
  String placeHolder = 'Cuisines';
  String western = 'Western';
  String chinese = 'Chinese';
  String indian = 'Indian';
  String malay = 'Malay';

  Cuisines() {
    cuisines = [placeHolder, western, chinese, indian, malay];
    curr = placeHolder;
  }

  List<String>? getCuisines() {
    return cuisines;
  }

  String? getCurr() {
    return curr;
  }
}
