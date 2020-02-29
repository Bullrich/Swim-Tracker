class SwimRecord {
  final int laps;
  final int length;
  final int time;
  final int id;

  const SwimRecord({this.id = -1, this.laps, this.length, this.time});

  Map<String, dynamic> toMap() {
    return {
      'time': time,
      'laps': laps,
      'length': length,
    };
  }
}
