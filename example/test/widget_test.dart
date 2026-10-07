import 'package:flutter_test/flutter_test.dart';

import 'package:example/main.dart';

void main() {
  testWidgets(
    'Countdown demo app renders correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(const CountdownDemoApp());

      expect(find.text('Countdown View'), findsOneWidget);
      expect(find.text('Your event starts in'), findsOneWidget);
    },
  );
}