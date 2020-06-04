import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:swimm_tracker/components/report_card.dart';

void main() {
  testWidgets('ReportCard should show default empty screen',
      (WidgetTester tester) async {
    final String title = "Example title";
    // Build our app and trigger a frame.
    await tester.pumpWidget(new Directionality(
        textDirection: TextDirection.ltr,
        child: ReportCard(title: title, laps: 10, meters: 123)));

    expect(find.text(title), findsOneWidget);
    expect(find.text("10"), findsOneWidget);
    expect(find.text("123"), findsOneWidget);
  });

  testWidgets('ReportCard should limit decimals to one',
      (WidgetTester tester) async {
    final String title = "Example title";
    // Build our app and trigger a frame.
    await tester.pumpWidget(new Directionality(
        textDirection: TextDirection.ltr,
        child: ReportCard(title: title, laps: 10.123, meters: 123.321)));

    expect(find.text(title), findsOneWidget);
    expect(find.text("10.1"), findsOneWidget);
    expect(find.text("10.123"), findsNothing);
    expect(find.text("123.3"), findsOneWidget);
    expect(find.text("123.321"), findsNothing);
  });
}
