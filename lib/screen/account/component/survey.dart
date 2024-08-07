import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../../../src/api.dart';
import '../../../src/constant.dart';
import '../../../src/loader.dart';

class SurveyUser extends StatefulWidget {
  final String userId;
  const SurveyUser({Key? key, required this.userId}) : super(key: key);

  @override
  State<SurveyUser> createState() => _SurveyUserState();
}

class _SurveyUserState extends State<SurveyUser> {
  String message = "";
  bool isProcess = false;
  final cntrlDescription = TextEditingController();

  double initialValue = 0.0;
  String description = "";

  setSurveyProcess(value, description) async {
    setState(() {
      isProcess = true;
    });

    try {
      var response = await http.post(Uri.parse(ApiService.setSurvey), headers: {
        'Accept': 'application/json'
      }, body: {
        "user_id": widget.userId,
        "value": value.toString(),
        "description": description.toString()
      });

      var content = json.decode(response.body);
      print("content:" + content.toString());

      // ignore: use_build_context_synchronously
      _onAlertButtonPressed(context, content['status'], content['message']);
    } catch (e) {
      _onAlertButtonPressed(context, false, e.toString());
    }

    setState(() {
      isProcess = false;
    });
  }

  getSurveyDetail(userId) async {
    try {
      var response = await http.post(Uri.parse(ApiService.getSurvey),
          headers: {'Accept': 'application/json'}, body: {"user_id": userId});
      var content = json.decode(response.body);
      print("content:" + content.toString());

      if (content['status'] == true) {
        if (content['data'] != null) {
          setState(() {
            initialValue = content['data']['survey_value'].toDouble();
            description = content['data']['survey_description'];
            cntrlDescription.text = description;
          });
        }
      } else {
        initialValue = 0.0;
        description = "";
      }
    } catch (e) {
      _onAlertButtonPressed(context, false, e.toString());
    }
  }

  _onAlertButtonPressed(context, status, message) {
    Alert(
      context: context,
      type: !status ? AlertType.error : AlertType.success,
      title: "",
      desc: message.toString(),
      buttons: [
        DialogButton(
          onPressed: () => Navigator.pop(context),
          width: 120,
          child: const Text(
            "OK",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        )
      ],
    ).show();
  }

  @override
  void initState() {
    getSurveyDetail(widget.userId);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height - 20;
    double w = MediaQuery.of(context).size.width - 0;

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: clrPrimary,
        title: const Text("Survey Aplikasi"),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            //mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 50.0,
              ),
              const CircleAvatar(
                radius: 60,
                backgroundColor: clrPrimary,
                child: CircleAvatar(
                  radius: 55,
                  backgroundImage: AssetImage("assets/images/icon.png"),
                ),
              ),
              const SizedBox(height: 70),
              RatingBar.builder(
                initialRating: initialValue,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                unratedColor: Colors.grey.shade400,
                itemSize: 50.0,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  setState(() {
                    initialValue = (rating);
                  });
                },
                updateOnDrag: true,
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                controller: cntrlDescription,
                maxLines: 8,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide.none),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  hintText: 'Keterangan tambahan ...',
                  hintStyle:
                      TextStyle(color: Theme.of(context).colorScheme.onSurface),
                ),
              ),
              const SizedBox(height: 30),
              !isProcess
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: SizedBox(
                        width: w,
                        height: h / 14.7,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: clrPrimary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            setSurveyProcess(
                              initialValue,
                              cntrlDescription.text,
                            );
                          },
                          child: const Text(
                            "Kirim Survei",
                            style: TextStyle(fontSize: 19),
                          ),
                        ),
                      ),
                    )
                  : loaderDialog(context),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  // Widget ratingBar() {
  //   return RatingBar.builder(
  //     initialRating: 3,
  //     minRating: 1,
  //     direction: Axis.horizontal,
  //     allowHalfRating: true,
  //     unratedColor: Colors.amber.withAlpha(50),
  //     itemSize: 50.0,
  //     itemCount: 5,
  //     itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
  //     itemBuilder: (context, _) => const Icon(
  //       Icons.star,
  //       color: Colors.amber,
  //     ),
  //     onRatingUpdate: (rating) {
  //       print(rating);
  //     },
  //     // itemBuilder: (context, _) => Icon(
  //     //       _selectedIcon ?? Icons.star,
  //     //       color: Colors.amber,
  //     //     ),
  //     //     onRatingUpdate: (rating) {
  //     //       setState(() {
  //     //         _rating = rating;
  //     //       });
  //     //     },
  //     updateOnDrag: true,
  //   );
  // }
}
