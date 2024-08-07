import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';
import '../src/api.dart';
import '../src/constant.dart';
import '../src/loader.dart';
import '../src/preference.dart';
import '../screen/navigation.dart';
import 'background.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? _token;
  bool _obscurePassword = true;
  final _formKey = GlobalKey<FormState>();
  final cntrlUsername = TextEditingController();
  final cntrlPassword = TextEditingController();

  SharedPref sharedPref = SharedPref();
  String url = ApiService.setLogin;
  String message = "";
  bool isProcess = false;

  loginCheck(username, password) async {
    setState(() {
      isProcess = true;
    });

    try {
      var response = await http.post(Uri.parse(url),
          headers: {'Accept': 'application/json'},
          body: {"username": username, "password": password, "token": _token});
      var content = json.decode(response.body);

      if (content['status'] == true) {
        String userId = content['data']['user']['user_id'].toString();
        String userFullname =
            content['data']['user']['user_fullname'].toString();
        String userType = content['data']['user']['user_type'].toString();

        sharedPref.setPref("_token", _token);
        sharedPref.setPref("user_id", userId);
        sharedPref.setPref("user_fullname", userFullname);
        sharedPref.setPref("user_type", userType);

        goToApp(userId);
      } else {
        // ignore: use_build_context_synchronously
        _onAlertButtonPressed(context, content['status'], content['message']);
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      _onAlertButtonPressed(context, false, e.toString());
    }

    setState(() {
      isProcess = false;
    });
  }

  goToApp(userId) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => Navigation(
            userId: userId,
          ),
        ),
        (Route<dynamic> route) => false);
  }

  getFcmToken() async {
    String? token;
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      token = await FirebaseMessaging.instance.getAPNSToken();
    } else {
      token = await FirebaseMessaging.instance.getToken();
    }

    _token = token.toString();
  }

  _onAlertButtonPressed(context, status, message) {
    Alert(
      context: context,
      type: !status ? AlertType.error : AlertType.success,
      title: "",
      desc: message.toString(),
      buttons: [
        DialogButton(
          onPressed: () => Navigator.pop(context),
          width: 120,
          child: const Text(
            "OK",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        )
      ],
    ).show();
  }

  @override
  void initState() {
    super.initState();
    getFcmToken();
    cntrlUsername.text = "admin";
    cntrlPassword.text = "admin";
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height - 20;
    double w = MediaQuery.of(context).size.width - 0;

    return SafeArea(
      child: Scaffold(
        body: Background(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5, right: 5, left: 5),
                      child: Column(children: [
                        const SizedBox(
                          height: 140,
                        ),
                        Container(
                          alignment: Alignment.bottomRight,
                          height: h / 1.7,
                          width: w / 1.1,
                          decoration: BoxDecoration(
                            color: clrPrimary,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.only(top: 5, right: 5, left: 5),
                          ),
                        ),
                      ]),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5, right: 5, left: 5),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 150,
                          ),
                          Container(
                            alignment: Alignment.bottomRight,
                            height: h / 1.7,
                            width: w / 1.1,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 5, right: 5, left: 5),
                              child: Column(
                                children: [
                                  const SizedBox(height: 75),
                                  const Text(
                                    "MASUK APLIKASI",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 5),
                                  const Text(
                                    "Silahkan masukkan Nama Akun dan Kata Sandi",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 12),
                                  ),
                                  const SizedBox(height: 16),
                                  Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, right: 10),
                                          child: customTextEditingController(
                                            'Nama Akun',
                                            const Icon(
                                              Icons.person,
                                              color: Colors.grey,
                                            ),
                                            cntrlUsername,
                                          ),
                                        ),
                                        const SizedBox(height: 15),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, right: 10),
                                          child: passwordTextFormField(
                                            'Kata Sandi',
                                            cntrlPassword,
                                            const Icon(
                                              Icons.lock,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 35,
                                        ),
                                        !isProcess
                                            ? Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                child: SizedBox(
                                                  width: w,
                                                  height: h / 14.7,
                                                  child: ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor:
                                                          clrPrimary,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                    ),
                                                    onPressed: () async {
                                                      if (_formKey.currentState!
                                                          .validate()) {
                                                        loginCheck(
                                                          cntrlUsername.text,
                                                          cntrlPassword.text,
                                                        );
                                                      }
                                                    },
                                                    child: const Text(
                                                      "Login",
                                                      style: TextStyle(
                                                          fontSize: 19,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : loaderDialog(context),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 290),
                    child: Container(
                      padding: const EdgeInsets.all(5), // Border width
                      decoration: BoxDecoration(
                          color: clrPrimary,
                          borderRadius: BorderRadius.circular(18)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: SizedBox.fromSize(
                          size: const Size.fromRadius(54), // Image radius
                          child: Container(
                            color: Colors.white,
                            padding: const EdgeInsets.all(8),
                            child: Image.asset(
                                "assets/images/logo-kejaksaan.png",
                                fit: BoxFit.fill),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget customTextEditingController(
      String hintText, Icon prefixIcon, TextEditingController controllerName) {
    return TextFormField(
      controller: controllerName,
      validator: (value) {
        if (value!.isEmpty) {
          return "Please Enter Username";
        }
        return null;
      },
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.grey),
        prefixIcon: prefixIcon,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(10.0),
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          borderSide: BorderSide(width: 1, color: Colors.grey),
        ),
      ),
    );
  }

  Widget passwordTextFormField(String hintText,
      TextEditingController controllerPassword, Icon prefIcon) {
    return TextFormField(
      controller: controllerPassword,
      validator: (value) {
        if (value!.isEmpty) {
          return "Please Enter Your Password";
        }
        return null;
      },
      obscureText: _obscurePassword,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.grey),
        prefixIcon: prefIcon,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(10.0),
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          borderSide: BorderSide(width: 1, color: Colors.grey),
        ),
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              _obscurePassword = !_obscurePassword;
            });
          },
          child: Icon(
            _obscurePassword ? Icons.visibility : Icons.visibility_off,
            color: clrPrimary,
          ),
        ),
        suffixStyle: const TextStyle(color: clrPrimary),
      ),
    );
  }
}
