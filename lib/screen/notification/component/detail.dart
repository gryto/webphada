import 'package:flutter/material.dart';
import '../../../src/constant.dart';

class NotificationDetail extends StatelessWidget {
  final String notificationDate,
      notificationTime,
      notificationTitle,
      notificationDescription,
      notificationUser;

  final int isPublished, isRead;

  const NotificationDetail({
    Key? key,
    required this.notificationDate,
    required this.notificationTime,
    required this.notificationTitle,
    required this.notificationDescription,
    required this.notificationUser,
    required this.isPublished,
    required this.isRead,
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
                        "User",
                        style: TextStyle(fontSize: 10, height: 1.8),
                      ),
                      subtitle: Text(
                        notificationUser,
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
                        notificationDate,
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
                        notificationTime,
                        style: const TextStyle(fontSize: 14, height: 1.5),
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.title),
                      title: const Text(
                        "Judul",
                        style: TextStyle(fontSize: 10, height: 1.8),
                      ),
                      subtitle: Text(
                        notificationTitle,
                        style: const TextStyle(fontSize: 14, height: 1.5),
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.email),
                      title: const Text(
                        "Deskripsi",
                        style: TextStyle(fontSize: 10, height: 1.8),
                      ),
                      subtitle: Text(
                        notificationDescription,
                        style: const TextStyle(fontSize: 14, height: 1.5),
                      ),
                    ),
                    // const Divider(),
                    // ListTile(
                    //   leading: const Icon(Icons.link),
                    //   title: const Text(
                    //     "Subject",
                    //     style: TextStyle(fontSize: 10, height: 1.8),
                    //   ),
                    //   subtitle: Text(
                    //     notificationSubject,
                    //     style: const TextStyle(fontSize: 14, height: 1.5),
                    //   ),
                    // ),
                    // const Divider(),
                    // ListTile(
                    //   leading: const Icon(Icons.text_fields),
                    //   title: const Text(
                    //     "Keterangan",
                    //     style: TextStyle(fontSize: 10, height: 1.8),
                    //   ),
                    //   subtitle: Text(
                    //     notificationMessage,
                    //     style: const TextStyle(fontSize: 14, height: 1.5),
                    //   ),
                    // ),
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
