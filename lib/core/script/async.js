const fs = require("fs");
const exec = require("child_process").exec;
const colors = require("colors");
const cliProgress = require("cli-progress");

const utils = require("./utils");

const path = __dirname + "/../../..";

var bar;

const resolveLibs = [
    "-flutter_barcode_scanner",
    "-webview_flutter_plus",
    "-http_extensions_log",
    "-sentry",
    "-share",
    "-flutter_html",
    "-flutter_user_agentx",
    "-flutter_user_agent",
    "-apple_sign_in",
    "-data_connection_checker",
    "carousel_slider:*4.0.0",
    "phone_number:*0.11.0+2",
    "qr_code_scanner:*0.5.2",
    "intl:*0.17.0",
    "extended_image:*4.1.0",
    "crypto:*3.0.1",
    "http_extensions:*1.0.0",
    "new_version:*0.2.2",
    "url_launcher:*6.0.9",
    "geocoding:*2.0.0",
    "webview_flutter:*2.0.10",
    "flutter_svg:*0.22.0",
    "firebase_auth:*3.0.1",
    "firebase_core:*1.4.0",
    "firebase_messaging:*10.0.4",
    "flutter_local_notifications:*8.0.0",
    "device_info:*2.0.2",
    "flutter_facebook_auth:*3.5.0",
    "dio:*4.0.0",
    "connectivity:*3.0.6",
    "flutter_widget_from_html:*0.6.1",
    "cached_network_image:*3.1.0",
    "geolocator:*7.4.0",
    "provider:*5.0.0",
    "google_sign_in:*5.0.5",
    "google_maps_flutter:*2.0.6",
    "image_picker:*0.8.2",
    "shared_preferences:*2.0.6",
    "flutter_keyboard_visibility:*5.0.3",
    "rxdart:*0.27.1",
    "exif:*3.0.0",
    "fk_user_agent:*2.0.1",
    "vibration:*1.7.4-nullsafety.0",
    "shake:*1.0.1",
    "ms_undraw:*3.0.0+0",
    "package_info:*2.0.2",
    "flutter_image_compress:*1.1.0",
    "flutter_json_view:*0.2.1",
    "sign_in_with_apple:*3.0.0",
    "permission_handler:*6.0.0",
    "event_bus:*2.0.0",
    "image_cropper:*1.4.1",
    "shimmer:*2.0.0",
    "transparent_image:*2.0.0",
    "camera:*0.9.2+1",
    "dart_ipify:*1.1.0",
    "country_code_picker:*2.0.2",
    "simple_logger:*1.8.1",
    "android_intent:*2.0.2",
    "location:*4.3.0",
    "flutter_social_content_share:*1.0.1",
    "flutter_spinkit:*5.0.0",
    "smooth_page_indicator:*0.3.0-nullsafety.0",
    "tiengviet:*0.5.0",
    "barcode:*2.1.0",
    "pretty_json:*2.0.0",
    "html_character_entities:*1.0.0+1",
    "flutter_vibrate:*1.1.0",
    "uni_links:*0.5.1",
    "-flutter_facebook_login"
];

main();

function main() {
    bar = new cliProgress.SingleBar({
        format:
            "CLI Progress |" + colors.cyan("{bar}") + "| {step} || {percentage}% ",
        barCompleteChar: "\u2588",
        barIncompleteChar: "\u2591",
        hideCursor: true,
    });
    bar.start(200, 0);

    verifyLibs()
        .then((_) => {
            verifyPubs()
                .then((_) => {
                    verifyiOS()
                        .then((_) => {
                            verifyAndroid()
                                .then((_) => {
                                    bar.stop();
                                    exec(`cd ${path}`);
                                })
                                .catch(log);
                        })
                        .catch(log);
                })
                .catch(log);
        })
        .catch(log);
}

function log(msg) {
    console.log(msg);
}

async function verifyiOS() {
    //150-200
    bar.update({ step: "Verify ios" });
    return new Promise(async (resolve, reject) => {

        //tThêm code để thanh toán qua webview
        const plist = path + "/ios/Runner/Info.plist";
        if (fs.existsSync(plist)) {
            var data = fs.readFileSync(plist, "utf8");
            var replacement = "            <key>NSAppTransportSecurity</key>\n            <dict>\n                <key>NSAllowsArbitraryLoads</key>\n                <true/>\n                <key>NSExceptionDomains</key>\n                <dict>\n                    <key>yourdomain.com</key>\n                    <dict>\n                        <key>NSIncludesSubdomains</key>\n                        <true/>\n                        <key>NSThirdPartyExceptionRequiresForwardSecrecy</key>\n                        <false/>\n                    </dict>\n                </dict>\n            </dict>\n    </dict>\n</plist>"
            if (data.indexOf("NSAppTransportSecurity") === -1) {
                await utils.replacetext(plist, RegExp(`	</dict>\n</plist>`), replacement)
            }
        }

        try {
            var q = `cd ${path}/ios;`;
            q += "pod deintegrate;";
            exec(q, (err, stdout, stderr) => {
                q = "rm -rf Podfile.lock;";
                q += "pod install;";
                bar.update(180);
                exec(q, (err, stdout, stderr) => {
                    bar.update(200, { step: "Done" });
                    resolve();
                });
            });
        } catch (e) {
            reject(e);
        }
    });
}

async function verifyAndroid() {
    bar.update({ step: "Verify Android" });
    return new Promise(async (resolve, reject) => {

        try {//tThêm code để thanh toán qua webview
            const plist = path + "/android/app/src/main/AndroidManifest.xml";
            if (fs.existsSync(plist)) {
                var data = fs.readFileSync(plist, "utf8");
                var replacement = "android:icon=\"@mipmap/ic_launcher\" android:usesCleartextTraffic=\"true\""
                if (data.indexOf("android:usesCleartextTraffic=\"true\"") === -1) {
                    await utils.replacetext(plist, RegExp(`android:icon="@mipmap/ic_launcher"`), replacement)
                }
                resolve();
            }
        } catch (e) {
            reject(e);
        }
    });
}

async function verifyPubs() {
    await utils.replacetext(`${path}/pubspec.yaml`, `>=2.2.2`, `>=2.12.0`)
    await utils.replacetext(`${path}/lib/special/modify/package.dart`, `ModifyPKG _internal`, `ModifyPKG? _internal`)
    await utils.replacetext(`${path}/lib/special/modify/package.dart`, /_internal.initStyle\(\);/, `_internal!.initStyle();`)
    await utils.replacetext(`${path}/lib/special/modify/package.dart`, `return _internal;`, `return _internal!;`)
    await utils.replacetext(`${path}/lib/special/modify/package.dart`, /return _context\[state];/, `return _context[state]!;`)
    await utils.replacetext(`${path}/lib/special/modify/scope.dart`, `static LoyaltyScope _i;`, `static LoyaltyScope? _i;`)
    await utils.replacetext(`${path}/lib/special/modify/scope.dart`, `return _i;`, `return _i!;`)
    await utils.replacetext(`${path}/lib/special/modify/home/home_provider.dart`, /HomeProvider\(State/, `HomeProvider(HomePageState`)
    await utils.replacetext(`${path}/lib/special/modify/profile/profile_provider.dart`, `with ProfileMix,`, `with`)
    await utils.replacetext(`${path}/lib/special/modify/view/login_background.dart`, `final bool value;`, `final bool? value;`)
    await utils.replacetext(`${path}/lib/special/modify/view/login_background.dart`, `{Key key, this.value}`, `{Key? key, this.value}`)
    if (fs.readFileSync(`${path}/lib/special/modify/home/home_provider.dart`).toString().indexOf("import 'home_page.dart';") === -1) {
        await utils.replacetext(`${path}/lib/special/modify/home/home_provider.dart`, "import 'package:flutter/material.dart';", "import 'package:flutter/material.dart';\nimport 'home_page.dart';")
    }
    await utils.replacetext(`${path}/lib/special/modify/view/login_button.dart`, /ModifyPKG\(\).button\./, "ModifyPKG().button!.")

    //50->150
    bar.update({ step: "Verify pubs" });
    return new Promise((resolve, reject) => {
        try {
            var q = `cd ${path};rm lib/special/modify/view/login_logo.dart; flutter clean;`;

            exec(q, (err, stdout, stderr) => {
                bar.update(100);
                q = "rm -rf pubspec.lock;flutter pub get; flutter pub run flutter_native_splash:create;";
                exec(q, (err, stdout, stderr) => {
                    bar.update(150);
                    resolve();
                });
            });
        } catch (e) {
            reject(e);
        }
    });
}

async function verifyLibs() {
    bar.update({ step: "Verify libs" });
    return new Promise(async (resolve, reject) => {
        try {
            const pubspec = path + "/pubspec.yaml";
            if (fs.existsSync(pubspec)) {
                await utils.replacetext(pubspec, RegExp(`  flutter_native_splash:.*\n`), `  flutter_native_splash: 1.2.0\n`)
                var data = fs.readFileSync(pubspec, "utf8");
                resolveLibs.forEach((v) => {
                    let linesLast;
                    let linesFirst;
                    const dot = v.indexOf(":");
                    const isRemove = v.startsWith("-");
                    const isUpdate = dot !== -1;
                    var lib;
                    var verLib = "";
                    if (isRemove) {
                        lib = v.substring(1);
                    } else if (isUpdate) {
                        lib = v.substring(0, dot);
                        verLib = v.substring(dot + 1);
                    } else {
                        lib = v;
                    }

                    const lineLib = parseInt(utils.lineoflib(data.split("\n"), lib));
                    if (lineLib !== -1) {
                        linesFirst = data.split("\n").slice(0, lineLib);
                        linesLast = data.split("\n").slice(lineLib + 1);
                        data = linesFirst.join("\n") + "\n" + linesLast.join("\n");
                        // fs.writeFileSync(pubspec, linesFirst + "\n" + linesLast);
                    }

                    if (!isRemove) {
                        const lineCuper = parseInt(
                            utils.lineoflib(data.split("\n"), "cupertino_icons")
                        );
                        linesFirst = data.split("\n").slice(0, lineCuper);
                        linesLast = data.split("\n").slice(lineCuper);
                        if (verLib.indexOf("*") == -1)
                            linesFirst.push(`  ${lib}: ${verLib === "" ? "" : "^"}${verLib}`);
                        else linesFirst.push(`  ${lib}: ${verLib.substring(1)}`);

                        data = linesFirst.join("\n") + "\n" + linesLast.join("\n");
                    }
                });
                fs.writeFileSync(pubspec, data);
                bar.update(50);
                resolve();
            } else {
                reject(`Not found ${pubspec}`);
            }
        } catch (e) {
            reject(e);
        }
    });
}
