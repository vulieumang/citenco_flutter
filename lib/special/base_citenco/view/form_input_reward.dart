import 'package:cnvsoft/special/base_citenco/mix/profile_mix.dart';
import 'package:cnvsoft/special/base_citenco/package/package.dart';
import 'package:cnvsoft/special/base_citenco/package/trans.dart';
import 'package:cnvsoft/special/base_citenco/view/square_button.dart';
import 'package:flutter/material.dart';

class FormInputReward extends StatelessWidget {
  final TextEditingController? codeController;
  final Function()? verifyCode;
  final Function()? screenNavigate;
  final State state;

  FormInputReward(this.state,
      {Key? key, this.codeController, this.verifyCode, this.screenNavigate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Container(
      color: BasePKG().color.card,
      padding: BasePKG().all(14),
      child: Stack(
        alignment: Alignment.centerRight,
        children: <Widget>[
          Container(
              alignment: Alignment.center,
              child: TextField(
                controller: codeController,
                style: BasePKG().text!.smallBold(),
                cursorColor: BasePKG().color.primaryColor,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: BasePKG().only(right: _size.width / 2.5),
                    hintText: BaseTrans().$inputYourEventCode + "...",
                    hintStyle: BasePKG()
                        .text!
                        .smallNormal().copyWith(color: BasePKG().color.description)),
              )),
          Align(
            alignment: Alignment.centerRight,
            child: IntrinsicHeight(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Visibility(
                    //tạm thời ẩn phần nhập QR code
                    visible: false,
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () =>
                              MyProfile().loginAuthentic(state, screenNavigate),
                          child: Container(
                              width: 30,
                              child: Image.asset(
                                  "lib/special/base_citenco/asset/image/ic_barcode.png",)),
                        ),
                        SizedBox(width: 10),
                      ],
                    ),
                  ),
                  Container(
                    width: _size.width / 3.5,
                    child: SquareButton(
                      padding: BasePKG().symmetric(vertical: 9),
                      margin: BasePKG().all(0),
                      text: BaseTrans().$apply,
                      theme: BasePKG()
                          .button!
                          .primaryButton(context, fontSize: 13),
                      onTap: () =>
                          MyProfile().loginAuthentic(state, verifyCode),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
