import 'package:flutter/material.dart';
import '../component/detail.dart';

class ActivityList extends StatelessWidget {
  final String userType;
  // ignore: prefer_typing_uninitialized_variables
  final data;
  const ActivityList({Key? key, required this.userType, required this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (data.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView.separated(
          padding:
              const EdgeInsets.only(bottom: 5, top: 5, left: 5.0, right: 5.0),
          primary: false,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (_, index) {
            var row = data[index];

            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ActivityDetail(
                      activityDate: row['activity_date'] ?? "",
                      activityTime: row['activity_time'] ?? "",
                      activityType: row['activity_type'] ?? "",
                      activityDescription: row['activity_description'] ?? "",
                      activityUser: row['activity_user'] ?? "",
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
                              row['activity_user'] ?? "",
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 12.0),
                            ),
                          ],
                        ),
                        subtitle: Text(
                          row.activityDescription,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 12.0),
                        ),
                        trailing: Text(
                          row['activity_date'] + ' ' + row['activity_time'],
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 12.0),
                        ),
                      )
                    : ListTile(
                        dense: true,
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              row['activity_date'] + ' ' + row['activity_time'],
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 12.0,
                              ),
                            ),
                          ],
                        ),
                        subtitle: Text(
                          row['activity_description'] ?? "",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12.0,
                          ),
                        ),
                      ),
              ),
            );
          },
          separatorBuilder: (_, index) => const SizedBox(
            height: 5,
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
