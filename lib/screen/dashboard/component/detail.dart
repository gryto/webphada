import 'package:flutter/material.dart';
import '../../../src/constant.dart';

class ContentDetail extends StatelessWidget {
  final String satkerName, menuName, teksIn, teksEn;
  const ContentDetail(
      {Key? key,
      required this.satkerName,
      required this.menuName,
      required this.teksIn,
      required this.teksEn})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: clrPrimary,
        title: const Text("Info Konten"),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2.0),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    readOnly: true,
                    controller: TextEditingController(text: satkerName),
                    decoration: const InputDecoration(
                      labelText: 'Satuan Kerja',
                    ),
                  ),
                  TextField(
                    readOnly: true,
                    controller: TextEditingController(text: menuName),
                    decoration: const InputDecoration(
                      labelText: 'Halaman Menu',
                    ),
                  ),
                  TextField(
                    readOnly: true,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    controller: TextEditingController(text: teksIn),
                    decoration: const InputDecoration(
                      labelText: 'Teks IN',
                    ),
                  ),
                  TextField(
                    readOnly: true,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    controller: TextEditingController(text: teksEn),
                    decoration: const InputDecoration(
                      labelText: 'Teks EN',
                    ),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
