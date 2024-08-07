import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../../../launcher/launcher.dart';
import '../../../src/constant.dart';
import '../../../src/loader.dart';
import '../../../src/preference.dart';
import '../../information/activity/page.dart';
import '../../report/visitor/page.dart';
import '../../report/rating/page.dart';
import '../../information/tutorial/page.dart';
import '../../report/contactus/page.dart';
import '../../report/newsletter/page.dart';
import '../widget/icon_style.dart';
import '../widget/setting_group.dart';
import '../widget/setting_item.dart';
import '../widget/user_card.dart';
import 'info.dart';

class ProfileUser extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final data;
  const ProfileUser({Key? key, required this.data}) : super(key: key);

  _onAlertButtonsPressed(context) {
    Alert(
      context: context,
      type: AlertType.warning,
      title: "",
      desc: "Apakah anda akan keluar dari aplikasi ?",
      buttons: [
        DialogButton(
          onPressed: () => Navigator.pop(context),
          color: clrPrimary,
          child: const Text(
            "Tdk",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
        DialogButton(
          onPressed: () {
            goToLauncher(context);
          },
          color: clrSecondary,
          child: const Text(
            "Ya",
            style: TextStyle(color: clrPrimary, fontSize: 18),
          ),
        )
      ],
    ).show();
  }

  goToLauncher(context) {
    SharedPref sharedPref = SharedPref();
    sharedPref.dropPref("user_id");

    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const LauncherPage(),
        ),
        (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    if (data == null) {
      return loaderDialog(context);
    } else {
      return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            UserCard(
              userName: data == null ? "-" : data.userFullname,
              userProfilePic: NetworkImage(
                data.userPath,
                scale: 10,
              ),
              cardRadius: 5,
              cardColor: clrPrimary,
              backgroundMotifColor: Colors.black,
              userMoreInfo: const Text(
                "More info...",
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => InfoUser(data: data),
                  ),
                );
              },
            ),
            SettingsGroup(
              settingsGroupTitleStyle: const TextStyle(
                  height: 2.0,
                  color: Colors.black87,
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
              settingsGroupTitle: " Laporan",
              items: [
                SettingsItem(
                  onTap: () {
                    data == null
                        ? null
                        : Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => RatingPage(
                                userId: data.userId.toString(),
                              ),
                            ),
                          );
                  },
                  icons: Icons.star_rate_outlined,
                  iconStyle: IconStyle(
                    iconsColor: Colors.white,
                    withBackground: true,
                    backgroundColor: clrPrimary,
                  ),
                  title: 'Indeks Kepuasan',
                  subtitle: "Polling rating website",
                ),
                SettingsItem(
                  onTap: () {
                    data == null
                        ? null
                        : Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ContactusPage(
                                userId: data.userId.toString(),
                              ),
                            ),
                          );
                  },
                  icons: Icons.text_fields_outlined,
                  iconStyle: IconStyle(
                    iconsColor: Colors.white,
                    withBackground: true,
                    backgroundColor: clrPrimary,
                  ),
                  title: 'Kontak Kami',
                  subtitle: "Buku tamu kontak kami",
                ),
                SettingsItem(
                  onTap: () {
                    data == null
                        ? null
                        : Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => NewsletterPage(
                                userId: data.userId.toString(),
                              ),
                            ),
                          );
                  },
                  icons: Icons.mail_outline,
                  iconStyle: IconStyle(
                    iconsColor: Colors.white,
                    withBackground: true,
                    backgroundColor: clrPrimary,
                  ),
                  title: 'Berlangganan',
                  subtitle: "Informasi email berlangganan",
                ),
                SettingsItem(
                  onTap: () {
                    data == null
                        ? null
                        : Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => VisitorPage(
                                userId: data.userId.toString(),
                              ),
                            ),
                          );
                  },
                  icons: Icons.punch_clock_outlined,
                  iconStyle: IconStyle(
                    iconsColor: Colors.white,
                    withBackground: true,
                    backgroundColor: clrPrimary,
                  ),
                  title: 'Log Kunjungan',
                  subtitle: "Daftar kunjungan website",
                ),
              ],
            ),
            SettingsGroup(
              settingsGroupTitleStyle: const TextStyle(
                  height: 2.0,
                  color: Colors.black87,
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
              settingsGroupTitle: " Informasi",
              items: [
                SettingsItem(
                  onTap: () {
                    data == null
                        ? null
                        : Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => TutorialPage(
                                userId: data.userId.toString(),
                              ),
                            ),
                          );
                  },
                  icons: Icons.book_outlined,
                  iconStyle: IconStyle(
                    iconsColor: Colors.white,
                    withBackground: true,
                    backgroundColor: clrPrimary,
                  ),
                  title: 'Dokumen Panduan',
                  subtitle: "Kumpulan Dokumen Panduan",
                ),
                SettingsItem(
                  onTap: () {
                    data == null
                        ? null
                        : Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ActivityPage(
                                userId: data.userId.toString(),
                              ),
                            ),
                          );
                  },
                  icons: Icons.lock_clock_outlined,
                  iconStyle: IconStyle(
                    iconsColor: Colors.white,
                    withBackground: true,
                    backgroundColor: clrPrimary,
                  ),
                  title: 'Log Aktivitas',
                  subtitle: "Aktivitas kegiatan pengguna",
                ),
              ],
            ),
            SettingsGroup(
              items: [
                SettingsItem(
                  onTap: () {
                    _onAlertButtonsPressed(context);
                  },
                  icons: Icons.exit_to_app_rounded,
                  iconStyle: IconStyle(
                    iconsColor: Colors.white,
                    withBackground: true,
                    backgroundColor: clrPrimary,
                  ),
                  title: "Logout",
                  trailing: const Icon(Icons.navigate_next),
                ),
              ],
            ),
          ],
        ),
      );
    }
  }
}
