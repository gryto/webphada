import 'package:flutter/material.dart';
import '../../../../src/constant.dart';

class NewsletterDetail extends StatelessWidget {
  final String newsletterDate,
      newsletterTime,
      newsletterEmail,
      newsletterSatker;

  const NewsletterDetail({
    Key? key,
    required this.newsletterDate,
    required this.newsletterTime,
    required this.newsletterEmail,
    required this.newsletterSatker,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width - 0;

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: clrPrimary,
        title: const Text("Berlangganan"),
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
                        newsletterSatker,
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
                        newsletterDate,
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
                        newsletterTime,
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
                        newsletterEmail,
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
