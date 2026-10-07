import 'package:flutter_countdown_view/flutter_countdown_view.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Countdown duration calculates correctly', () {
    final target = DateTime(2026, 12, 31, 12, 0, 0);
    final current = DateTime(2026, 12, 30, 10, 30, 20);

    final result = CountdownUtils.calculateRemaining(
      target,
      current,
    );

    expect(result.days, 1);
    expect(result.hours, 1);
    expect(result.minutes, 29);
    expect(result.seconds, 40);
  });

  test('Countdown duration returns zero when expired', () {
    final target = DateTime(2026, 12, 30, 10, 0, 0);
    final current = DateTime(2026, 12, 30, 11, 0, 0);

    final result = CountdownUtils.calculateRemaining(
      target,
      current,
    );

    expect(result.days, 0);
    expect(result.hours, 0);
    expect(result.minutes, 0);
    expect(result.seconds, 0);
  });

  test('Countdown number is formatted with two digits', () {
    expect(CountdownUtils.formatNumber(5), '05');
    expect(CountdownUtils.formatNumber(25), '25');
  });
}