import 'package:flutter/material.dart';
import '../../../../src/constant.dart';

class VisitorDetail extends StatelessWidget {
  final String visitorDate, visitorTime, visitorIp, menuName, satkerName;

  const VisitorDetail({
    Key? key,
    required this.visitorDate,
    required this.visitorTime,
    required this.visitorIp,
    required this.menuName,
    required this.satkerName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width - 0;

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: clrPrimary,
        title: const Text("Log Kunjungan"),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                width: w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2.0),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.account_circle),
                      title: const Text(
                        "Satuan Kerja",
                        style: TextStyle(fontSize: 10, height: 1.8),
                      ),
                      subtitle: Text(
                        satkerName,
                        style: const TextStyle(fontSize: 14, height: 1.5),
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.date_range),
                      title: const Text(
                        "Tanggal",
                        style: TextStyle(fontSize: 10, height: 1.8),
                      ),
                      subtitle: Text(
                        visitorDate,
                        style: const TextStyle(fontSize: 14, height: 1.5),
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.timer),
                      title: const Text(
                        "Jam",
                        style: TextStyle(fontSize: 10, height: 1.8),
                      ),
                      subtitle: Text(
                        visitorTime,
                        style: const TextStyle(fontSize: 14, height: 1.5),
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.wifi_sharp),
                      title: const Text(
                        "Alamat Ip",
                        style: TextStyle(fontSize: 10, height: 1.8),
                      ),
                      subtitle: Text(
                        visitorIp,
                        style: const TextStyle(fontSize: 14, height: 1.5),
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.format_list_bulleted),
                      title: const Text(
                        "Menu Halaman",
                        style: TextStyle(fontSize: 10, height: 1.8),
                      ),
                      subtitle: Text(
                        menuName,
                        style: const TextStyle(fontSize: 14, height: 1.5),
                      ),
                    ),
                    const Divider(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
