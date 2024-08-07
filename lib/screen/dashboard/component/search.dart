import 'package:flutter/material.dart';
import '../../../src/constant.dart';
import '../../../src/preference.dart';
import '../logic/bloc.dart';
import '../logic/model.dart';
import 'list.dart';

class SearchContent extends StatefulWidget {
  final String userId, keyword;
  const SearchContent({Key? key, required this.userId, required this.keyword})
      : super(key: key);

  @override
  State<SearchContent> createState() => _SearchContentState();
}

class _SearchContentState extends State<SearchContent> {
  SharedPref sharedPref = SharedPref();
  ContentBloc contentBloc = ContentBloc();
  final ScrollController _scrollController = ScrollController();

  var search = "";
  var limit = 10;
  var offset = 0;
  List<Data>? dataList;
  final fieldKeyword = TextEditingController();

  searchData(keyword) {
    setState(() {
      search = keyword;
      dataList = [];
    });

    contentBloc.eventSink.add({
      'user_id': widget.userId,
      'limit': "10",
      'offset': "0",
      'keyword': search,
    });
  }

  String userType = "";
  void checkSession() async {
    var type = await sharedPref.getPref("user_type");

    setState(() {
      search = widget.keyword;
      fieldKeyword.text = search;
      userType = type;
    });
  }

  @override
  void initState() {
    checkSession();
    contentBloc.eventSink.add({
      'user_id': widget.userId,
      'limit': limit.toString(),
      'offset': offset.toString(),
      'keyword': search,
    });
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        setState(() {
          offset = offset + 10;
        });

        contentBloc.eventSink.add({
          'user_id': widget.userId,
          'limit': limit.toString(),
          'offset': offset.toString(),
          'keyword': search,
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: clrPrimary,
        title: const Text("Search Advance Engine"),
        elevation: 0,
      ),
      body: ListView(
        controller: _scrollController,
        children: [
          StreamBuilder(
            stream: contentBloc.stateStream,
            builder: (context, snapshot) {
              final dataContent = parseContent(snapshot.data);
              List<Data>? dataResult =
                  snapshot.hasData ? dataContent.data : null;

              if (snapshot.hasData) {
                if (dataList == null) {
                  dataList = dataResult!;
                } else {
                  dataList!.addAll(dataResult!.toList());
                }
              }
              return ContentList(
                userType: userType,
                keyword: search,
                data: dataList,
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return BottomSheet(
                enableDrag: false,
                onClosing: () {},
                builder: (BuildContext context) {
                  return StatefulBuilder(
                    builder: (BuildContext context, setState) => SafeArea(
                      child: Container(
                        //height: 150,
                        padding: const EdgeInsets.all(5),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: TextField(
                                controller: fieldKeyword,
                                maxLines: 1,
                                decoration: InputDecoration(
                                  labelText: 'Kata kunci',
                                  hintText: 'Masukkan kata kunci',
                                  focusColor: clrPrimary,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            GestureDetector(
                              onTap: () async {
                                Navigator.pop(context);
                                searchData(
                                  fieldKeyword.text,
                                );
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20.0),
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                decoration: BoxDecoration(
                                  color: clrPrimary,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Center(
                                  child: Text(
                                    "Pencarian",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
        backgroundColor: clrPrimary,
        child: const Icon(Icons.search),
      ),
    );
  }
}
