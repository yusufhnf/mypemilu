import 'dart:io';
import 'package:mypemilu/pemiluModel.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'dart:async';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final formarter = new NumberFormat('#,###');
  var table;
  double total = 0;
  double jokowi = 0;
  double prabowo = 0;
  Map<String, double> dataMap = new Map();
  Future<Pemilu> fetchData() async {
    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    final url = 'https://pemilu2019.kpu.go.id/static/json/hhcw/ppwp.json';
    HttpClientRequest request = await client.getUrl(Uri.parse(url));
    HttpClientResponse response = await request.close();
    if (response.statusCode == 200) {
      print('berhasil');
      var reply = await response.transform(utf8.decoder).join();
      Map pemiluMap = json.decode(reply.toString());
      var data = Pemilu.fromJson(pemiluMap);
      setState(() {
        jokowi = data.chart.the21.toDouble();
        prabowo = data.chart.the22.toDouble();
        total = jokowi + prabowo;
        dataMap.putIfAbsent("01", () => jokowi);
        dataMap.putIfAbsent("02", () => prabowo);
      });
      return data;
    } else {
      print('gagal');
      throw Exception('Failed to load post');
    }
  }

  List<Color> colorList = [
    Colors.greenAccent,
    Colors.blueAccent,
  ];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[900],
      appBar: AppBar(
        elevation: 0.0,
        title: Text("My Pemilu - Nasional"),
        backgroundColor: Colors.red[900],
      ),
      body: total == 0
        ? Center(child: CircularProgressIndicator(backgroundColor: Colors.white,)) : 
        Container(
        padding: EdgeInsets.all(15),
        child: Card(
          child: Column(
            children: <Widget>[
              //Tampilan Chart
              PieChart(
                dataMap: dataMap, //Required parameter
                legendFontColor: Colors.blueGrey[900],
                legendFontSize: 14.0,
                legendFontWeight: FontWeight.w500,
                animationDuration: Duration(milliseconds: 800),
                chartLegendSpacing: 32.0,
                chartRadius: MediaQuery
                    .of(context)
                    .size
                    .width / 2.7,
                showChartValuesInPercentage: true,
                showChartValues: true,
                chartValuesColor: Colors.white.withOpacity(0.9),
                colorList: colorList,
                showLegends: true,
              ),
              //Tampilan Total Suara
              ListTile(
                title: Text("Total Suara:"),
                subtitle: Text('${formarter.format(total)} suara'),
              ),
              Divider(),
              //Tampilan Total Suara
              ListTile(
                leading: Text(
                  '01',
                  style: TextStyle(fontSize: 35.0, color: Colors.greenAccent),
                ),
                title: Text('Jokowi - Ma ruf'),
                subtitle: Text('${formarter.format(jokowi)} suara'),
              ),
              ListTile(
                leading: Text(
                  '02',
                  style: TextStyle(fontSize: 35.0, color: Colors.blueAccent),
                ),
                title: Text('Prabowo - Sandi'),
                subtitle: Text('${formarter.format(prabowo)} suara'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}