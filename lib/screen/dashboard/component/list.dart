import 'package:flutter/material.dart';
import '../../../src/loader.dart';
import 'detail.dart';

class ContentList extends StatelessWidget {
  final String userType, keyword;
  // ignore: prefer_typing_uninitialized_variables
  final data;
  const ContentList(
      {Key? key,
      required this.userType,
      required this.keyword,
      required this.data})
      : super(key: key);

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
                      builder: (context) => ContentDetail(
                          satkerName: row.satkerName,
                          menuName: row.menuName,
                          teksIn: row.contentTextIn,
                          teksEn: row.contentTextEn),
                    ),
                  );
                },
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(height: 3),
                              Row(
                                children: [
                                  // ignore: unrelated_type_equality_checks
                                  userType == 1
                                      ? Text(
                                          row.satkerName,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        )
                                      : Text(
                                          row.menuName,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                ],
                              ),
                              // ignore: unrelated_type_equality_checks
                              const SizedBox(height: 3),
                              Text(
                                row.contentTextIn,
                                maxLines: 3,
                                style: const TextStyle(
                                  fontSize: 12,
                                ),
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.justify,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 30,
                          child: Icon(
                            Icons.arrow_forward_ios_sharp,
                            size: 15,
                            color: Colors.grey,
                          ),
                        ),
                      ],
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
