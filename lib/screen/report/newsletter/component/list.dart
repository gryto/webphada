import 'package:flutter/material.dart';
import 'detail.dart';

class NewsletterList extends StatelessWidget {
  final String userType;
  // ignore: prefer_typing_uninitialized_variables
  final data;
  const NewsletterList({Key? key, required this.userType, required this.data})
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
                    builder: (context) => NewsletterDetail(
                      newsletterDate: row['newsletter_date'],
                      newsletterTime: row['newsletter_time'],
                      newsletterEmail: row['newsletter_email'],
                      newsletterSatker: row['newsletter_satker'],
                    ),
                  ),
                );
              },
              child: Card(
                child: userType == "1"
                    ? ListTile(
                        dense: true,
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              row['newsletter_satker'],
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 12.0),
                            ),
                          ],
                        ),
                        subtitle: Text(
                          row['newsletter_email'],
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 12.0),
                        ),
                        trailing: Text(
                          row['newsletter_date'] + ' ' + row['newsletter_time'],
                          style: const TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 12.0),
                        ),
                      )
                    : ListTile(
                        dense: true,
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              row['newsletter_date'] +
                                  ' ' +
                                  row['newsletter_time'],
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 12.0),
                            ),
                          ],
                        ),
                        subtitle: Text(
                          row['newsletter_email'],
                          overflow: TextOverflow.ellipsis,
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
