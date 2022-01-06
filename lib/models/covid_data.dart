class CovidData {
  int? id;
  String? country;
  List<int?>? stats;
  String? drawTime;

  CovidData(this.country, this.stats, this.drawTime);

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
    }
    map['country'] = country;
    map['stats'] = stats;
//    map['cases'] = stats[0];
//    map['deaths'] =stats[1];
//    map['recovered']= stats[2];
//    map['cases_today']= stats[3];
    map['date'] = drawTime;

    return map;
  }

  // reverse map object yto patient object
  CovidData.fromMapObject(Map<String, dynamic> map) {
    this.id = map['id'];
    this.country = map['country'];
    this.stats = map['stats'];
//    stats[0] = map['cases'] ;
//    stats[1]= map['deaths'] ;
//    stats[2]= map['recovered'];
//    stats[3]=  map['cases_today'] ;
    this.drawTime = map['drawTime'];
  }
}
