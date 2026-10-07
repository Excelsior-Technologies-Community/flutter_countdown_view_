import 'dart:async';

import 'package:flutter/material.dart';

import '../models/countdown_config.dart';
import '../utils/countdown_utils.dart';

class CountdownView extends StatefulWidget {
  final DateTime targetDateTime;
  final CountdownConfig config;
  final VoidCallback? onComplete;

  const CountdownView({
    super.key,
    required this.targetDateTime,
    this.config = const CountdownConfig(),
    this.onComplete,
  });

  @override
  State<CountdownView> createState() => _CountdownViewState();
}

class _CountdownViewState extends State<CountdownView> {
  Timer? _timer;
  late CountdownDuration _remaining;
  bool _completed = false;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  @override
  void didUpdateWidget(covariant CountdownView oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.targetDateTime != widget.targetDateTime) {
      _startCountdown();
    }
  }

  void _startCountdown() {
    _timer?.cancel();
    _completed = false;

    _updateCountdown();

    if (_isCompleted(_remaining)) {
      return;
    }

    _timer = Timer.periodic(
      const Duration(seconds: 1),
          (_) => _updateCountdown(),
    );
  }

  void _updateCountdown() {
    final remaining = CountdownUtils.calculateRemaining(
      widget.targetDateTime,
      DateTime.now(),
    );

    if (!mounted) {
      return;
    }

    setState(() {
      _remaining = remaining;
    });

    if (_isCompleted(remaining)) {
      _timer?.cancel();

      if (!_completed) {
        _completed = true;
        widget.onComplete?.call();
      }
    }
  }

  bool _isCompleted(CountdownDuration duration) {
    return duration.days == 0 &&
        duration.hours == 0 &&
        duration.minutes == 0 &&
        duration.seconds == 0;
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final config = widget.config;

    return LayoutBuilder(
      builder: (context, constraints) {
        final availableWidth = constraints.maxWidth.isFinite
            ? constraints.maxWidth
            : MediaQuery.sizeOf(context).width;

        final visibleItems = <_CountdownItem>[
          if (config.showDays)
            _CountdownItem(
              value: _remaining.days,
              label: 'DAYS',
            ),
          if (config.showHours)
            _CountdownItem(
              value: _remaining.hours,
              label: 'HOURS',
            ),
          if (config.showMinutes)
            _CountdownItem(
              value: _remaining.minutes,
              label: 'MINUTES',
            ),
          if (config.showSeconds)
            _CountdownItem(
              value: _remaining.seconds,
              label: 'SECONDS',
            ),
        ];

        if (visibleItems.isEmpty) {
          return const SizedBox.shrink();
        }

        final separatorCount =
        config.showSeparators && visibleItems.length > 1
            ? visibleItems.length - 1
            : 0;

        const separatorHorizontalPadding = 6.0;
        const separatorWidth = 12.0;

        final totalSeparatorWidth =
            separatorCount *
                (separatorWidth + (separatorHorizontalPadding * 2));

        final availableBoxWidth =
            (availableWidth - totalSeparatorWidth) /
                visibleItems.length;

        final boxWidth = availableBoxWidth.clamp(
          48.0,
          config.boxWidth,
        );

        final responsiveConfig = _copyConfigWithBoxWidth(
          config,
          boxWidth,
        );

        final children = <Widget>[];

        for (var i = 0; i < visibleItems.length; i++) {
          final item = visibleItems[i];

          children.add(
            _buildTimeBox(
              value: item.value,
              label: item.label,
              config: responsiveConfig,
            ),
          );

          if (i < visibleItems.length - 1 &&
              config.showSeparators) {
            children.add(
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: separatorHorizontalPadding,
                ),
                child: Text(
                  ':',
                  style: TextStyle(
                    color: config.separatorColor,
                    fontSize: config.numberFontSize,
                    fontWeight: config.numberFontWeight,
                  ),
                ),
              ),
            );
          }
        }

        return SizedBox(
          width: availableWidth,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: children,
          ),
        );
      },
    );
  }

  CountdownConfig _copyConfigWithBoxWidth(
      CountdownConfig config,
      double boxWidth,
      ) {
    return CountdownConfig(
      backgroundColor: config.backgroundColor,
      textColor: config.textColor,
      labelColor: config.labelColor,
      separatorColor: config.separatorColor,
      borderRadius: config.borderRadius,
      boxWidth: boxWidth,
      boxHeight: config.boxHeight,
      numberFontSize: config.numberFontSize,
      labelFontSize: config.labelFontSize,
      numberFontWeight: config.numberFontWeight,
      labelFontWeight: config.labelFontWeight,
      showDays: config.showDays,
      showHours: config.showHours,
      showMinutes: config.showMinutes,
      showSeconds: config.showSeconds,
      showLabels: config.showLabels,
      showSeparators: config.showSeparators,
    );
  }

  Widget _buildTimeBox({
    required int value,
    required String label,
    required CountdownConfig config,
  }) {
    return Container(
      width: config.boxWidth,
      height: config.boxHeight,
      decoration: BoxDecoration(
        color: config.backgroundColor,
        borderRadius: BorderRadius.circular(
          config.borderRadius,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              CountdownUtils.formatNumber(value),
              style: TextStyle(
                color: config.textColor,
                fontSize: config.numberFontSize,
                fontWeight: config.numberFontWeight,
              ),
            ),
          ),
          if (config.showLabels) ...[
            const SizedBox(height: 4),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                label,
                style: TextStyle(
                  color: config.labelColor,
                  fontSize: config.labelFontSize,
                  fontWeight: config.labelFontWeight,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _CountdownItem {
  final int value;
  final String label;

  const _CountdownItem({
    required this.value,
    required this.label,
  });
}