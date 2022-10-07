import 'package:cnvsoft/base_citenco/package/package.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'fade_image.dart';

enum ImageType { SVG, Network, Asset, Multi }

class MenuItemCNV {
  final String? image;
  final String text;
  final Function()? onTap;
  final ImageType? imageType;
  final bool? fillColor;

  MenuItemCNV(
      {bool? fillColor,
      ImageType? imageType,
      this.onTap,
      this.image,
      required this.text})
      : this.fillColor = fillColor ?? true,
        this.imageType = imageType ?? ImageType.SVG;
}

class MenuListView extends StatelessWidget {
  final List<MenuItemCNV> items;
  final int? selectedIndex;
  final String? title;
  final EdgeInsets? paddingItem;
  final double? iconWidth;
  final Function()? onClose;
  final double? height;
  final bool? hasTopline;

  const MenuListView(
      {Key? key,
      this.selectedIndex = -1,
      required this.items,
      this.title,
      this.paddingItem,
      this.iconWidth,
      this.onClose,
      this.height,
      this.hasTopline = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return height != null
        ? Container(
            height: height,
            child: _buildMain(context),
          )
        : _buildMain(context);
  }

  _buildMain(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      if (title != null) ...[_buildTitle(context)],
      height != null
          ? Expanded(
              child: SingleChildScrollView(
                  child: Container(
                      color: BasePKG().color.card, child: _buildItems())))
          : Container(color: BasePKG().color.card, child: _buildItems())
    ]);
  }

  _buildTitle(BuildContext context) {
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
                  "lib/special/base_citenco/asset/image/close.svg",
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
    return ListView.builder(
        padding: BasePKG().zero,
        itemCount: items.length,
        primary: false,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          MenuItemCNV _item = items[index];
          bool hasLine = index != 0 || BasePKG().boolOf(() => hasTopline);
          return Column(
            children: [
              if (hasLine) ...[_buildDivider()],
              GestureDetector(
                  child: Container(
                      height: BasePKG().convert(55),
                      color: Colors.transparent,
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            if (_item.image != null) _buildIconItem(_item),
                            Expanded(
                              child: Text(
                                _item.text,
                                overflow: TextOverflow.ellipsis,
                                style: BasePKG().text!.smallNormal(),
                              ),
                            ),
                            if (index == selectedIndex) ...[
                              Container(
                                  alignment: Alignment.center,
                                  color: Colors.transparent,
                                  height: BasePKG().convert(32),
                                  width: BasePKG().convert(32),
                                  child: SizedBox(
                                      height: BasePKG().convert(16),
                                      width: BasePKG().convert(16),
                                      child: SvgPicture.asset(
                                          "lib/special/base_citenco/asset/image/check.svg",
                                          color: BasePKG().color.primaryColor)))
                            ]
                          ])),
                  onTap: _item.onTap ?? () {}),
            ],
          );
        });
  }

  Widget _buildDivider() {
    return Divider(
      height: 1,
      thickness: 0.5,
      color: BasePKG().color.line,
    );
  }

  _buildIconItem(MenuItemCNV item) {
    ImageType type = item.imageType ?? ImageType.SVG;
    return Padding(
      padding: paddingItem ?? BasePKG().only(right: BasePKG().convert(14)),
      child: SizedBox(
        height: BasePKG().convert(16),
        width: iconWidth ?? BasePKG().convert(16),
        child: type == ImageType.Multi
            ? FadeInImageView(imageUrl: BasePKG().stringOf(() => item.image))
            : type == ImageType.SVG
                ? SvgPicture.asset(
                    item.image!,
                    color:
                        item.fillColor! ? BasePKG().color.primaryColor : null,
                  )
                : (type == ImageType.Asset
                    ? Image.asset(
                        item.image!,
                        color: item.fillColor!
                            ? BasePKG().color.primaryColor
                            : null,
                      )
                    : Image.network(
                        item.image!,
                        color: item.fillColor!
                            ? BasePKG().color.primaryColor
                            : null,
                      )),
      ),
    );
  }
}
