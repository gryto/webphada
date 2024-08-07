import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../src/api.dart';

class ContentBloc {
  final StreamController<Object> _eventController = StreamController();
  StreamSink get eventSink => _eventController.sink;

  final StreamController _stateController = StreamController();
  StreamSink get _stateSink => _stateController.sink;
  Stream get stateStream => _stateController.stream;

  _mapEventToState(param) async {
    var url = Uri.parse(ApiService.searchContent);
    var response = await http.post(url, body: param);
    var content = json.decode(response.body);

    _stateSink.add(content);
  }

  ContentBloc() {
    _eventController.stream.listen(_mapEventToState);
  }

  void dispose() {
    _eventController.close();
    _stateController.close();
  }
}
