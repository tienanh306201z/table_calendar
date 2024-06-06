// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0

import 'package:flutter/cupertino.dart';
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

  Color mainColor = Color(0xFFFFBA5A);

  @override
  void initState() {
    _rangeStart = DateTime(2024, 5, 3);
    _rangeEnd = DateTime(2024, 6, 12);
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
            shieldedDays: [
              DateTime.now(),
              DateTime.now().add(const Duration(days: 2)),
              DateTime.now().add(const Duration(days: 5)),
            ],
            headerStyle: HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
            ),
            calendarStyle: CalendarStyle(
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
            rangeStartDay: _rangeStart,
            rangeEndDay: _rangeEnd,
            calendarFormat: _calendarFormat,
            rangeSelectionMode: _rangeSelectionMode,
            onDaySelected: (selectedDay, focusedDay) {
              if (!isSameDay(_selectedDay, selectedDay)) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                  _rangeStart = null; // Important to clean those
                  _rangeEnd = null;
                  _rangeSelectionMode = RangeSelectionMode.toggledOff;
                });
              }
            },
            onRangeSelected: (start, end, focusedDay) {
              setState(() {
                _selectedDay = null;
                _focusedDay = focusedDay;
                _rangeStart = start;
                _rangeEnd = end;
                _rangeSelectionMode = RangeSelectionMode.toggledOn;
              });
            },
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
          ),
        ),
      ),
    );
  }
}
