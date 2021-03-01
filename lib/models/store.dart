
class Store {
  String imagePath;
  String name;
  double distance;
  int openTime;
  int closeTime;

  Store({this.imagePath, this.distance, this.name, this.openTime, this.closeTime});

  set setDistance(double distance) {
    this.distance = distance;
  }

  double get getDistance {
    return this.distance;
  }

  String get getImagePath {
    return this.imagePath;
  }

  String get getName {
    return this.name;
  }

  int get getOpenTime {
    return this.openTime;
  }

  int get getCloseTime {
    return this.closeTime;
  }

  set setImagePath(String imagePath)  {
    this.imagePath = imagePath;
  }

  set setName(String name)  {
    this.name = name;
  }

  set setOpenTime(int time)  {
    this.openTime = time;
  }

  set setCloseTime(int time)  {
    this.closeTime = time;
  }


}