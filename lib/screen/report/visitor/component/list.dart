import 'package:flutter/material.dart';
import 'detail.dart';

class VisitorList extends StatelessWidget {
  final String userType;
  // ignore: prefer_typing_uninitialized_variables
  final data;
  const VisitorList({Key? key, required this.userType, required this.data})
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
                    builder: (context) => VisitorDetail(
                      visitorDate: row['visitor_date'],
                      visitorTime: row['visitor_time'],
                      visitorIp: row['visitor_ip'],
                      menuName: row['menu_name'],
                      satkerName: row['satker_name'],
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
                              row['satker_name'],
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 12.0),
                            ),
                          ],
                        ),
                        subtitle: Text(
                          row['menu_name'],
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 12.0),
                        ),
                        trailing: Text(
                          row['visitor_ip'],
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
                              row['visitor_date'] + ' ' + row['visitor_time'],
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 12.0),
                            ),
                          ],
                        ),
                        subtitle: Text(
                          row['menu_name'],
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 12.0),
                        ),
                        trailing: Text(
                          row['visitor_ip'],
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
