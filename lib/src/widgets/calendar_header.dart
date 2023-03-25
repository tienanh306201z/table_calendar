// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '../../table_calendar.dart';
import 'custom_icon_button.dart';
import 'format_button.dart';

class CalendarHeader extends StatelessWidget {
  final dynamic locale;
  final DateTime focusedMonth;
  final CalendarFormat calendarFormat;
  final HeaderStyle headerStyle;
  final VoidCallback onLeftChevronTap;
  final VoidCallback onRightChevronTap;
  final VoidCallback onHeaderTap;
  final VoidCallback onHeaderLongPress;
  final ValueChanged<CalendarFormat> onFormatButtonTap;
  final Map<CalendarFormat, String> availableCalendarFormats;
  final DayBuilder? headerTitleBuilder;

  const CalendarHeader({
    Key? key,
    this.locale,
    required this.focusedMonth,
    required this.calendarFormat,
    required this.headerStyle,
    required this.onLeftChevronTap,
    required this.onRightChevronTap,
    required this.onHeaderTap,
    required this.onHeaderLongPress,
    required this.onFormatButtonTap,
    required this.availableCalendarFormats,
    this.headerTitleBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final text = headerStyle.titleTextFormatter?.call(focusedMonth, locale) ??
        DateFormat.yMMMM(locale).format(focusedMonth);

    return Container(
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.27)
      ),
      margin: headerStyle.headerMargin,
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        children: [
          LayoutBuilder(
            builder: (_, constraint) => Row(
              children: [
                ...List.generate(
                  7,
                  (index) => Container(
                    width: constraint.maxWidth / 7,
                    height: constraint.maxWidth / 7,
                    alignment: Alignment.center,
                    child: Text(
                      _getWeekdaysFirstLetterByNumber(index),
                      style: headerStyle.weekDaysTextStyle,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: headerTitleBuilder?.call(context, focusedMonth) ??
                      GestureDetector(
                        onTap: onHeaderTap,
                        onLongPress: onHeaderLongPress,
                        child: Text(
                          text,
                          style: headerStyle.titleTextStyle,
                        ),
                      ),
                ),
              ),
              if (headerStyle.leftChevronVisible)
                CustomIconButton(
                  icon: headerStyle.leftChevronIcon,
                  onTap: onLeftChevronTap,
                  margin: headerStyle.leftChevronMargin,
                  padding: headerStyle.leftChevronPadding,
                ),
              if (headerStyle.formatButtonVisible &&
                  availableCalendarFormats.length > 1)
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: FormatButton(
                    onTap: onFormatButtonTap,
                    availableCalendarFormats: availableCalendarFormats,
                    calendarFormat: calendarFormat,
                    decoration: headerStyle.formatButtonDecoration,
                    padding: headerStyle.formatButtonPadding,
                    textStyle: headerStyle.formatButtonTextStyle,
                    showsNextFormat: headerStyle.formatButtonShowsNext,
                  ),
                ),
              if (headerStyle.rightChevronVisible)
                CustomIconButton(
                  icon: headerStyle.rightChevronIcon,
                  onTap: onRightChevronTap,
                  margin: headerStyle.rightChevronMargin,
                  padding: headerStyle.rightChevronPadding,
                ),
            ],
          ),
        ],
      ),
    );
  }

  String _getWeekdaysFirstLetterByNumber(int number) {
    switch (number) {
      case 0:
        return 'S';
      case 1:
        return 'M';
      case 2:
        return 'T';
      case 3:
        return 'W';
      case 4:
        return 'T';
      case 5:
        return 'F';
      case 6:
        return 'S';
      default:
        return '';
    }
  }
}
