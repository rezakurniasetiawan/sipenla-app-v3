import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:siakad_app/widget/gradient_text.dart';
import 'package:siakad_app/widget/laporan-keuangan/administrasi-lain-page/menu_administrasi_lain.dart';
import 'package:siakad_app/widget/laporan-keuangan/bayar-page/menu_bayar_page.dart';
import 'package:siakad_app/widget/laporan-keuangan/denda-page/menu-denda.dart';
import 'package:siakad_app/widget/laporan-keuangan/isi-saldo-page/menu_isi_saldo.dart';
import 'package:siakad_app/widget/laporan-keuangan/riwayat-transaksi-page/riwayat_transaksi_page.dart';
import 'package:siakad_app/widget/laporan-keuangan/spp-page/menu_spp.dart';
import 'package:siakad_app/widget/laporan-keuangan/tabungan-page/menu_tabungan.dart';
import 'package:siakad_app/widget/laporan-keuangan/tarik-saldo_page/menu_tarik_saldo.dart';
import 'package:http/http.dart' as http;

import '../../constan.dart';
import '../../models/api_response_model.dart';
import '../../models/laporan_keuangan_models.dart';
import '../../screens/started_screen.dart';
import '../../services/auth_service.dart';
import '../../services/laporan_keuangan_service.dart';
import 'isi-saldo-page/isi-saldo/isi_saldo.dart';

class LaporanKeuanganScreen extends StatefulWidget {
  const LaporanKeuanganScreen({Key? key, required this.role}) : super(key: key);

  final String role;

  @override
  State<LaporanKeuanganScreen> createState() => _LaporanKeuanganScreenState();
}

class _LaporanKeuanganScreenState extends State<LaporanKeuanganScreen> {
  String balanceku = '';
  Future getBalance() async {
    String token = await getToken();
    final response = await http.get(
      Uri.parse(baseURL + '/api/topup/getsaldo'),
      headers: {
        'X-Requested-With': 'XMLHttpRequest',
        'Authorization': 'Bearer $token'
      },
    );
    print(response.body);
    if (response.statusCode == 200) {
      int jsonData = json.decode(response.body)['data']['balance'];
      setState(() {
        balanceku = jsonData.toString();
      });
    }
  }

  final formatter = NumberFormat.simpleCurrency(locale: 'id_ID');
  static String convertToIdr(dynamic number, int decimalDigit) {
    NumberFormat currencyFormatter = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp ',
      decimalDigits: decimalDigit,
    );
    return currencyFormatter.format(number);
  }

  bool _loading = true;
  List<dynamic> riwyattransaksiList = [];
  Future<void> fungsigetRiwayatTransaksibyUser() async {
    ApiResponse response = await getRiwayatTransaksibyUser();
    if (response.error == null) {
      setState(() {
        riwyattransaksiList = response.data as List<dynamic>;
        _loading = _loading ? !_loading : _loading;
      });
    } else if (response.error == unauthorized) {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => const GetStartedScreen()),
                (route) => false)
          });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${response.error}'),
      ));
    }
  }

  @override
  void initState() {
    super.initState();
    getBalance();
    fungsigetRiwayatTransaksibyUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Laporan Keuangan",
          style: TextStyle(
            fontSize: 20,
            color: Color(0xff4B556B),
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w800,
            letterSpacing: 1,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Color(0xff4B556B),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  "Saldo",
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xff4B556B),
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1,
                  ),
                ),
              ),
              Center(
                child: GradientText(
                  balanceku == ''
                      ? 'Rp 0'
                      : FormatCurrency.convertToIdr(int.parse(balanceku), 0),
                  style: const TextStyle(
                    fontSize: 28,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                  ),
                  gradient: LinearGradient(colors: [
                    Color(0xff2E447C),
                    Color(0xff3774C3),
                  ]),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xff4B556B),
                    ),
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MenuIsiSaldo(
                                            role: widget.role,
                                          )));
                            },
                            child: SizedBox(
                              width: 80,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 50,
                                    child: Image.asset(
                                        'assets/icons/isi-saldo.png'),
                                  ),
                                  const Text(
                                    "Isi Saldo",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xff4B556B),
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MenuBayarPage(
                                            role: widget.role,
                                          )));
                            },
                            child: SizedBox(
                              width: 80,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 50,
                                    child:
                                        Image.asset('assets/icons/bayar.png'),
                                  ),
                                  const Text(
                                    "Bayar",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xff4B556B),
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MenuTarikSaldo(
                                            role: widget.role,
                                          )));
                            },
                            child: SizedBox(
                              width: 80,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 50,
                                    child: Image.asset(
                                        'assets/icons/tarik-saldo.png'),
                                  ),
                                  const Text(
                                    "Tarik Saldo",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xff4B556B),
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          RiwayatTransaksiPage()));
                            },
                            child: SizedBox(
                              width: 80,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 50,
                                    child: Image.asset(
                                        'assets/icons/riwayat-saldo.png'),
                                  ),
                                  const Text(
                                    "Riwayat \n Transaksi",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xff4B556B),
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              widget.role == 'student'
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MenuSpp(
                                          role: widget.role,
                                        )));
                          },
                          child: SizedBox(
                            width: 72,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 40,
                                  child: Image.asset('assets/icons/spp2.png'),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  "SPP",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Color(0xff4B556B),
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 72,
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: (() {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MenuTabungan(
                                                role: widget.role,
                                              )));
                                }),
                                child: SizedBox(
                                  height: 40,
                                  child:
                                      Image.asset('assets/icons/tabungan2.png'),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                "Tabungan",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Color(0xff4B556B),
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 1,
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MenuDenda(
                                          role: widget.role,
                                        )));
                          },
                          child: SizedBox(
                            width: 72,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 40,
                                  child: Image.asset('assets/icons/denda2.png'),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  "Denda",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Color(0xff4B556B),
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MenuAdministrasiLain(
                                          role: widget.role,
                                        )));
                          },
                          child: SizedBox(
                            width: 75,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 40,
                                  child:
                                      Image.asset('assets/icons/adm-lain2.png'),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  "Administrasi Lain - Lain",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Color(0xff4B556B),
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  : widget.role == 'walimurid'
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MenuSpp(
                                              role: widget.role,
                                            )));
                              },
                              child: SizedBox(
                                width: 72,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 40,
                                      child:
                                          Image.asset('assets/icons/spp2.png'),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Text(
                                      "SPP",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Color(0xff4B556B),
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 1,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 72,
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: (() {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  MenuTabungan(
                                                    role: widget.role,
                                                  )));
                                    }),
                                    child: SizedBox(
                                      height: 40,
                                      child: Image.asset(
                                          'assets/icons/tabungan2.png'),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text(
                                    "Tabungan",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Color(0xff4B556B),
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MenuDenda(
                                              role: widget.role,
                                            )));
                              },
                              child: SizedBox(
                                width: 72,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 40,
                                      child: Image.asset(
                                          'assets/icons/denda2.png'),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Text(
                                      "Denda",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Color(0xff4B556B),
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 1,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            MenuAdministrasiLain(
                                              role: widget.role,
                                            )));
                              },
                              child: SizedBox(
                                width: 75,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 40,
                                      child: Image.asset(
                                          'assets/icons/adm-lain2.png'),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Text(
                                      "Administrasi Lain - Lain",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Color(0xff4B556B),
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 1,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      : widget.role == 'tu'
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => MenuSpp(
                                                  role: widget.role,
                                                )));
                                  },
                                  child: SizedBox(
                                    width: 72,
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 40,
                                          child: Image.asset(
                                              'assets/icons/spp2.png'),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const Text(
                                          "SPP",
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: Color(0xff4B556B),
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w600,
                                            letterSpacing: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 72,
                                  child: Column(
                                    children: [
                                      GestureDetector(
                                        onTap: (() {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      MenuTabungan(
                                                        role: widget.role,
                                                      )));
                                        }),
                                        child: SizedBox(
                                          height: 40,
                                          child: Image.asset(
                                              'assets/icons/tabungan2.png'),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      const Text(
                                        "Tabungan",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Color(0xff4B556B),
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 1,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => MenuDenda(
                                                  role: widget.role,
                                                )));
                                  },
                                  child: SizedBox(
                                    width: 72,
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 40,
                                          child: Image.asset(
                                              'assets/icons/denda2.png'),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const Text(
                                          "Denda",
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: Color(0xff4B556B),
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w600,
                                            letterSpacing: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                MenuAdministrasiLain(
                                                  role: widget.role,
                                                )));
                                  },
                                  child: SizedBox(
                                    width: 75,
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 40,
                                          child: Image.asset(
                                              'assets/icons/adm-lain2.png'),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const Text(
                                          "Administrasi Lain - Lain",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: Color(0xff4B556B),
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w600,
                                            letterSpacing: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : widget.role == 'kepsek'
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => MenuSpp(
                                                      role: widget.role,
                                                    )));
                                      },
                                      child: SizedBox(
                                        width: 72,
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 40,
                                              child: Image.asset(
                                                  'assets/icons/spp2.png'),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            const Text(
                                              "SPP",
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: Color(0xff4B556B),
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w600,
                                                letterSpacing: 1,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 72,
                                      child: Column(
                                        children: [
                                          GestureDetector(
                                            onTap: (() {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          MenuTabungan(
                                                            role: widget.role,
                                                          )));
                                            }),
                                            child: SizedBox(
                                              height: 40,
                                              child: Image.asset(
                                                  'assets/icons/tabungan2.png'),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          const Text(
                                            "Tabungan",
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: Color(0xff4B556B),
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w600,
                                              letterSpacing: 1,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => MenuDenda(
                                                      role: widget.role,
                                                    )));
                                      },
                                      child: SizedBox(
                                        width: 72,
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 40,
                                              child: Image.asset(
                                                  'assets/icons/denda2.png'),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            const Text(
                                              "Denda",
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: Color(0xff4B556B),
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w600,
                                                letterSpacing: 1,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    MenuAdministrasiLain(
                                                      role: widget.role,
                                                    )));
                                      },
                                      child: SizedBox(
                                        width: 75,
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 40,
                                              child: Image.asset(
                                                  'assets/icons/adm-lain2.png'),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            const Text(
                                              "Administrasi Lain - Lain",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: Color(0xff4B556B),
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w600,
                                                letterSpacing: 1,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : widget.role == 'admin'
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        MenuSpp(
                                                          role: widget.role,
                                                        )));
                                          },
                                          child: SizedBox(
                                            width: 72,
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  height: 40,
                                                  child: Image.asset(
                                                      'assets/icons/spp2.png'),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                const Text(
                                                  "SPP",
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    color: Color(0xff4B556B),
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w600,
                                                    letterSpacing: 1,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 72,
                                          child: Column(
                                            children: [
                                              GestureDetector(
                                                onTap: (() {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              MenuTabungan(
                                                                role:
                                                                    widget.role,
                                                              )));
                                                }),
                                                child: SizedBox(
                                                  height: 40,
                                                  child: Image.asset(
                                                      'assets/icons/tabungan2.png'),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              const Text(
                                                "Tabungan",
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  color: Color(0xff4B556B),
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w600,
                                                  letterSpacing: 1,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        MenuDenda(
                                                          role: widget.role,
                                                        )));
                                          },
                                          child: SizedBox(
                                            width: 72,
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  height: 40,
                                                  child: Image.asset(
                                                      'assets/icons/denda2.png'),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                const Text(
                                                  "Denda",
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    color: Color(0xff4B556B),
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w600,
                                                    letterSpacing: 1,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        MenuAdministrasiLain(
                                                          role: widget.role,
                                                        )));
                                          },
                                          child: SizedBox(
                                            width: 75,
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  height: 40,
                                                  child: Image.asset(
                                                      'assets/icons/adm-lain2.png'),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                const Text(
                                                  "Administrasi Lain - Lain",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    color: Color(0xff4B556B),
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w600,
                                                    letterSpacing: 1,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 72,
                                          child: Column(
                                            children: [
                                              GestureDetector(
                                                onTap: (() {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              MenuTabungan(
                                                                role:
                                                                    widget.role,
                                                              )));
                                                }),
                                                child: SizedBox(
                                                  height: 40,
                                                  child: Image.asset(
                                                      'assets/icons/tabungan2.png'),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              const Text(
                                                "Tabungan",
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  color: Color(0xff4B556B),
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w600,
                                                  letterSpacing: 1,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        MenuDenda(
                                                          role: widget.role,
                                                        )));
                                          },
                                          child: SizedBox(
                                            width: 72,
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  height: 40,
                                                  child: Image.asset(
                                                      'assets/icons/denda2.png'),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                const Text(
                                                  "Denda",
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    color: Color(0xff4B556B),
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w600,
                                                    letterSpacing: 1,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        MenuAdministrasiLain(
                                                          role: widget.role,
                                                        )));
                                          },
                                          child: SizedBox(
                                            width: 75,
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  height: 40,
                                                  child: Image.asset(
                                                      'assets/icons/adm-lain2.png'),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                const Text(
                                                  "Administrasi Lain - Lain",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    color: Color(0xff4B556B),
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w600,
                                                    letterSpacing: 1,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 1,
                color: const Color(0xff4B556B),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Transaksi Terakhir",
                style: TextStyle(
                  fontSize: 20,
                  color: Color(0xff4B556B),
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 300,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: riwyattransaksiList.length <= 5
                      ? riwyattransaksiList.length
                      : 5,
                  itemBuilder: (BuildContext context, int index) {
                    RiwayatTransaksibyUserModel riwayatTransaksibyUserModel =
                        riwyattransaksiList[index];
                    String tanggal = DateFormat('dd-MM-yyyy')
                        .format(riwayatTransaksibyUserModel.createdAt);
                    return Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              height: 40,
                              child: Image.asset(
                                  riwayatTransaksibyUserModel.itemName == 'SPP'
                                      ? 'assets/icons/spp2.png'
                                      : riwayatTransaksibyUserModel.itemName ==
                                              'TABUNGAN'
                                          ? 'assets/icons/tabungan2.png'
                                          : 'assets/icons/adm-lain2.png'),
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Pembayaran ${riwayatTransaksibyUserModel.itemName}",
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Color(0xff4B556B),
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                  Text(
                                    tanggal,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Color(0xff4B556B),
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            Column(
                              children: [
                                GradientText(
                                  FormatCurrency.convertToIdr(
                                      riwayatTransaksibyUserModel.grossAmount,
                                      0),
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w700,
                                  ),
                                  gradient: const LinearGradient(colors: [
                                    Color(0xff2E447C),
                                    Color(0xff3774C3),
                                  ]),
                                ),
                                const Text(
                                  "Berhasil",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xff83BC10),
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        )
                      ],
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
