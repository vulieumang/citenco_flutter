import 'package:cnvsoft/core/app.dart';
import 'package:cnvsoft/core/base_core/base_view.dart';
import 'package:cnvsoft/core/scope.dart';
import 'package:cnvsoft/core/storage.dart';
import 'package:cnvsoft/base_citenco/package/package.dart';
import 'package:cnvsoft/base_citenco/package/trans.dart';
import 'package:cnvsoft/base_citenco/view/square_button.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'update_version_dialog_provider.dart';

class UpdateVersionDialog extends StatefulWidget {
  const UpdateVersionDialog({
    Key? key,
  }) : super(key: key);

  static show(State state)  {
          return showDialog(
          // barrierDismissible: false,
          context: state.context,
          builder: (context) => WillPopScope(
                onWillPop: () async => true,
                child: UpdateVersionDialog(),
              ));
  }

  @override
  State<StatefulWidget> createState() => UpdateVersionState();
}

class UpdateVersionState
    extends BaseView<UpdateVersionDialog, UpdateVersionDialogProvider> {
  Widget _buildButon(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: SquareButton(
            margin: BasePKG().zero,
            padding: BasePKG().all(12),
            text: BaseTrans().$updateNow,
            onTap: () async {
              if (await provider.needRestart()) {
                App.restart();
              } else {
                if (await canLaunch(AppVersion().link)) {
                  await StorageCNV().clearVersion();
                  launch(AppVersion().link);
                }
              }
            },
            theme: BasePKG()
                .button!
                .primaryButton(context, fontWeight: FontWeight.normal),
          ),
        )
      ],
    );
  }

  Widget _buildNewVerMess() {
    return Text(
      BaseTrans().$newVesionMes,
      style: BasePKG().text!.messageDialog(),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildNewVersion() {
    return Text(
      "${BaseTrans().$newVesion} ${AppVersion().versionStr}",
      style: BasePKG().text!.titleDialog(),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildLogo() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          image: DecorationImage(
              image:
                  AssetImage("lib/special/modify/asset/image/ic_launcher.png"),
              fit: BoxFit.cover)),
      height: BasePKG().convert(72),
      width: BasePKG().convert(72),
    );
  }

  @override
  Widget body() {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
            color: BasePKG().color.dialog,
            borderRadius: BorderRadius.all(Radius.circular(8))),
        padding: BasePKG().symmetric(horizontal: 12, vertical: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _buildLogo(),
            SizedBox(height: BasePKG().convert(12)),
            _buildNewVersion(),
            SizedBox(height: BasePKG().convert(12)),
            _buildNewVerMess(),
            SizedBox(height: BasePKG().convert(52)),
            _buildButon(context),
          ],
        ),
      ),
    );
  }

  @override
  Future resume() async {
    if (await provider.needRestart()) App.restart();
    return super.resume();
  }

  @override
  UpdateVersionDialogProvider initProvider() =>
      UpdateVersionDialogProvider(this);
}
