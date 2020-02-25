class SwimRecord {
  final int laps;
  final int length;
  final int time;

  const SwimRecord({this.laps, this.length, this.time});

  Map<String, dynamic> toMap() {
    return {
      'time': time,
      'laps': laps,
      'length': length,
    };
  }
}
