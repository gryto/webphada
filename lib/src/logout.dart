import 'package:flutter/material.dart';
import '../launcher/launcher.dart';
import 'preference.dart';

logoutDialog(BuildContext context) {
  SharedPref sharedPref = SharedPref();

  Widget cancelButton = TextButton(
    child: const Text("No"),
    onPressed: () {
      Navigator.of(context, rootNavigator: true).pop(false);
    },
  );
  Widget continueButton = TextButton(
    child: const Text("Yes"),
    onPressed: () {
      sharedPref.dropPref("user_id");

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const LauncherPage(),
          ),
          (Route<dynamic> route) => false);
    },
  );

  AlertDialog alert = AlertDialog(
    title: const Text("Konfirmasi"),
    content: const Text("Apakah anda yakin akan keluar ?"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
