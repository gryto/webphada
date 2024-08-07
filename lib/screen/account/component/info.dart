import 'package:flutter/material.dart';
import '../../../src/constant.dart';
import '../../../src/loader.dart';
import 'survey.dart';

class InfoUser extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final data;
  const InfoUser({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height - 20;
    double w = MediaQuery.of(context).size.width - 0;

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: clrPrimary,
        title: const Text("Informasi Pengguna"),
        elevation: 0,
      ),
      body: data == null
          ? loaderDialog(context)
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2.0),
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          ListTile(
                            leading: const Icon(Icons.person),
                            title: const Text(
                              "Username",
                              style: TextStyle(fontSize: 10, height: 1.8),
                            ),
                            subtitle: Text(
                              data.userAccount,
                              style: const TextStyle(fontSize: 14, height: 1.5),
                            ),
                          ),
                          const Divider(),
                          data.userType == 1
                              ? ListTile(
                                  leading: const Icon(Icons.badge),
                                  title: const Text(
                                    "Hak Akses",
                                    style: TextStyle(fontSize: 10, height: 1.8),
                                  ),
                                  subtitle: Text(
                                    data.roleName,
                                    style: const TextStyle(
                                        fontSize: 14, height: 1.5),
                                  ),
                                )
                              : ListTile(
                                  leading: const Icon(Icons.badge),
                                  title: const Text(
                                    "Satuan Kerja",
                                    style: TextStyle(fontSize: 10, height: 1.8),
                                  ),
                                  subtitle: Text(
                                    data.satkerName,
                                    style: const TextStyle(
                                        fontSize: 14, height: 1.5),
                                  ),
                                ),
                          const Divider(),
                          ListTile(
                            leading: const Icon(Icons.account_circle),
                            title: const Text(
                              "Nama Lengkap",
                              style: TextStyle(fontSize: 10, height: 1.8),
                            ),
                            subtitle: Text(
                              data.userFullname,
                              style: const TextStyle(fontSize: 14, height: 1.5),
                            ),
                          ),
                          const Divider(),
                          ListTile(
                            leading: const Icon(Icons.mail),
                            title: const Text(
                              "Email",
                              style: TextStyle(fontSize: 10, height: 1.8),
                            ),
                            subtitle: Text(
                              data.userEmail,
                              style: const TextStyle(fontSize: 14, height: 1.5),
                            ),
                          ),
                          const Divider(),
                          ListTile(
                            leading: const Icon(Icons.phone_android),
                            title: const Text(
                              "No. Telepon",
                              style: TextStyle(fontSize: 10, height: 1.8),
                            ),
                            subtitle: Text(
                              data.userFullname,
                              style: const TextStyle(fontSize: 14, height: 1.5),
                            ),
                          ),
                          const Divider(),
                          ListTile(
                            leading: const Icon(Icons.location_pin),
                            title: const Text(
                              "Alamat",
                              style: TextStyle(fontSize: 10, height: 1.8),
                            ),
                            subtitle: Text(
                              data.userAddress,
                              style: const TextStyle(fontSize: 14, height: 1.5),
                            ),
                          ),
                          const Divider(),
                          ListTile(
                            leading: const Icon(Icons.calendar_month),
                            title: const Text(
                              "Login Terakhir",
                              style: TextStyle(fontSize: 10, height: 1.8),
                            ),
                            subtitle: Text(
                              data.userLogin,
                              style: const TextStyle(fontSize: 14, height: 1.5),
                            ),
                          ),
                          const Divider(),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: SizedBox(
                        width: w,
                        height: h / 14.7,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: clrPrimary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => SurveyUser(
                                  userId: data.userId.toString(),
                                ),
                              ),
                            );
                          },
                          child: const Text(
                            "Form Survey",
                            style: TextStyle(fontSize: 19),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
    );
  }
}
