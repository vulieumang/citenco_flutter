import 'package:cnvsoft/special/base_citenco/package/package.dart';
import 'package:flutter/material.dart';

class GetCheckValue extends StatefulWidget {
  @override
  GetCheckValueState createState() {
    return new GetCheckValueState();
  }
}

class GetCheckValueState extends State<GetCheckValue> {
  
var estateRooms = [
  CheckedBox(false, "Seed"),
  CheckedBox(false, "A"),
  CheckedBox(false, "B"),
  CheckedBox(false, "C"),
  CheckedBox(false, "D"),
];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        for (var item in estateRooms)
          Container(
            width: MediaQuery.of(context).size.width/3 - 32,
            child: Theme(
              data: ThemeData(
                checkboxTheme: CheckboxThemeData(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                unselectedWidgetColor: const Color(0xFFB4B7BC),
              ),
              child: CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                activeColor: BaseColor().primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4)
                ),
                controlAffinity: ListTileControlAffinity.leading,
                title: Container(
                  width: MediaQuery.of(context).size.width/3 - 32,
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          '${item.name}',
                          style: BasePKG().text!.smallUpperNormal().copyWith(color: Color(0xff252B5C)),
                        ),
                      ),
                    ],
                  ),
                ),
                value: item.isSelected,
                onChanged: (value) {
                  setState(() {
                    item.isSelected = value!;
                  });
                },
              ),
            ),
          ),
      ],
    );
  }
}

class CheckedBox {
  bool isSelected;
  String name;

  CheckedBox(this.isSelected, this.name);
}