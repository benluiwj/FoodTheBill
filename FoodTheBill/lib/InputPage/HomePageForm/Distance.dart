class Distances {
  List<String>? distances;
  String? curr;
  String placeHolder = 'Distance';
  final String nearest = '1km to 3km';
  final String nearer = '4km to 6km';
  final String near = '7km to 9km';
  final String far = 'Up to 10km';
  final int nearestDist = 3000;
  final int nearerDist = 6000;
  final int nearDist = 9000;
  final int farDist = 10000;
  Map<String, int>? distanceTable;

  Distances() {
    distances = [placeHolder, nearest, nearer, near, far];
    distanceTable = {
      nearest: nearestDist,
      nearer: nearerDist,
      near: nearDist,
      far: farDist
    };
    curr = placeHolder;
  }

  List<String>? getDistances() {
    return distances;
  }

  String? getCurr() {
    return curr;
  }

  int getDistance() {
    return distanceTable![curr]!;
  }
}