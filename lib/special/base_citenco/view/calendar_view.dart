import 'dart:math';

import 'package:cnvsoft/core/base_core/base_view.dart';
import 'package:cnvsoft/special/base_citenco/package/package.dart';
import 'package:cnvsoft/special/base_citenco/package/trans.dart';
import 'package:cnvsoft/special/base_citenco/view/square_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'calendar_provider.dart';

class CalendarView extends StatefulWidget {
  final DateTime? dateSelected;
  final DateTime? minDate;
  final String? confirmText;

  const CalendarView(
      {Key? key, required this.dateSelected, this.minDate, this.confirmText})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => CalendarViewState();
}

class CalendarViewState extends BaseView<CalendarView, CalendarProvider> {
  @override
  CalendarProvider initProvider() => CalendarProvider(this);

  @override
  Widget body() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          padding: BasePKG().all(15),
          child: Column(
            children: <Widget>[
              _buildHeader(),
              Container(
                margin: BasePKG().only(top: 10),
                height: 1,
                color: BasePKG().color.line,
              ),
            ],
          ),
        ),
        _buildCalendar(),
        _buildAction(),
      ],
    );
  }

  _buildHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        IconButton(
            onPressed: provider.preMonth, icon: Icon(Icons.arrow_back_ios_new)),
        Consumer<IndexMonthNotifier>(builder: (context, value, child) {
          return Expanded(
            child: Center(
              child: Text(
                  provider.month[value.value!] + " " + provider.year.toString(),
                  style: BasePKG().text!.smallUpperMedium().copyWith()),
            ),
          );
        }),
        IconButton(
            onPressed: provider.nextMonth, icon: Icon(Icons.arrow_forward_ios))
      ],
    );
  }

  Widget _buildAction() {
    return Padding(
      padding: BasePKG().only(left: 15, right: 15, bottom: 15),
      child: Row(
        children: <Widget>[
          Expanded(
            child: SquareButton(
              padding: BasePKG().symmetric(vertical: 14),
              margin: BasePKG().zero,
              theme: BasePKG().button!.alternativeButton(context),
              text: BaseTrans().$cancel,
              onTap: Navigator.of(context).pop,
            ),
          ),
          SizedBox(width: BasePKG().convert(15)),
          Expanded(
            child: SquareButton(
              padding: BasePKG().symmetric(vertical: 14),
              margin: BasePKG().zero,
              theme: BasePKG().button!.primaryButton(context),
              text: BasePKG()
                  .stringOf(() => widget.confirmText!, BaseTrans().$confirm),
              onTap: () =>
                  Navigator.of(context).pop(provider.dateSelected.date),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildCalendar() {
    return Consumer<IndexMonthNotifier>(
      builder: (context, value, child) {
        return Wrap(
          children: provider.items.map((item) {
            return ChangeNotifierProvider.value(
              value: item,
              child: Consumer<CalendarItem>(
                builder: (context, item, child) {
                  return _buildCalendarCell(item);
                },
              ),
            );
          }).toList(),
        );
      },
    );
  }

  Widget _buildCalendarCell(CalendarItem item) {
    double _itemWidth = (size.width / 7.0).floorToDouble();
    var _bg =
        item.selected! ? BasePKG().color.primaryColor : Colors.transparent;
    var _color = item.selected! ? Colors.white : item.style!.color!;
    var _weight = item.selected! ? FontWeight.bold : FontWeight.normal;
    return GestureDetector(
      child: AnimatedContainer(
        width: _itemWidth,
        height: _itemWidth * (item.isDate ? 1 : 0.6),
        alignment: Alignment.center,
        duration: Duration(milliseconds: 200),
        child: Container(
          alignment: Alignment.center,
          margin: BasePKG().all(4),
          decoration: BoxDecoration(
              color: _bg,
              borderRadius: BorderRadius.circular(_itemWidth / 2.0)),
          child: Text(
            item.text.toString(),
            style: item.style?.copyWith(color: _color, fontWeight: _weight),
          ),
        ),
      ),
      onTap: () => provider.onTapDate(item),
    );
  }
}
