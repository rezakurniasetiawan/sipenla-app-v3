import 'package:flutter/material.dart';

import '../../../../models/laporan_keuangan_models.dart';

class KonfirmasiIsiSaldo extends StatefulWidget {
  const KonfirmasiIsiSaldo(
      {Key? key,
      required this.codeTrans,
      required this.totalIsiSaldo,
      required this.expire})
      : super(key: key);

  final String codeTrans, totalIsiSaldo, expire;

  @override
  State<KonfirmasiIsiSaldo> createState() => _KonfirmasiIsiSaldoState();
}

class _KonfirmasiIsiSaldoState extends State<KonfirmasiIsiSaldo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Color(0xff4B556B),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  "Pembayaran Isi Saldo",
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xff4B556B),
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1,
                  ),
                ),
              ),
              Center(
                child: Text(
                  'Rp ${widget.totalIsiSaldo}',
                  style: const TextStyle(
                    fontSize: 26,
                    color: Color(0xff4B556B),
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Center(
                child: Text(
                  "Paling Lambat",
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xff4B556B),
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1,
                  ),
                ),
              ),
              Center(
                child: Text(
                  widget.expire,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Color(0xff4B556B),
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 1,
                      color: const Color(0xff4B556B),
                    ),
                  ),
                  SizedBox(
                    height: 80,
                    child: Image.asset('assets/icons/pembelian22.png'),
                  ),
                  Expanded(
                    child: Container(
                      height: 1,
                      width: 50,
                      color: const Color(0xff4B556B),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 80,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    border: Border.all(
                      width: 2,
                      color: const Color(0xff3774C3),
                    ),
                    borderRadius: BorderRadius.circular(12)),
                child: Center(
                  child: Text(
                    widget.codeTrans,
                    style: const TextStyle(
                      fontSize: 28,
                      color: Color(0xff3578C7),
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Nominal Top Up',
                style: TextStyle(
                  fontSize: 20,
                  color: Color(0xff4B556B),
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Rp ${widget.totalIsiSaldo}',
                style: const TextStyle(
                  fontSize: 20,
                  color: Color(0xff4B556B),
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 1,
                width: MediaQuery.of(context).size.width,
                color: const Color(0xff4B556B),
              ),
              const SizedBox(
                height: 20,
              ),
              const Center(
                child: Text(
                  'Cara Pembayaran',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xff4B556B),
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Center(
                child: Container(
                  height: 2,
                  width: MediaQuery.of(context).size.width * 0.32,
                  color: const Color(0xff4B556B),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const ItemListPembayaran(
                title: '1.',
                value:
                    'Sampaikan Kepada Pegawai Kantin Untuk Melakukan Isi Saldo SIPENLA',
              ),
              const ItemListPembayaran(
                title: '2.',
                value: 'Tunjukkan Kode Ke Kasir',
              ),
              const ItemListPembayaran(
                title: '3.',
                value: 'Lakukanlah Pembayaran Dalam Waktu 1 x 24 Jam',
              ),
              const ItemListPembayaran(
                title: '4.',
                value: 'Saldo Akan Bertambah Otomatis Paling Lama 1 x 24 Jam',
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Container(
                        child: AlertDialog(
                          actions: [
                            Column(
                              children: [
                                SizedBox(
                                  height: 85,
                                  width: 85,
                                  child: Image.asset(
                                      'assets/icons/warning-icon.png'),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  child: Text(
                                    'Kamu Sudah Bayar Isi Saldo Apabila klik “Sudah Bayar”, kode isi saldo tidak bisa digunakan lagi di semua koperasi',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: 'Poppins',
                                      color: Color(0xff4B556B),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 130,
                                      height: 44,
                                      decoration: BoxDecoration(
                                          color: const Color(0xffFF4238),
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text(
                                            "Batal",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700,
                                                fontFamily: 'Poppins',
                                                color: Colors.white),
                                          )),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      width: 130,
                                      height: 44,
                                      decoration: BoxDecoration(
                                          color: const Color(0xff83BC10),
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: TextButton(
                                        onPressed: () {
                                          setState(() {
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                          });
                                        },
                                        child: const Text(
                                          "Setuju",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700,
                                              fontFamily: 'Poppins',
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  );
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 55,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    gradient: const LinearGradient(
                      begin: FractionalOffset.centerLeft,
                      end: FractionalOffset.centerRight,
                      colors: [
                        Color(0xff2E447C),
                        Color(0xff3774C3),
                      ],
                    ),
                  ),
                  child: const Center(
                      child: Text(
                    "Saya Sudah Bayar",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                        color: Colors.white,
                        letterSpacing: 1),
                  )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ItemListPembayaran extends StatelessWidget {
  const ItemListPembayaran({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  final String title, value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xff4B556B),
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
              ),
            ),
            Expanded(
              child: Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xff4B556B),
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }
}
