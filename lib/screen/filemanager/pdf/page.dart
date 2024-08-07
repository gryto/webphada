import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../src/api.dart';
import '../../../src/constant.dart';
import '../../../src/dialog_info.dart';
import '../../../src/loader.dart';
import '../../../src/preference.dart';
import 'component/list.dart';

class PdfPage extends StatefulWidget {
  final String userId;
  const PdfPage({Key? key, required this.userId}) : super(key: key);

  @override
  State<PdfPage> createState() => _PdfPageState();
}

class _PdfPageState extends State<PdfPage> {
  SharedPref sharedPref = SharedPref();
  String message = "";
  bool isProcess = true;
  List listData = [];

  final ScrollController _scrollController = ScrollController();
  var offset = 0;
  var limit = 10;

  final fieldKeyword = TextEditingController();
  String search = "";

  searchData(keyword) {
    setState(() {
      isProcess = true;

      search = keyword;

      offset = 0;
      listData = [];
    });

    getData(keyword, limit, offset);
  }

  getData(keyword, limit, offset) async {
    try {
      var url = Uri.parse(ApiService.getFilemanager);
      var response = await http.post(url, body: {
        'user_id': widget.userId,
        'type': '3',
        'limit': limit.toString(),
        'offset': offset.toString(),
        'keyword': keyword,
      });
      var content = json.decode(response.body);

      if (content['status'] == true) {
        setState(() {
          if (listData.isEmpty) {
            listData = content['data']['lists'];
          } else {
            listData.addAll(content['data']['lists'].toList());
          }
        });
      } else {
        // ignore: use_build_context_synchronously
        onBasicAlertPressed(context, 'Error', content['message']);
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      onBasicAlertPressed(context, 'Error', e.toString());
    }

    setState(() {
      isProcess = false;
    });
  }

  void checkSession() async {
    getData(search, limit, offset);
  }

  @override
  void initState() {
    checkSession();

    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        setState(() {
          offset = offset + 10;
        });

        getData(search, limit, offset);
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
        title: const Text("File Pdf"),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: !isProcess ? PdfList(data: listData) : loaderDialog(context),
      ),
    );
  }
}
