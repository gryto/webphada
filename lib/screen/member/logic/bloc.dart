import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MemberBloc {
  final StreamController<Object> _eventController = StreamController();
  StreamSink get eventSink => _eventController.sink;

  final StreamController _stateController = StreamController();
  StreamSink get _stateSink => _stateController.sink;
  Stream get stateStream => _stateController.stream;

  _mapEventToState(url) async {
    var response = await http.get(url);
    var content = json.decode(response.body);

    _stateSink.add(content);
  }

  MemberBloc() {
    _eventController.stream.listen(_mapEventToState);
  }

  void dispose() {
    _eventController.close();
    _stateController.close();
  }
}
