import 'package:cnvsoft/core/base_core/base_page.dart';
import 'package:cnvsoft/core/base_core/base_view.dart';
import 'package:cnvsoft/special/base_citenco/modify/home/drawer/drawer_fillter/chips_input.dart'; 
import 'package:cnvsoft/special/base_citenco/package/package.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'widget_chips_provider.dart';

enum ChildType { Sort, Filter }

class WidgetChips extends StatefulWidget {
  String? nameField;
  List<ItemInput>? listData;
  WidgetChips(
      {
        Key? key,
        this.nameField = "Chọn lĩnh vực hoạt động",
        @required this.listData
      })
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return WidgetChipsState();
  }
}

class WidgetChipsState extends BaseView<WidgetChips, WidgetChipsProvider> {
  @override
  WidgetChipsProvider initProvider() {
    return WidgetChipsProvider(this);
  }
  
  @override
  Widget body() {
    return Container(
      height: 44,
      child: ChipsInput(
        maxChips: 9,   
        findSuggestions: (String query) {
          if (query.isNotEmpty) {
              var lowercaseQuery = query.toLowerCase();
              final results = provider.mockResults.where((itemInput) {
              return itemInput.name.toLowerCase().contains(query.toLowerCase());

              }).toList(growable: false)
              ..sort((a, b) => a.name
                  .toLowerCase()
                  .indexOf(lowercaseQuery)
                  .compareTo(
                      b.name.toLowerCase().indexOf(lowercaseQuery)));
              return results;
          }
          return provider.mockResults;
        },
        decoration:  InputDecoration(
          hintText: widget.nameField,
          hintStyle: BasePKG().text!.smallUpperNormal(),
          suffixIcon: Icon(
            Icons.arrow_drop_down,
            color: Color(0xff616773),
            size: 30,
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(width: 1,color: Color(0xff00050B).withOpacity(.30)),
            borderRadius: BorderRadius.circular(10)
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1,color: Color(0xff00050B).withOpacity(.30)),
            borderRadius: BorderRadius.circular(10)
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1,color: Color(0xff00050B).withOpacity(.30)),
            borderRadius: BorderRadius.circular(10)
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1,color: Color(0xff00050B).withOpacity(.30)),
            borderRadius: BorderRadius.circular(10)
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1,color: Color(0xff00050B).withOpacity(.30)),
            borderRadius: BorderRadius.circular(10)
          ),
          contentPadding: EdgeInsets.only(left: 13,right: 13),
          ),
        onChanged: (data) {
            // print(data);
        },
        readOnly: true,
        chipBuilder: (context, state, ItemInput itemInput) {
          return InputChip(
            label: Text(
              itemInput.name,
              style: BasePKG().text!.smallUpperNormal().copyWith(color: Color(0xff252B5C).withOpacity(.63),height: 1),
            ),
            backgroundColor: Color(0xffF5F4F8),
            onDeleted: () => state.deleteChip(itemInput),
            deleteIconColor: Color(0xff26415B).withOpacity(.6),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4)
            ),
            materialTapTargetSize: MaterialTapTargetSize.padded,
          );
        },
        suggestionBuilder: (context, ItemInput itemInput) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                child: Text(
                  "${itemInput.name}",
                  style: BasePKG().text!.smallUpperNormal().copyWith(color: Color(0xff252B5C).withOpacity(.8), height: 1),
              )),
              Divider(
                height: 1,
                thickness: 1,
                color: Color(0xff252B5C).withOpacity(0.3),
              )
            ],
          );
        },
    ),
    );
  }
}