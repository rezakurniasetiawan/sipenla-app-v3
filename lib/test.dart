import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:siakad_app/constan.dart';
import 'package:siakad_app/services/auth_service.dart';

class TestingPayment extends StatefulWidget {
  const TestingPayment({Key? key}) : super(key: key);

  @override
  State<TestingPayment> createState() => _TestingPaymentState();
}

class _TestingPaymentState extends State<TestingPayment> {
  Timer? timer;
  Future getData() async {
    String token = await getToken();
    final response = await http.get(
      Uri.parse(baseURL + '/api/payment/status/order-101c-1671387585'),
      headers: {
        'X-Requested-With': 'XMLHttpRequest',
        'Authorization': 'Bearer $token'
      },
    );
    print(response.body);
    if (response.statusCode == 200) {
      // return json.decode(response.body);
      String Belum = jsonDecode(response.body)['status_code'];
      if (Belum == '201') {
        print('Belum Bayar');
      } else {
        print('sudah Bayar');
      }
      // _streamController = jsonDecode(response.body);

    } else {
      throw Exception('Failed to load post');
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
    timer = Timer.periodic(Duration(seconds: 3), (timer) => getData());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SafeArea(
            child: Container(
          height: 100,
          width: 100,
          color: Colors.red,
          child: GestureDetector(
              onTap: () {
                getData();
              },
              child: Text('data')),
        )),
      ],
    );
  }
}
