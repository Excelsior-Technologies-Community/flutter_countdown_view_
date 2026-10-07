class CountdownDuration {
  final int days;
  final int hours;
  final int minutes;
  final int seconds;

  const CountdownDuration({
    required this.days,
    required this.hours,
    required this.minutes,
    required this.seconds,
  });
}

class CountdownUtils {
  static CountdownDuration calculateRemaining(
      DateTime targetDateTime,
      DateTime currentDateTime,
      ) {
    final difference = targetDateTime.difference(currentDateTime);

    if (difference.isNegative || difference.inSeconds <= 0) {
      return const CountdownDuration(
        days: 0,
        hours: 0,
        minutes: 0,
        seconds: 0,
      );
    }

    final totalSeconds = difference.inSeconds;

    final days = totalSeconds ~/ Duration.secondsPerDay;
    final remainingAfterDays =
        totalSeconds % Duration.secondsPerDay;

    final hours = remainingAfterDays ~/ Duration.secondsPerHour;
    final remainingAfterHours =
        remainingAfterDays % Duration.secondsPerHour;

    final minutes = remainingAfterHours ~/ Duration.secondsPerMinute;
    final seconds = remainingAfterHours % Duration.secondsPerMinute;

    return CountdownDuration(
      days: days,
      hours: hours,
      minutes: minutes,
      seconds: seconds,
    );
  }

  static String formatNumber(int value) {
    return value.toString().padLeft(2, '0');
  }
}