// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../utils.dart';

class TableRangeExample extends StatefulWidget {
  @override
  _TableRangeExampleState createState() => _TableRangeExampleState();
}

class _TableRangeExampleState extends State<TableRangeExample> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOn;

  // Can be toggled on/off by long pressing a date
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  Color mainColor = Color(0xFFFFAB33);

  @override
  void initState() {
    _rangeStart = DateTime(2024, 6, 1);
    _rangeEnd = DateTime.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text('TableCalendar - Range')),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.05),
          child: TableCalendar(
            openType: OpenType.useShield,
            rangeStartDay: _rangeStart,
            rangeEndDay: _rangeEnd,
            shieldedDays: [
              DateTime.now(),
              DateTime.now().add(const Duration(days: -2)),
            ],
            headerStyle: HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
            ),
            calendarStyle: CalendarStyle(
              outsideDaysVisible: false,
              withinRangeTextStyle: TextStyle(fontSize: 16, color: mainColor),
              rangeStartTextStyle: TextStyle(fontSize: 16, color: mainColor),
              rangeHighlightColor: mainColor.withOpacity(0.2),
              rangeStartDecoration: BoxDecoration(
                color: mainColor.withOpacity(0.2),
                borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(60),
                  right: Radius.zero,
                ),
              ),
              rangeEndDecoration: BoxDecoration(
                color: mainColor,
                borderRadius: BorderRadius.circular(60),
              ),
            ),
            firstDay: kFirstDay,
            lastDay: kLastDay,
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            calendarFormat: _calendarFormat,
            rangeSelectionMode: _rangeSelectionMode,
            onDaySelected: (_, __) {},
            onRangeSelected: (_, __, ___) {},
            onFormatChanged: (_) {},
            onPageChanged: (_) {},
          ),
        ),
      ),
    );
  }
}
