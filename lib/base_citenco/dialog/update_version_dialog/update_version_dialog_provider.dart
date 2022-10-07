import 'package:cnvsoft/core/base_core/base_notifier.dart';
import 'package:cnvsoft/core/base_core/base_provider.dart';
import 'package:cnvsoft/core/scope.dart';
import 'package:cnvsoft/base_citenco/package/package.dart';
import 'package:package_info/package_info.dart';

import 'update_version_dialog.dart';

class UpdateVersionDialogProvider extends BaseProvider<UpdateVersionState> {
  UpdateVersionDialogProvider(UpdateVersionState state) : super(state);

  @override
  List<BaseNotifier> initNotifiers() {
    return [];
  }

  Future<bool> needRestart() async {
    bool _i = false;
    await loading(() async {
      await AppVersion().load(state, true);
      var info = await PackageInfo.fromPlatform();
      int deviceVersion =
          BasePKG().intOf(() => int.parse(info.version.split(".").join("")), 0);
      _i = AppVersion().version <= deviceVersion;
    });
    return _i;
  }
}
