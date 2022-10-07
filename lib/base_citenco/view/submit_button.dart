import 'package:cnvsoft/core/base_core/base_notifier.dart';
import 'package:cnvsoft/core/base_core/base_provider.dart';
import 'package:cnvsoft/core/base_core/base_view.dart';
import 'package:cnvsoft/base_citenco/package/package.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

enum IsSafeArea { DEFAULT, SAFEAREA }
enum ButtonState { NORMAL, DONE, ERROR }

class SubmitButton extends StatefulWidget {
  final IsSafeArea? type;
  final Widget? icon;
  final String? text;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final ThemeData? theme;
  final double? radius;
  final Future<ButtonState> Function()? onTap;
  final List<BoxShadow>? shadow;

  const SubmitButton(this.text,
      {Key? key,
      this.padding,
      this.margin,
      this.theme,
      this.onTap,
      this.radius,
      this.icon,
      this.shadow})
      : assert(text != null,
            'A non-null String must be provided to a SubmitButton widget.'),
        type = IsSafeArea.DEFAULT,
        super(key: key);

  const SubmitButton.safeArea(this.text,
      {Key? key,
      this.icon,
      this.padding,
      this.margin,
      this.theme,
      this.radius,
      this.shadow,
      this.onTap})
      : assert(text != null,
            'A non-null String must be provided to a SubmitButton.safeArea widget.'),
        type = IsSafeArea.SAFEAREA,
        super(key: key);

  @override
  _SubmitButtonState createState() => _SubmitButtonState();
}

class _SubmitButtonState extends BaseView<SubmitButton, SubmitButtonProvider> {
  @override
  Widget body() {
    switch (widget.type) {
      case IsSafeArea.SAFEAREA:
        return SafeArea(child: submitButton());
      default:
        return submitButton();
    }
  }

  @override
  SubmitButtonProvider initProvider() => SubmitButtonProvider(this);

  Widget submitButton() {
    var _radius = this.widget.radius ?? 4;
    var radius = BorderRadius.circular(_radius);
    return Padding(
      padding:
          widget.margin ?? BasePKG().symmetric(horizontal: 20, vertical: 10),
      child: Consumer<ButtonStateNotifier>(
        builder: (context, stateButton, _) {
          return Material(
              borderRadius: radius,
              child: InkWell(
                  borderRadius: radius,
                  onTap: () => provider.animateButton(),
                  child: AnimatedContainer(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                      height: 50,
                      decoration: BoxDecoration(
                          color: _setUpColor(stateButton.value!),
                          boxShadow: widget.shadow,
                          borderRadius: radius,
                          border: _setUpBorderColor(stateButton.value!)),
                      alignment: Alignment.center,
                      child: _setUpButtonChild(stateButton.value!))),
              color: _setUpBackgroundColor(stateButton.value!));
        },
      ),
    );
  }

  Color _setUpColor(int stateButton) {
    if (stateButton == 0 || stateButton == 1) {
      return widget.theme!.buttonColor;
    } else {
      return Colors.transparent;
    }
  }

  BoxBorder _setUpBorderColor(int stateButton) {
    if (stateButton == 0 || stateButton == 1 || stateButton == 2) {
      return Border.all(color: widget.theme!.canvasColor);
    } else {
      return Border.all(color: Colors.red);
    }
  }

  Widget _setUpButtonChild(int stateButton) {
    if (stateButton == 0) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          widget.icon ?? SizedBox(),
          Text(
            widget.text!,
            style: widget.theme!.textTheme.button,
          ),
        ],
      );
    } else if (stateButton == 1) {
      return SpinKitCircle(
        color: widget.theme!.textTheme.button!.color,
      );
    } else if (stateButton == 2) {
      return SvgPicture.asset(
        "lib/special/base_citenco/asset/image/tick.svg",
        width: 25,
        height: 25,
        color: widget.theme!.buttonColor,
      );
    } else {
      return SvgPicture.asset(
        "lib/special/base_citenco/asset/image/error_ic.svg",
        width: 25,
        height: 25,
        color: Colors.red,
      );
    }
  }

  Color _setUpBackgroundColor(int stateButton) {
    var theme = this.widget.theme ?? Theme.of(context);
    if (stateButton == 0 || stateButton == 1) {
      return theme.backgroundColor;
    } else {
      return Colors.transparent;
    }
  }
}

class SubmitButtonProvider extends BaseProvider<_SubmitButtonState> {
  final ButtonStateNotifier _buttonState = ButtonStateNotifier();

  SubmitButtonProvider(_SubmitButtonState state) : super(state);

  @override
  List<BaseNotifier> initNotifiers() => [_buttonState];

  Future<void> animateButton() async {
    _buttonState.value = 1;
    await Future.delayed(Duration(milliseconds: 300));
    var result = await state.widget.onTap!();
    if (result == ButtonState.DONE) {
      _buttonState.value = 2;
      await Future.delayed(Duration(milliseconds: 1200))
          .then((_) => _buttonState.value = 0);
    } else {
      _buttonState.value = 3;
      await Future.delayed(Duration(milliseconds: 1200))
          .then((_) => _buttonState.value = 0);
    }
  }
}

class ButtonStateNotifier extends BaseNotifier<int> {
  ButtonStateNotifier() : super(0);

  @override
  ListenableProvider provider() =>
      ChangeNotifierProvider<ButtonStateNotifier>(create: (_) => this);
}
