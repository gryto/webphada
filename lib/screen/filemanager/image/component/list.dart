import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'image.dart';

// ignore: must_be_immutable
class ImageList extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final data;
  const ImageList({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (data.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.all(10),
        child: MasonryGridView.count(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: data.isEmpty ? 0 : data.length,
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          itemBuilder: (context, index) {
            var row = data[index];
            return ImageGrid(
              uploadDate: row['upload_date'],
              uploadTime: row['upload_time'],
              uploadName: row['upload_name'],
              uploadSize: row['upload_size'],
              uploadFile: row['upload_file'],
              uploadPath: row['upload_path'],
              satkerName: row['satker_name'],
              menuName: row['menu_name'],
            );
          },
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
