import 'package:cnvsoft/base_citenco/package/package.dart';
import 'package:cnvsoft/base_citenco/package/trans.dart';
import 'package:cnvsoft/base_citenco/view/bottom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class OptionItem extends ChangeNotifier {
  final String text;
  int amount;

  OptionItem({required this.text, required this.amount});

  void minusAmount() {
    if (amount > 0) {
      this.amount--;
    }
    notifyListeners();
  }

  void plusAmount() {
    this.amount++;
    notifyListeners();
  }
}

class OptionListView extends StatelessWidget {
  final List<OptionItem> items;
  final int? selectedIndex;
  final String? title;
  final EdgeInsets? paddingItem;
  final Function()? onClose;
  final Function()? onConfirm;

  const OptionListView(
      {Key? key,
      this.selectedIndex = -1,
      required this.items,
      this.title,
      this.paddingItem,
      this.onClose,
      this.onConfirm})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: BasePKG().color.card,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (title != null) ...[_buildTitle(context), _buildDivider()],
            _buildItems(),
            _buildConfirmBtn()
          ],
        ),
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Padding(
      padding: BasePKG().only(bottom: 12),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              title!,
              style: BasePKG().text!.largeLowerBold(),
            ),
          ),
          GestureDetector(
            child: Container(
              alignment: Alignment.center,
              color: Colors.transparent,
              height: BasePKG().convert(32),
              width: BasePKG().convert(32),
              child: SizedBox(
                child: SvgPicture.asset(
                  "lib/base_citenco/asset/image/close.svg",
                ),
                height: BasePKG().convert(16),
                width: BasePKG().convert(16),
              ),
            ),
            onTap: onClose ?? Navigator.of(context).pop,
          )
        ],
      ),
    );
  }

  Widget _buildItems() {
    return ListView.separated(
      padding: BasePKG().zero,
      itemCount: items.length,
      primary: false,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        OptionItem _item = items[index];
        return ChangeNotifierProvider.value(
          value: _item,
          child: Consumer<OptionItem>(
            builder: (context, value, _) {
              return Container(
                height: BasePKG().convert(55),
                color: Colors.transparent,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        value.text,
                        overflow: TextOverflow.ellipsis,
                        style: BasePKG().text!.smallNormal(),
                      ),
                    ),
                    _buildOption(value),
                  ],
                ),
              );
            },
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) => _buildDivider(),
    );
  }

  Widget _buildOption(OptionItem item) {
    double _iconSize = 25;
    return Row(children: [
      GestureDetector(
        onTap: item.minusAmount,
        child: Image.asset(
          "lib/special/base_citenco/asset/image/minus_ic.png",
          width: _iconSize,
          height: _iconSize,
        ),
      ),
      Padding(
        padding: BasePKG().symmetric(horizontal: 15),
        child: Text(
          "${item.amount}",
          style: BasePKG().text!.smallUpperBold(),
        ),
      ),
      GestureDetector(
        onTap: item.plusAmount,
        child: Image.asset(
          "lib/special/base_citenco/asset/image/plus_ic.png",
          width: _iconSize,
          height: _iconSize,
        ),
      ),
    ]);
  }

  Widget _buildDivider() {
    return Divider(
      height: 1,
      thickness: 0.5,
      color: BasePKG().color.line,
    );
  }

  Widget _buildConfirmBtn() {
    return BottomButtonView(
      text: BaseTrans().$confirm,
      onTap: onConfirm ?? () {},
      padding: BasePKG().zero,
    );
  }
}
