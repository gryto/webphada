import 'package:flutter/material.dart';
import 'detail.dart';

class NotificationList extends StatelessWidget {
  final String userType;
  // ignore: prefer_typing_uninitialized_variables
  final data;
  const NotificationList({Key? key, required this.userType, required this.data})
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
                    builder: (context) => NotificationDetail(
                      notificationDate: row['notification_date'],
                      notificationTime: row['notification_time'],
                      notificationUser: row['notification_user'],
                      notificationTitle: row['notification_title'],
                      notificationDescription: row['notification_description'],
                      isPublished: row['is_published'],
                      isRead: row['is_read'],
                    ),
                  ),
                );
              },
              child: Card(
                child: ListTile(
                  dense: true,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        row['notification_user'],
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 12.0),
                      ),
                    ],
                  ),
                  subtitle: Text(
                    row['notification_title'],
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontWeight: FontWeight.w400, fontSize: 12.0),
                  ),
                  trailing: Text(
                    row['notification_date'] + ' ' + row['notification_time'],
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
