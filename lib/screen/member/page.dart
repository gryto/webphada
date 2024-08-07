import 'package:flutter/material.dart';
import '../../src/api.dart';
import '../../src/preference.dart';
import 'component/list.dart';
import 'logic/bloc.dart';
import 'logic/model.dart';

class MemberPage extends StatefulWidget {
  const MemberPage({Key? key}) : super(key: key);

  @override
  State<MemberPage> createState() => _MemberPageState();
}

class _MemberPageState extends State<MemberPage> {
  SharedPref sharedPref = SharedPref();
  MemberBloc memberBloc = MemberBloc();
  var url = Uri.parse(ApiService.getSatker);

  var keyword = "";
  var limit = 10;
  var offset = 0;
  List<Data>? dataList;
  final fieldKeyword = TextEditingController();

  @override
  void initState() {
    memberBloc.eventSink.add(url);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: ListView(
        children: [
          StreamBuilder(
            stream: memberBloc.stateStream,
            builder: (context, snapshot) {
              final dataSatker = parseSatker(snapshot.data);
              List<Data>? dataResult =
                  snapshot.hasData ? dataSatker.data : null;

              if (snapshot.hasData) {
                if (dataList == null) {
                  dataList = dataResult!;
                } else {
                  dataList!.addAll(dataResult!.toList());
                }
              }
              return SatkerList(
                data: dataList,
              );
            },
          ),
        ],
      ),
    );
  }
}
