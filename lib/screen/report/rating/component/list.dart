import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'detail.dart';

class RatingList extends StatelessWidget {
  final String userType;
  // ignore: prefer_typing_uninitialized_variables
  final data;
  const RatingList({Key? key, required this.userType, required this.data})
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
                    builder: (context) => RatingDetail(
                      ratingDate: row['rating_date'],
                      ratingTime: row['rating_time'],
                      ratingIp: row['rating_ip'],
                      ratingValue: row['rating_value'],
                      ratingDescription: row['rating_description'],
                      ratingSatker: row['rating_satker'],
                    ),
                  ),
                );
              },
              child: Card(
                child: userType == "1"
                    ? ListTile(
                        dense: true,
                        title: Text(
                          row['rating_satker'],
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 12.0),
                        ),
                        subtitle: Text(
                          row['rating_ip'],
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 12.0),
                        ),
                        trailing: RatingBarIndicator(
                          rating: row['rating_value'].toDouble(),
                          itemBuilder: (context, index) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          itemCount: 5,
                          itemSize: 12,
                          itemPadding:
                              const EdgeInsets.symmetric(horizontal: 1.0),
                          direction: Axis.horizontal,
                        ),
                      )
                    : ListTile(
                        dense: true,
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              row['rating_ip'],
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 12.0),
                            ),
                          ],
                        ),
                        subtitle: Text(
                          row['rating_date'] + ' ' + row['rating_time'],
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 12.0),
                        ),
                        trailing: RatingBarIndicator(
                          rating: row['rating_value'].toDouble(),
                          itemBuilder: (context, index) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          itemCount: 5,
                          itemSize: 12,
                          itemPadding:
                              const EdgeInsets.symmetric(horizontal: 1.0),
                          direction: Axis.horizontal,
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
