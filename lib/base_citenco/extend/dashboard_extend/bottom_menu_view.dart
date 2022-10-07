import 'package:cnvsoft/core/storage.dart';
import 'package:cnvsoft/base_citenco/modify/package.dart';
import 'package:cnvsoft/base_citenco/package/package.dart';
import 'package:cnvsoft/base_citenco/package/scope.dart'; 
import 'package:cnvsoft/base_citenco/view/fade_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'bottom_menu_icon.dart';

enum BottomMenuStyle { Standard, Bar }

class BottomMenuView extends StatelessWidget {
  final List<BottomMenuIcon>? items;
  final double? height;
  final double? iconSize;
  final int? selected;
  final Color? color;
  final Color? selectedColor;
  final Color? backgroundColor;
  final int? count;
  final int? style;

  BottomMenuView({
    this.selected,
    this.items,
    this.height: 72.0,
    this.iconSize: 24.0,
    this.color,
    this.selectedColor,
    this.count,
    this.backgroundColor,
    this.style: 1,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BottomAppBar(
            // elevation:4,
            child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(
                    count!, (index) => _buildTabItem1(items![index]))),
            color:   Colors.white ,
          )
      ],
    );
  }
   Widget _buildTabItem1(BottomMenuIcon item) {
    Color? color = BasePKG().boolOf(() => item.fillColor!)
        ? (item.index == selected
            ? Color(0xff0D2A5C)
            : BasePKG().color.textCard.withOpacity(0.5))
        : null;
    TextStyle style = item.index == selected
        ? BasePKG().text!.tinyBold().copyWith(color: color)
        : BasePKG().text!.tinyNormal().copyWith(color: color);
    return Expanded(
      child: SizedBox(
        height: 72,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            customBorder: CircleBorder(),
            onTap: item.onTap,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    color: Colors.transparent,
                    alignment: Alignment.center,
                    child: item.asset!.startsWith("http")
                        ? Stack(
                          alignment: Alignment.topRight,
                          children: [
                            _buildNetworkIcon(
                                item.asset!, iconSize!, color!),
                          ],
                        )
                        : Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Container( 
                              padding: count == 0
                              ? EdgeInsets.zero
                              : EdgeInsets.only(right: count! > 99 ? 6 : 8, top: 6,left: 6),
                              child: _buildAssetIcon(
                                  item.index == selected ? item.assetActive! : item.asset!, iconSize!, color!),
                            ), 
                          ],
                        )),
                SizedBox(height: 5),
                Text(
                  item.name! ,
                  // item.index == 1 ? item.name!.toLowerCase() :item.name!,
                  style: style,
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
 


  Widget _buildNetworkIcon(String asset, double size, Color color) {
    return asset.endsWith(".svg")
        ? _buildSVGIcon(asset, size, color, network: true)
        : _buildPNGIcon(asset, size, color, network: true);
  }

  Widget _buildAssetIcon(String asset, double size, Color color) {
    return asset.endsWith(".svg")
        ? _buildSVGIcon(asset, size, color)
        : _buildPNGIcon(asset, size, color);
  }

  Widget _buildSVGIcon(String asset, double size, Color color,
      {bool network: false}) {
    return network
        ? FadeInImageView.fromSize(
            asset,
            width: size,
            height: size,
            fit: BoxFit.contain,
            color: color,
            cacheKey: "$asset",
          )
        : SvgPicture.asset(
            asset,
            width: size,
            height: size,
            fit: BoxFit.contain,
            color: color,
          );
  }

  Widget _buildPNGIcon(String asset, double size, Color color,
      {bool network: false}) {
    return network
        ? FadeInImageView.fromSize(
            asset,
            width: size,
            height: size,
            fit: BoxFit.contain,
            color: color,
          )
        : Image.asset(
            asset,
            width: size,
            height: size,
            fit: BoxFit.contain,
            // color: color,
          );
  }
}
