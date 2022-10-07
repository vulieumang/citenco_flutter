import 'package:cnvsoft/core/base_core/base_notifier.dart';
import 'package:cnvsoft/core/base_core/base_provider.dart';
import 'package:cnvsoft/base_citenco/package/package.dart';
import 'package:cnvsoft/base_citenco/package/trans.dart';
import 'package:cnvsoft/base_citenco/util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import 'calendar_view.dart';

class CalendarProvider extends BaseProvider<CalendarViewState> {
  final IndexMonthNotifier _indexMonth = IndexMonthNotifier();

  String? language;
  CalendarItem dateSelected = CalendarItem.init(now);
  List<CalendarItem> _items = [];
  List<String> daysortVI = [
    BaseTrans().$mon,
    BaseTrans().$tue,
    BaseTrans().$wed,
    BaseTrans().$thu,
    BaseTrans().$fri,
    BaseTrans().$sat,
    BaseTrans().$sun,
  ];
  List<String> month = [
    BaseTrans().$january,
    BaseTrans().$february,
    BaseTrans().$march,
    BaseTrans().$april,
    BaseTrans().$may,
    BaseTrans().$june,
    BaseTrans().$july,
    BaseTrans().$august,
    BaseTrans().$september,
    BaseTrans().$october,
    BaseTrans().$november,
    BaseTrans().$december
  ];

  CalendarProvider(CalendarViewState state) : super(state) {
    dateSelected = CalendarItem.init(state.widget.dateSelected!);
    setIndexMonth(state.widget.dateSelected!.month - 1);
    _initDateSelected(state.widget.dateSelected);
  }

  static DateTime get now => DateTime.now();
  int year = now.year;
  List<CalendarItem> get items => _items;

  @override
  List<BaseNotifier> initNotifiers() => [_indexMonth];

  void nextMonth() {
    if (_indexMonth.value! + 1 > 11) {
      _indexMonth.value = 0;
      year++;
    } else {
      _indexMonth.value = _indexMonth.value! + 1;
    }

    _generateCalendarItems(_indexMonth.value, year);
  }

  void preMonth() {
    // _indexMonth.value = _indexMonth.value! - 1;
    if (_indexMonth.value! - 1 < 0) {
      _indexMonth.value = 11;
      year--;
    } else {
      _indexMonth.value = _indexMonth.value! - 1;
    }

    _generateCalendarItems(_indexMonth.value, year);
  }

  void setIndexMonth(int? value) {
    _generateCalendarItems(value, year);
    // _initDateSelected(dateSelected.date);
    _indexMonth.value = value;
  }

  void _generateCalendarItems(int? month, int year) {
    var minDate = state.widget.minDate;
    _items = List.generate(7, (index) {
      String text = daysortVI[index];
      return CalendarItem(
          indexMonth: -1,
          text: text,
          style: BasePKG()
              .text!
              .smallBold()
              .copyWith(color: BasePKG().color.calendarInMonth));
    });
    DateTime _startOfMonth = DateTime(year, month! + 1);
    DateTime _startCalendar =
        _startOfMonth.subtract(Duration(days: _startOfMonth.weekday - 1));
    for (int i = 0; i < 35; i++) {
      DateTime _date = _startCalendar.add(Duration(days: i));
      bool _isOutMonth = _date.month != _startOfMonth.month;
      String _text = _date.day.toString();
      TextStyle _style = BasePKG().text!.normalLowerNormal().copyWith(
          color:
              _isOutMonth || BasePKG().boolOf(() => !minDate!.isBefore(_date))
                  ? BasePKG().color.calendarOutMonth
                  : BasePKG().color.calendarInMonth);
      bool _isSelected = false;
      _items.add(CalendarItem(
          selected: _isSelected,
          indexMonth: month,
          text: _text,
          style: _style,
          date: _date));
      // if (_isSelected) dateSelected = _items.last!;
    }
    if ((_startCalendar.month) == 2 &&
        (_startCalendar.year % 4 != 0) &&
        _items[7].text == "1") {
      _items.removeRange(35, 42);
    } else if ((_startCalendar.month + 1) != 2) {
      switch ((_startCalendar.month + 1) > 12
          ? (_startCalendar.month + 1 - 12)
          : (_startCalendar.month + 1)) {
        case 1:
        case 3:
        case 5:
        case 7:
        case 8:
        case 10:
        case 12:
          if (_items[41].text == "29" || _items[41].text == "30") {
            addmoreCalendar(month);
          }
          break;
        case 4:
        case 6:
        case 9:
        case 11:
          if (_items[41].text == "29") {
            addmoreCalendar(month);
          }
          break;
      }
    }
  }

  addmoreCalendar(int month) {
    DateTime _startOfMonth = DateTime(year, month + 2);
    DateTime _startCalendar =
        _startOfMonth.subtract(Duration(days: _startOfMonth.weekday - 1));
    for (int i = 0; i < 7; i++) {
      DateTime _date = _startCalendar.add(Duration(days: i));
      bool _isOutMonth = _date.month + 1 != _startOfMonth.month;
      String _text = _date.day.toString();
      TextStyle _style = BasePKG().text!.normalLowerNormal().copyWith(
          color: _isOutMonth
              ? BasePKG().color.calendarOutMonth
              : BasePKG().color.calendarInMonth);
      bool _isSelected = false;
      _items.add(CalendarItem(
          selected: _isSelected,
          indexMonth: month,
          text: _text,
          style: _style,
          date: _date));
    }
  }

  onTapDate(CalendarItem item) {
    if (item.date != null && item.date?.year == year) {
      var minDate = state.widget.minDate;
      if (minDate == null || minDate.isBefore(item.date!)) {
        dateSelected.setSelected(false);
        item.setSelected(true);
        dateSelected = item;
        if (item.isOutMonth) {
          setIndexMonth(item.date!.month - 1);
        }
      }
    }
  }

  void _initDateSelected(DateTime? date) {
    CalendarItem? dateSelected =
        _items.firstWhere((t) => Utils.compareDate(t.date, date));
    if (dateSelected != null) {
      this.dateSelected = dateSelected;
      this.dateSelected.setSelected(true);
    }
  }
}

class IndexMonthNotifier extends BaseNotifier<int> {
  IndexMonthNotifier() : super(0);

  @override
  ListenableProvider provider() {
    return ChangeNotifierProvider<IndexMonthNotifier>(create: (_) => this);
  }
}

class CalendarItem extends ChangeNotifier {
  final String id = Uuid().v4();
  final String? text;
  final TextStyle? style;
  final DateTime? date;
  final int? indexMonth;
  bool? selected;

  CalendarItem(
      {required this.indexMonth,
      this.date,
      this.selected = false,
      required this.text,
      required this.style});

  factory CalendarItem.init(DateTime now) {
    return CalendarItem(
        indexMonth: now.month - 1,
        date: now,
        selected: false,
        text: now.day.toString(),
        style: BasePKG().text!.normalLowerNormal());
  }

  bool get isDate => date != null;

  bool get isOutMonth => date?.month != indexMonth! + 1;

  void setSelected(bool value) {
    this.selected = value;
    notifyListeners();
  }
}
