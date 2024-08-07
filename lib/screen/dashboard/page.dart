import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../src/api.dart';
import '../../src/constant.dart';
import '../../src/preference.dart';
import '../filemanager/image/page.dart';
import '../notification/page.dart';
import '../filemanager/pdf/page.dart';
import '../filemanager/video/page.dart';
import 'component/search.dart';

class DashboardPage extends StatefulWidget {
  // final data;
  final String userId;
  const DashboardPage({Key? key, required this.userId}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  SharedPref sharedPref = SharedPref();
  String url = ApiService.getDashboard;
  String message = "";
  bool isProcess = false;

  final _keyword = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  int maxLinechart = 0;
  List dataLinechart = [];
  num lineVal0 = 0;
  num lineVal1 = 0;
  num lineVal2 = 0;
  num lineVal3 = 0;
  num lineVal4 = 0;
  num lineVal5 = 0;
  num lineVal6 = 0;

  String lineTxt0 = "";
  String lineTxt1 = "";
  String lineTxt2 = "";
  String lineTxt3 = "";
  String lineTxt4 = "";
  String lineTxt5 = "";
  String lineTxt6 = "";

  List dataPiechart = [];
  num pieVal0 = 0;
  num pieVal1 = 0;
  num pieVal2 = 0;
  num pieVal3 = 0;
  num pieVal4 = 0;

  String pieTxt0 = "";
  String pieTxt1 = "";
  String pieTxt2 = "";
  String pieTxt3 = "";
  String pieTxt4 = "";

  int touchedIndex = -1;

  String fullName = "";
  String typeUser = "";

  void checkSession() async {
    var userFullname = await sharedPref.getPref("user_fullname");
    var userType = await sharedPref.getPref("user_type");

    setState(() {
      fullName = userFullname;
      typeUser = userType == "1" ? 'Administrator' : 'Operator';
    });

    await getDashboard();
  }

  getDashboard() async {
    setState(() {
      isProcess = true;
    });

    try {
      var response = await http.post(Uri.parse(url),
          headers: {'Accept': 'application/json'},
          body: {"user_id": widget.userId, "mobile": "1"});
      var content = json.decode(response.body);

      if (content['status'] == true) {
        setState(() {
          dataLinechart = content['data']['linechart']['arr'];
          lineVal0 = dataLinechart[0]['count'];
          lineVal1 = dataLinechart[1]['count'];
          lineVal2 = dataLinechart[2]['count'];
          lineVal3 = dataLinechart[3]['count'];
          lineVal4 = dataLinechart[4]['count'];
          lineVal5 = dataLinechart[5]['count'];
          lineVal6 = dataLinechart[6]['count'];

          var tempLinechart = [
            lineVal0.toInt(),
            lineVal1.toInt(),
            lineVal2.toInt(),
            lineVal3.toInt(),
            lineVal4.toInt(),
            lineVal5.toInt(),
            lineVal6.toInt()
          ];

          maxLinechart = tempLinechart.reduce(max);
          maxLinechart = maxLinechart + 2;

          lineTxt0 = dataLinechart[0]['title'];
          lineTxt1 = dataLinechart[1]['title'];
          lineTxt2 = dataLinechart[2]['title'];
          lineTxt3 = dataLinechart[3]['title'];
          lineTxt4 = dataLinechart[4]['title'];
          lineTxt5 = dataLinechart[5]['title'];
          lineTxt6 = dataLinechart[6]['title'];

          dataPiechart = content['data']['piechart']['arr'];
          pieVal0 = dataPiechart[0]['count'];
          pieVal1 = dataPiechart[1]['count'];
          pieVal2 = dataPiechart[2]['count'];
          pieVal3 = dataPiechart[3]['count'];
          pieVal4 = dataPiechart[4]['count'];

          pieTxt0 = dataPiechart[0]['title'];
          pieTxt1 = dataPiechart[1]['title'];
          pieTxt2 = dataPiechart[2]['title'];
          pieTxt3 = dataPiechart[3]['title'];
          pieTxt4 = dataPiechart[4]['title'];
        });
      } else {
        // ignore: use_build_context_synchronously
        _onAlertButtonPressed(context, content['status'], content['message']);
      }
    } catch (e) {
      _onAlertButtonPressed(context, false, e.toString());
    }

    setState(() {
      isProcess = false;
    });
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
    checkSession();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: clrPrimary,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(top: 35, bottom: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                fullName,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                typeUser,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => NotificationPage(
                    userId: widget.userId.toString(),
                  ),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  color: clrPrimary),
              child: const Icon(
                Icons.notifications,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: const Color.fromARGB(137, 223, 223, 223),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 45,
                    decoration: const BoxDecoration(
                      color: clrPrimary,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 15,
                      right: 15,
                    ),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 3,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(5),
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                child: Form(
                                  key: _formKey,
                                  child: TextFormField(
                                    controller: _keyword,
                                    keyboardType: TextInputType.text,
                                    autofocus: false,
                                    onFieldSubmitted: (value) {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => SearchContent(
                                              userId: widget.userId,
                                              keyword: value),
                                        ),
                                      );
                                    },
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          borderSide: BorderSide.none),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 0),
                                      prefixIcon: Icon(
                                        Icons.search_outlined,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface,
                                        size: 20,
                                      ),
                                      hintText: 'Search advance engine ...',
                                      hintStyle: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurface),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Grafik kunjungan website',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        padding: const EdgeInsets.only(
                            left: 15, right: 20, top: 45, bottom: 20),
                        height: 165,
                        child: LineChart(
                          LineChartData(
                            maxY: maxLinechart.toDouble(),
                            borderData: FlBorderData(show: false),
                            titlesData: FlTitlesData(
                              topTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              rightTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              leftTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  getTitlesWidget: leftTitleWidgets,
                                  interval: 10,
                                  reservedSize: 15,
                                ),
                              ),
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  getTitlesWidget: getTitles,
                                  interval: 1,
                                  reservedSize: 15,
                                ),
                              ),
                            ),
                            lineBarsData: [
                              LineChartBarData(
                                color: Colors.green,
                                spots: [
                                  FlSpot(0, lineVal0.toDouble()),
                                  FlSpot(1, lineVal1.toDouble()),
                                  FlSpot(2, lineVal2.toDouble()),
                                  FlSpot(3, lineVal3.toDouble()),
                                  FlSpot(4, lineVal4.toDouble()),
                                  FlSpot(5, lineVal5.toDouble()),
                                  FlSpot(6, lineVal6.toDouble()),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Indeks kepuasan terkini',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Container(
                            width: 152,
                            height: 152,
                            color: Colors.white,
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: PieChart(
                                  PieChartData(
                                    pieTouchData: PieTouchData(
                                      touchCallback: (FlTouchEvent event,
                                          pieTouchResponse) {
                                        setState(() {
                                          if (!event
                                                  .isInterestedForInteractions ||
                                              pieTouchResponse == null ||
                                              pieTouchResponse.touchedSection ==
                                                  null) {
                                            touchedIndex = -1;
                                            return;
                                          }
                                          touchedIndex = pieTouchResponse
                                              .touchedSection!
                                              .touchedSectionIndex;
                                        });
                                      },
                                    ),
                                    startDegreeOffset: 180,
                                    borderData: FlBorderData(
                                      show: false,
                                    ),
                                    sectionsSpace: 1,
                                    centerSpaceRadius: 10,
                                    sections: showingSections(),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2.0),
                                color: Colors.white,
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(left: 5),
                                            child: Text(
                                              pieTxt0,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 60,
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(right: 5),
                                            child: Text(
                                              pieVal0.toString(),
                                              textAlign: TextAlign.right,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Divider(
                                    height: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(left: 5),
                                            child: Text(
                                              pieTxt1,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 60,
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(right: 5),
                                            child: Text(
                                              pieVal1.toString(),
                                              textAlign: TextAlign.right,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Divider(
                                    height: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(left: 5),
                                            child: Text(
                                              pieTxt2,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 60,
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(right: 5),
                                            child: Text(
                                              pieVal2.toString(),
                                              textAlign: TextAlign.right,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Divider(
                                    height: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(left: 5),
                                            child: Text(
                                              pieTxt3,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 60,
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(right: 5),
                                            child: Text(
                                              pieVal3.toString(),
                                              textAlign: TextAlign.right,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Divider(
                                    height: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(left: 5),
                                            child: Text(
                                              pieTxt4,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 60,
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(right: 5),
                                            child: Text(
                                              pieVal4.toString(),
                                              textAlign: TextAlign.right,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ImagePage(
                              userId: widget.userId,
                              // userId: widget.userId.toString(),
                            ),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            color: Colors.white),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  child: Container(
                                    padding: const EdgeInsets.all(7),
                                    color: clrPrimary,
                                    child: const Icon(
                                      Icons.image,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      'File Gambar',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'File gambar yang tersimpan',
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 15),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            const Icon(
                              Icons.arrow_forward_ios_sharp,
                              size: 15,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => VideoPage(
                              userId: widget.userId,
                              // userId: widget.userId.toString(),
                            ),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            color: Colors.white),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  child: Container(
                                    padding: const EdgeInsets.all(7),
                                    color: clrPrimary,
                                    child: const Icon(
                                      Icons.movie,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      'File Video',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'File video yang tersimpan',
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 15),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            const Icon(
                              Icons.arrow_forward_ios_sharp,
                              size: 15,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => PdfPage(
                              userId: widget.userId,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            color: Colors.white),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  child: Container(
                                    padding: const EdgeInsets.all(7),
                                    color: clrPrimary,
                                    child: const Icon(
                                      Icons.picture_as_pdf,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      'File PDF',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'File pdf yang tersimpan',
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 15),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            const Icon(
                              Icons.arrow_forward_ios_sharp,
                              size: 15,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 55,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.blueGrey,
      fontWeight: FontWeight.bold,
      fontSize: 6,
    );
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(meta.formattedValue, style: style),
    );
  }

  Widget getTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 5,
    );

    String label = "";
    int index = value.toInt();
    switch (index) {
      case 0:
        label = lineTxt0;
        break;
      case 1:
        label = lineTxt1;
        break;
      case 2:
        label = lineTxt2;
        break;
      case 3:
        label = lineTxt3;
        break;
      case 4:
        label = lineTxt4;
        break;
      case 5:
        label = lineTxt5;
        break;
      case 6:
        label = lineTxt6;
        break;
    }

    Widget text;
    text = Text(label, style: style);

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: text,
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(
      5,
      (i) {
        final isTouched = i == touchedIndex;
        const color0 = clrPrimary;
        const color1 = Color.fromARGB(255, 219, 175, 41);
        const color2 = Color.fromARGB(255, 221, 111, 90);
        const color3 = Color.fromARGB(255, 102, 174, 167);
        const color4 = Color.fromARGB(255, 146, 80, 204);

        switch (i) {
          case 0:
            return PieChartSectionData(
              color: color0,
              value: pieVal0.toDouble(),
              title: pieVal0.toString(),
              radius: 50,
              //titlePositionPercentageOffset: 0.55,
              borderSide: isTouched
                  ? const BorderSide(color: Colors.white, width: 6)
                  : BorderSide(color: Colors.white.withOpacity(0)),
            );
          case 1:
            return PieChartSectionData(
              color: color1,
              value: pieVal1.toDouble(),
              title: pieVal1.toString(),
              radius: 50,
              //titlePositionPercentageOffset: 0.55,
              borderSide: isTouched
                  ? const BorderSide(color: Colors.white, width: 6)
                  : BorderSide(color: Colors.white.withOpacity(0)),
            );
          case 2:
            return PieChartSectionData(
              color: color2,
              value: pieVal2.toDouble(),
              title: pieVal2.toString(),
              radius: 50,
              //titlePositionPercentageOffset: 0.6,
              borderSide: isTouched
                  ? const BorderSide(color: Colors.white, width: 6)
                  : BorderSide(color: Colors.white.withOpacity(0)),
            );
          case 3:
            return PieChartSectionData(
              color: color3,
              value: pieVal3.toDouble(),
              title: pieVal3.toString(),
              radius: 50,
              //titlePositionPercentageOffset: 0.55,
              borderSide: isTouched
                  ? const BorderSide(color: Colors.white, width: 6)
                  : BorderSide(color: Colors.white.withOpacity(0)),
            );
          case 4:
            return PieChartSectionData(
              color: color4,
              value: pieVal4.toDouble(),
              title: pieVal4.toString(),
              radius: 50,
              //titlePositionPercentageOffset: 0.55,
              borderSide: isTouched
                  ? const BorderSide(color: Colors.white, width: 6)
                  : BorderSide(color: Colors.white.withOpacity(0)),
            );
          default:
            throw Error();
        }
      },
    );
  }
}
