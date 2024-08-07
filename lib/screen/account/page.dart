import 'package:flutter/material.dart';
import 'logic/bloc.dart';
import 'logic/model.dart';
import 'component/profile.dart';

class AccountPage extends StatefulWidget {
  final String userId;
  const AccountPage({Key? key, required this.userId}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  AccountBloc accountBloc = AccountBloc();
  Data? dataInfo;

  @override
  void initState() {
    accountBloc.eventSink.add({
      'user_id': widget.userId,
    });

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Padding(
        padding: const EdgeInsets.all(2),
        child: StreamBuilder(
          stream: accountBloc.stateStream,
          builder: (context, snapshot) {
            final dataAccount = parseUser(snapshot.data);
            Data? dataResult = snapshot.hasData ? dataAccount.data : null;

            return ProfileUser(data: snapshot.hasData ? dataResult : null);
          },
        ),
      ),
    );
  }
}
