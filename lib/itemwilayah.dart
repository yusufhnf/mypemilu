import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class Wilayah extends StatefulWidget {
  @override
  _WilayahState createState() => _WilayahState();
}

class _WilayahState extends State<Wilayah> {
  final formarter = new NumberFormat('#,###');
  var table;
  var wilayah;

  Future<Map> fetchJumlah() async {
    HttpClient _client = new HttpClient();
    _client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    final url = 'https://pemilu2019.kpu.go.id/static/json/hhcw/ppwp.json';
    HttpClientRequest request = await _client.getUrl(Uri.parse(url));
    HttpClientResponse response = await request.close();
    if (response.statusCode == 200) {
      print('berhasil');
      var reply = await response.transform(utf8.decoder).join();
      var pemiluMap = json.decode(reply.toString());
      return pemiluMap;
    } else {
      print('gagal');
      throw Exception('Failed to load post');
    }
  }

  Future<Map> fetchWilayah() async {
    HttpClient _client = new HttpClient();
    _client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    final url = 'https://pemilu2019.kpu.go.id/static/json/wilayah/0.json';
    HttpClientRequest request = await _client.getUrl(Uri.parse(url));
    HttpClientResponse response = await request.close();
    if (response.statusCode == 200) {
      print('berhasil');
      var reply1 = await response.transform(utf8.decoder).join();
      var wilayahMap = json.decode(reply1.toString());
      return wilayahMap;
    } else {
      print('gagal');
      throw Exception('Failed to load post');
    }
  }
  
  void getData() async {
    var dataJumlah = await fetchJumlah();
    var dataWilayah = await fetchWilayah();
    if(mounted){
      setState(() {
        table = (dataJumlah['table']);
        wilayah = dataWilayah;
      });
    }
  }

    @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[900],
      appBar: AppBar(
        elevation: 0.0,
        title: Text("My Pemilu - Wilayah"),
        backgroundColor: Colors.red[900],
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: ItemWilayah(table: table, formarter: formarter, wilayah: wilayah),
      ),
    );
  }
}

class ItemWilayah extends StatelessWidget {
  const ItemWilayah({
    Key key,
    @required this.table,
    @required this.formarter,
    @required this.wilayah,
  }) : super(key: key);

  final table;
  final wilayah;
  final NumberFormat formarter;

  @override
  Widget build(BuildContext context) {
    return table == null
        ? Center(child: CircularProgressIndicator(backgroundColor: Colors.white,))
        : ListView.builder(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemCount: table.length,
            itemBuilder: (context, int i) {
              String key = table.keys.elementAt(i);
              return ListTile(
                title: Text(
                  wilayah[key]['nama'],
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: Text(
                    '01: ${formarter.format(table[key]['21'])} | 02: ${formarter.format(table[key]['22'])}',
                    style: TextStyle(color: Colors.white)),
                trailing: IconButton(
                  icon: Icon(
                    Icons.keyboard_arrow_right,
                    color: Colors.white,
                  ),
                  onPressed: null,
                ),
              );
            },
          );
  }
}