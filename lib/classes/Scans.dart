class MyScans {
  DateTime whenTheScanHappen;
  int? power;
  String? Rssi;
  int? type;
  int? secondForTheContact = 0;

  MyScans(this.whenTheScanHappen, this.power, this.Rssi, this.type,
      this.secondForTheContact);

  factory MyScans.fromMap(Map<String, dynamic> map) {
    return new MyScans(
      DateTime.fromMillisecondsSinceEpoch(map['whenTheScanHappen']),
      map['power'] as int?,
      map['Rssi'] as String?,
      map['type'] as int?,
      map['secondForTheContact'] as int?,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'whenTheScanHappen': this.whenTheScanHappen.millisecondsSinceEpoch,
      'power': this.power,
      'Rssi': this.Rssi,
      'type': this.type,
      'secondForTheContact': this.secondForTheContact,
    } as Map<String, dynamic>;
  }

  @override
  String toString() {
    return 'MyScans{whenTheScanHappen: $whenTheScanHappen, power: $power, Rssi: $Rssi, type: $type, secondForTheContact: $secondForTheContact}';
  }
}
