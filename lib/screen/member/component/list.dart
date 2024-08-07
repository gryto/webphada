import 'package:flutter/material.dart';
import '../../../src/loader.dart';
import 'detail.dart';

class SatkerList extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final data;
  const SatkerList({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (data == null) {
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.70,
        child: loaderDialog(context),
      );
    } else {
      if (data!.length == 0) {
        return Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2.0),
            color: Colors.white,
          ),
          child: const Center(
            child: Text("No data found"),
          ),
        );
      } else {
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
                      builder: (context) => SatkerDetail(
                          satkerName: row.satkerName,
                          satkerPhone: row.satkerPhone,
                          satkerEmail: row.satkerEmail,
                          satkerAddress: row.satkerAddress,
                          satkerDescription: row.satkerDescription,
                          satkerUrl: row.satkerUrl),
                    ),
                  );
                },
                child: Card(
                  surfaceTintColor: Colors.white,
                  child: ListTile(
                    dense: true,
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          row.satkerName,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 12.0),
                        ),
                      ],
                    ),
                    subtitle: Text(
                      row.satkerUrl,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontWeight: FontWeight.w400, fontSize: 12.0),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios_sharp,
                      size: 15,
                      color: Colors.grey,
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
      }
    }
  }
}
