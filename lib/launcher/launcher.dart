import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import '../src/api.dart';
import '../src/preference.dart';
import '../login/login.dart';
import '../screen/navigation.dart';

class LauncherPage extends StatefulWidget {
  const LauncherPage({Key? key}) : super(key: key);

  @override
  State<LauncherPage> createState() => _LauncherPageState();
}

class _LauncherPageState extends State<LauncherPage> {
  SharedPref sharedPref = SharedPref();
  String url = ApiService.detailUser;
  String message = "";
  bool isLogged = false;

  @override
  void initState() {
    permissionServiceCall();
    startLaunching();
    super.initState();
  }

  startLaunching() async {
    var duration = const Duration(seconds: 2);
    return Timer(duration, checkSession);
  }

  void checkSession() async {
    try {
      var userId = await sharedPref.getPref("user_id");
      await getDetailUser(userId);

      if (isLogged == true) {
        goToApp(userId);
      } else {
        goToLogin();
      }
    } catch (e) {
      goToLogin();
    }
  }

  getDetailUser(userId) async {
    try {
      var response = await http.post(Uri.parse(url),
          headers: {'Accept': 'application/json'}, body: {"user_id": userId});
      var content = json.decode(response.body);

      if (content['status'] == true) {
        setState(() {
          isLogged = true;
        });
      } else {
        setState(() {
          isLogged = false;
        });
      }
    } catch (e) {
      isLogged = false;
    }
  }

  void goToApp(userId) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => Navigation(userId: userId),
        ),
        (Route<dynamic> route) => false);
  }

  void goToLogin() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
      return const LoginPage();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.80,
          child: Image.asset(
            "assets/images/logo-kejaksaan.png",
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  permissionServiceCall() async {
    await permissionServices().then(
      (value) {
        if (value[Permission.storage]!.isGranted) {}
      },
    );
  }

  /*Permission services*/
  Future<Map<Permission, PermissionStatus>> permissionServices() async {
    // You can request multiple permissions at once.
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
      //add more permission to request here.
    ].request();

    if (statuses[Permission.storage]!.isPermanentlyDenied) {
      await openAppSettings().then(
        (value) async {
          if (value) {
            if (await Permission.storage.status.isPermanentlyDenied == true &&
                await Permission.storage.status.isGranted == false) {
              openAppSettings();
              // permissionServiceCall(); /* opens app settings until permission is granted */
            }
          }
        },
      );
    } else {
      if (statuses[Permission.storage]!.isDenied) {
        permissionServiceCall();
      }
    }
    
    /*{Permission.camera: PermissionStatus.granted, Permission.storage: PermissionStatus.granted}*/
    return statuses;
  }
}
