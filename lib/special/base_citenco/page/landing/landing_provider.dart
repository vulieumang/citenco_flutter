import 'package:cnvsoft/core/base_core/base_notifier.dart';
import 'package:cnvsoft/core/base_core/base_provider.dart';  
import 'package:cnvsoft/special/base_citenco/package/level_asset.dart'; 

import 'landing_page.dart';

class LandingProvider extends BaseProvider<LandingPageState>   {
  LandingProvider(LandingPageState state) : super(state);

  @override
  List<BaseNotifier> initNotifiers() => [];

  @override
  Future<void> onReady(callback) async {
    LevelAsset().initialize();
    Future.delayed(Duration(seconds: 2));
    loginBySaved(); 
  }

  

  String get splashImage => "lib/special/modify/asset/image/splash.jpg";
  
  void loginBySaved() async {
    // String? _auth = StorageCNV().getString("AUTH_TOKEN");
    // TokenModel? auth;
    // String deviceId = await Device().getDeviceId();
    // var _loginToken = StorageCNV().getString("LOGIN_TOKEN");
    // var _phone = StorageCNV().getString("PHONE_NUMBER");
    // var _customerId = StorageCNV().getString("CUSTOMER_ID");
    // TokenRequest request = TokenRequest(
    //     accountDomainName: BasePKG.of(state).http!.accountDomainName,
    //     deviceId: deviceId,
    //     phone: _phone,
    //     customerId: _customerId,
    //     loginToken: _loginToken);
    // try {
    //   auth = TokenModel.fromJson(json.decode(_auth!));
   
    // } catch (e) {
    //   print(e);
    //   Log().severe(e);
    // }
    // if (auth == null) {
    //   if (_loginToken != null && _phone != null && _customerId != null) {
    //     auth = await BasePKG.of(state).autoLogin(request);
    //     _auth = json.encode(auth.toJson());
 
    //     StorageCNV().setString("AUTH_TOKEN", _auth);
    //   } else {
    //     Navigator.of(context!).pushReplacementNamed("login");
    //   }
    // }
    
    // if(auth != null){
    //   try { 
    //     var res = await BasePKG.of(state).autoLogin(request);
    //     if(res.isSuccess){
    //       if(res.verified!){
    //         auth.accessToken = res.accessToken;
    //         _auth = json.encode(auth.toJson());
    //         StorageCNV().setString("AUTH_TOKEN", _auth);
    //         await super.login(state,
    //           request: request, token: auth, isLogin: true, autoLogin: true);
    //       }else{
    //         MyProfile().logOut(state);
    //       }
    //     }else{
    //       MyProfile().logOut(state);
    //     }
    //   } catch (e) {
    //     MyProfile().logOut(state);
    //   }
    // }      
  }
}
