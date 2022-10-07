import 'package:cnvsoft/core/base_core/base_view.dart';

import 'package:cnvsoft/special/base_citenco/package/package.dart';
import 'package:cnvsoft/special/base_citenco/package/trans.dart';
import 'package:cnvsoft/special/base_citenco/view/countdown_timer_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../util.dart';

enum CountDownType { Basic, Extend }

class CountDownTimerView extends StatefulWidget {
  final String? expiredTime;
  final CountDownType? countDownType;
  final TextStyle? typeStyle;
  final TextStyle? numberStyle;
  final Function? onExpired;

  CountDownTimerView(
      {Key? key,
      required this.expiredTime,
      this.countDownType = CountDownType.Basic,
      this.typeStyle,
      this.numberStyle,
      this.onExpired})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => CountDownTimerViewState();

  factory CountDownTimerView.basic(
      {required String expiredTime,
      CountDownType? countDownType,
      TextStyle? numberStyle,
      Function? onExpired}) {
    return CountDownTimerView(
        expiredTime: expiredTime,
        countDownType: CountDownType.Basic,
        numberStyle: numberStyle,
        onExpired: onExpired);
  }

  factory CountDownTimerView.extend(
      {required String expiredTime,
      CountDownType? countDownType,
      TextStyle? typeStyle,
      TextStyle? numberStyle,
      Function? onExpired}) {
    return CountDownTimerView(
        expiredTime: expiredTime,
        countDownType: CountDownType.Extend,
        typeStyle: typeStyle,
        numberStyle: numberStyle,
        onExpired: onExpired);
  }
}

class CountDownTimerViewState
    extends BaseView<CountDownTimerView, CountDownTimerProvider> {
  @override
  CountDownTimerProvider initProvider() => CountDownTimerProvider(this);

  @override
  Widget body() {
    return Consumer<TimerNotifier>(
      builder: (context, timer, _) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: widget.countDownType == CountDownType.Extend
              ? _buildExtendCountDown(timer.value!)
              : _buildBasicCountDown(timer.value!),
        );
      },
    );
  }

  Widget _buildExtendCountDown(TimerData timer) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _buildTimerItem(Utils.upperCaseFirst(BaseTrans().$hours),
            BasePKG().intOf(() => timer.hours!)),
        _buildTimerDivider(),
        _buildTimerItem(Utils.upperCaseFirst(BaseTrans().$minutes),
            BasePKG().intOf(() => timer.min!)),
        _buildTimerDivider(),
        _buildTimerItem(Utils.upperCaseFirst(BaseTrans().$seconds),
            BasePKG().intOf(() => timer.sec!)),
      ],
    );
  }

  Widget _buildTimerItem(String type, int number) {
    return Column(
      children: [
        Text(
          type,
          style: widget.typeStyle ??
              BasePKG()
                  .text!
                  .normalLowerMedium()
                  .copyWith(color: BasePKG().color.red),
        ),
        Text(
          "$number",
          style: widget.numberStyle ??
              BasePKG()
                  .text!
                  .captionMedium()
                  .copyWith(color: BasePKG().color.red, fontSize: 30),
        )
      ],
    );
  }

  Widget _buildTimerDivider() {
    return Container(
      padding: BasePKG().symmetric(
          horizontal: 5,
          vertical: widget.numberStyle != null
              ? widget.numberStyle!.fontSize! / 5
              : 5),
      child: Text(
        ":",
        style: BasePKG().text!.captionMedium().copyWith(
            color: BasePKG().color.red,
            fontSize: widget.numberStyle != null
                ? widget.numberStyle!.fontSize! - 5
                : 25),
      ),
    );
  }

  Widget _buildBasicCountDown(TimerData timer) {
    return Text(
      provider.getBasicCountDownWithZero(timer),
      style: widget.numberStyle ??
          BasePKG()
              .text!
              .smallUpperMedium()
              .copyWith(color: BasePKG().color.red),
    );
  }
}
