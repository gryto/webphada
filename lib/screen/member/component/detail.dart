import 'package:flutter/material.dart';
import '../../../src/constant.dart';
import 'webview.dart';

class SatkerDetail extends StatelessWidget {
  final String satkerName,
      satkerPhone,
      satkerEmail,
      satkerAddress,
      satkerDescription,
      satkerUrl;
  const SatkerDetail(
      {Key? key,
      required this.satkerName,
      required this.satkerPhone,
      required this.satkerEmail,
      required this.satkerAddress,
      required this.satkerDescription,
      required this.satkerUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height - 20;
    double w = MediaQuery.of(context).size.width - 0;

    return Scaffold(
      backgroundColor:Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: clrPrimary,
        title: const Text("Satuan Kerja"),
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
                      leading: const Icon(Icons.mail),
                      title: const Text(
                        "Email",
                        style: TextStyle(fontSize: 10, height: 1.8),
                      ),
                      subtitle: Text(
                        satkerEmail,
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
                        satkerPhone,
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
                        satkerAddress,
                        style: const TextStyle(fontSize: 14, height: 1.5),
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.text_fields),
                      title: const Text(
                        "Keterangan",
                        style: TextStyle(fontSize: 10, height: 1.8),
                      ),
                      subtitle: Text(
                        satkerDescription,
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
                          builder: (context) => WebviewPage(url: satkerUrl),
                        ),
                      );
                    },
                    child: const Text(
                      "Preview Website",
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
