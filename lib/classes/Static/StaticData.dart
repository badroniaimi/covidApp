class StaticData {
  final List<int> data;
  final List<DateTime> xAxis;
  final String title;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  const StaticData({
    required this.data,
    required this.xAxis,
    required this.title,
  });

  @override
  String toString() {
    return 'staticData{data: $data, xAxis: $xAxis, title: $title}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StaticData &&
          runtimeType == other.runtimeType &&
          data == other.data &&
          xAxis == other.xAxis &&
          title == other.title);

  @override
  int get hashCode => data.hashCode ^ xAxis.hashCode ^ title.hashCode;

  factory StaticData.fromMap(Map<String, dynamic> map) {
    return new StaticData(
      data: map['data'] as List<int>,
      xAxis: map['xAxis'] as List<DateTime>,
      title: map['title'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'data': this.data,
      'xAxis': this.xAxis,
      'title': this.title,
    } as Map<String, dynamic>;
  }

//</editor-fold>

  static final listOfMe = <StaticData>[];
}
