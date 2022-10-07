import 'package:cnvsoft/special/base_citenco/package/package.dart';
import 'package:cnvsoft/special/base_citenco/package/trans.dart';
import 'package:cnvsoft/special/base_citenco/view/square_button.dart';
import 'package:cnvsoft/special/base_citenco/view/text_field_label.dart';
import 'package:flutter/material.dart';

class InputTopupDialog extends StatelessWidget {
  final Function(String text)? onSubmit;
  final TextEditingController inputCtr = TextEditingController();
  final int? maxLength;

  static Future show(State state,
      {required Function(String text) onTap,
      required String inputPrice,
      int? maxLength}) async {
    return await showDialog(
        context: state.context,
        builder: (context) => InputTopupDialog(
              inputPrice,
              onSubmit: onTap,
              maxLength: maxLength,
            ));
  }

  InputTopupDialog(
    String inputValue, {
    Key? key,
    this.onSubmit,
    this.maxLength,
  }) : super(key: key) {
    this.inputCtr.text = inputValue;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        backgroundColor: BasePKG().color.dialog,
        child: Container(
            padding: BasePKG().symmetric(horizontal: 24, vertical: 15),
            child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              TextFieldLabel(
                  controller: inputCtr,
                  label: BaseTrans().$paymentAmount,
                  textAlign: TextAlign.center,
                  padding: BasePKG().symmetric(vertical: 8),
                  theme: BasePKG().button!.primaryTextField(context),
                  textInputType: TextInputType.number,
                  maxLength: maxLength!,
                  fontSize: 24),
              SizedBox(height: BasePKG().convert(24)),
              SquareButton(
                  text: BaseTrans().$agree,
                  onTap: () => onSubmit!(inputCtr.text),
                  margin: BasePKG().zero,
                  padding: BasePKG().all(12),
                  theme: BasePKG()
                      .button!
                      .primaryButton(context, fontWeight: FontWeight.normal))
            ])));
  }
}
