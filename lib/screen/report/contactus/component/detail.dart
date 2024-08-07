import 'package:flutter/material.dart';
import '../../../../src/constant.dart';

class ContactusDetail extends StatelessWidget {
  final String contactusDate,
      contactusTime,
      contactusName,
      contactusEmail,
      contactusSubject,
      contactusMessage,
      contactusSatker;

  const ContactusDetail({
    Key? key,
    required this.contactusDate,
    required this.contactusTime,
    required this.contactusName,
    required this.contactusEmail,
    required this.contactusSubject,
    required this.contactusMessage,
    required this.contactusSatker,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width - 0;

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: clrPrimary,
        title: const Text("Kontak Kami"),
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
                        contactusSatker,
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
                        contactusDate,
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
                        contactusTime,
                        style: const TextStyle(fontSize: 14, height: 1.5),
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.person),
                      title: const Text(
                        "Nama",
                        style: TextStyle(fontSize: 10, height: 1.8),
                      ),
                      subtitle: Text(
                        contactusName,
                        style: const TextStyle(fontSize: 14, height: 1.5),
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.email),
                      title: const Text(
                        "Email",
                        style: TextStyle(fontSize: 10, height: 1.8),
                      ),
                      subtitle: Text(
                        contactusEmail,
                        style: const TextStyle(fontSize: 14, height: 1.5),
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.link),
                      title: const Text(
                        "Subyek",
                        style: TextStyle(fontSize: 10, height: 1.8),
                      ),
                      subtitle: Text(
                        contactusSubject,
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
                        contactusMessage,
                        style: const TextStyle(fontSize: 14, height: 1.5),
                      ),
                    ),
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
