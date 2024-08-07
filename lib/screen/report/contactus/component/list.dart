import 'package:flutter/material.dart';
import 'detail.dart';

class ContactusList extends StatelessWidget {
  final String userType;
  // ignore: prefer_typing_uninitialized_variables
  final data;
  const ContactusList({Key? key, required this.userType, required this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (data.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (_, index) {
            var row = data[index];
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ContactusDetail(
                        contactusDate: row['contactus_date'],
                        contactusTime: row['contactus_time'],
                        contactusName: row['contactus_name'],
                        contactusEmail: row['contactus_email'],
                        contactusSubject: row['contactus_subject'],
                        contactusMessage: row['contactus_message'],
                        contactusSatker: row['contactus_satker']),
                  ),
                );
              },
              child: Card(
                child: userType == "1"
                    ? ListTile(
                        dense: true,
                        title: Text(
                          row['contactus_satker'],
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 12.0),
                        ),
                        subtitle: Text(
                          row['contactus_name'],
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 12.0),
                        ),
                        trailing: Text(
                          row['contactus_date'] + ' ' + row['contactus_time'],
                          style: const TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 12.0),
                        ),
                      )
                    : ListTile(
                        dense: true,
                        title: Text(
                          row['contactus_name'],
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 12.0),
                        ),
                        subtitle: Text(
                          row['contactus_subject'],
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 12.0),
                        ),
                        trailing: Text(
                          row['contactus_date'] + ' ' + row['contactus_time'],
                          style: const TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 12.0),
                        ),
                      ),
              ),
            );
          },
          separatorBuilder: (_, index) => const SizedBox(
            height: 1,
          ),
          itemCount: data.isEmpty ? 0 : data.length,
        ),
      );
    } else {
      return Center(
        child: Column(
          children: [
            const SizedBox(
              height: 200,
            ),
            Container(
              padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
              child: const Text("No data found"),
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      );
    }
  }
}
